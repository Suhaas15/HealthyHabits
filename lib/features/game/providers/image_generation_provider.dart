import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _apiUrl = 'https://openrouter.ai/api/v1/chat/completions';
const String _model = 'google/gemini-2.5-flash-image';
const String _manifestKey = '@habit_images_complete_v1';

// Module-level session cache — survives provider rebuilds within same session
final Map<String, Map<String, String>> _sessionCache = {};

class ImageProgress {
  final int done;
  final int total;
  const ImageProgress({required this.done, required this.total});
}

class ImageGenerationProvider extends ChangeNotifier {
  final String habitId;
  final Map<String, String> imagePrompts;
  final String endingPrompt;

  Map<String, String> _images = {};
  bool _isLoading = false;
  ImageProgress _progress = const ImageProgress(done: 0, total: 0);
  bool _skipped = false;

  ImageGenerationProvider({
    required this.habitId,
    required this.imagePrompts,
    required this.endingPrompt,
  });

  Map<String, String> get images => Map.unmodifiable(_images);
  bool get isLoading => _isLoading;
  ImageProgress get progress => _progress;

  List<String> get _keys => [...imagePrompts.keys, 'ending'];
  Map<String, String> get _prompts => {...imagePrompts, 'ending': endingPrompt};

  String? getImage(String sceneId, String optionId) =>
      _images['${sceneId}_$optionId'];

  String? getEndingImage() => _images['ending'];

  Future<String> _getDir() async {
    final docs = await getApplicationDocumentsDirectory();
    return '${docs.path}/habits/$habitId/';
  }

  String _getFilePath(String dir, String key) => '$dir$key.jpg';

  Future<void> _ensureDir(String dir) async {
    await Directory(dir).create(recursive: true);
  }

  // ── Manifest helpers ───────────────────────────────────────────────────────
  Future<Map<String, dynamic>> _readManifest() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_manifestKey);
      if (raw == null) return {};
      return jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      return {};
    }
  }

  Future<void> _markComplete() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final m = await _readManifest();
      m[habitId] = true;
      await prefs.setString(_manifestKey, jsonEncode(m));
    } catch (_) {}
  }

  Future<bool> _isComplete() async {
    try {
      final m = await _readManifest();
      return m[habitId] == true;
    } catch (_) {
      return false;
    }
  }

  // ── Load all images from file system ──────────────────────────────────────
  Future<Map<String, String>?> _loadFromFileSystem() async {
    try {
      final dir = await _getDir();
      final result = <String, String>{};
      for (final key in _keys) {
        final fp = _getFilePath(dir, key);
        final file = File(fp);
        if (!await file.exists()) return null;
        final stat = await file.stat();
        if (stat.size == 0) return null;
        result[key] = fp;
      }
      return result;
    } catch (_) {
      return null;
    }
  }

  // ── Save image to disk ────────────────────────────────────────────────────
  Future<void> _saveImage(String filePath, String url) async {
    if (url.startsWith('data:image/')) {
      final commaIdx = url.indexOf(',');
      if (commaIdx == -1) throw Exception('Malformed data URI');
      final base64Data = url.substring(commaIdx + 1);
      final bytes = base64Decode(base64Data);
      await File(filePath).writeAsBytes(bytes);
    } else if (url.startsWith('http')) {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        throw Exception('Download failed: ${response.statusCode}');
      }
      await File(filePath).writeAsBytes(response.bodyBytes);
    } else {
      throw Exception('Unknown URL format');
    }

    final file = File(filePath);
    if (!await file.exists()) throw Exception('File not found after write');
    final stat = await file.stat();
    if (stat.size == 0) throw Exception('File written but size is 0');
  }

  // ── Generate single image via API ─────────────────────────────────────────
  Future<String> _generateSingleImage(String prompt) async {
    final apiKey = dotenv.env['EXPO_PUBLIC_OPENROUTER_API_KEY'] ?? '';
    if (apiKey.isEmpty) throw Exception('API key not configured');

    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': _model,
        'modalities': ['text', 'image'],
        'messages': [
          {'role': 'user', 'content': prompt}
        ],
      }),
    );

    if (response.statusCode != 200) {
      String msg = 'API error: ${response.statusCode}';
      try {
        final parsed = jsonDecode(response.body);
        final errMsg = parsed['error']?['message'];
        if (errMsg != null) msg = errMsg;
      } catch (_) {}
      throw Exception(msg);
    }

    final data = jsonDecode(response.body);
    final url = _extractImageUrl(data);
    if (url != null) return url;
    throw Exception('No image in response');
  }

  String? _extractImageUrl(Map<String, dynamic> data) {
    final message = (data['choices'] as List?)?.first?['message'];
    if (message == null) return null;

    final images = message['images'];
    if (images is List && images.isNotEmpty) {
      final first = images[0];
      final url = first?['image_url']?['url'] ?? first?['url'];
      if (url is String) return url;
    }

    final content = message['content'];
    if (content is List) {
      for (final part in content) {
        if (part['type'] == 'image_url' || part['type'] == 'image') {
          final url = part['image_url']?['url'] ?? part['url'] ?? part['image']?['url'];
          if (url is String) return url;
        }
      }
    }

    if (content is String && content.startsWith('data:image/')) {
      return content;
    }

    return null;
  }

  // ── Skip loading — use null fallbacks ────────────────────────────────────
  void skipAndUseFallbacks() {
    _skipped = true;
    final map = <String, String>{};
    // Leave map empty — emoji fallbacks will show in UI
    _images = map;
    _isLoading = false;
    notifyListeners();
  }

  // ── Main generation / cache-loading logic ─────────────────────────────────
  Future<void> generateAllImages() async {
    final keys = _keys;
    final prompts = _prompts;

    // Level 1: in-component map cache
    if (_images.isNotEmpty) return;

    // Level 2: module-level session cache
    final sessionEntry = _sessionCache[habitId];
    if (sessionEntry != null && sessionEntry.length >= keys.length) {
      _images = Map.from(sessionEntry);
      _progress = ImageProgress(done: keys.length, total: keys.length);
      notifyListeners();
      return;
    }

    _skipped = false;
    _isLoading = true;
    notifyListeners();

    // Level 3: file system cache
    final cached = await _loadFromFileSystem();
    if (cached != null) {
      _sessionCache[habitId] = cached;
      _images = cached;
      _progress = ImageProgress(done: keys.length, total: keys.length);
      _isLoading = false;
      notifyListeners();
      final done = await _isComplete();
      if (!done) await _markComplete();
      return;
    }

    // Level 4: generate via LLM
    _progress = ImageProgress(done: 0, total: keys.length);
    notifyListeners();

    int completed = 0;
    int saveFailures = 0;
    final dir = await _getDir();
    await _ensureDir(dir);

    final results = await Future.wait(
      keys.map((key) async {
        try {
          final imageUrl = await _generateSingleImage(prompts[key]!);
          final filePath = _getFilePath(dir, key);
          String finalUri = imageUrl;

          try {
            await _saveImage(filePath, imageUrl);
            finalUri = filePath;
          } catch (_) {
            saveFailures++;
          }

          completed++;
          _progress = ImageProgress(done: completed, total: keys.length);
          notifyListeners();
          return MapEntry(key, finalUri);
        } catch (_) {
          completed++;
          _progress = ImageProgress(done: completed, total: keys.length);
          notifyListeners();
          return MapEntry<String, String?>(key, null);
        }
      }),
    );

    if (_skipped) return;

    final imageMap = <String, String>{};
    for (final entry in results) {
      if (entry.value != null) {
        imageMap[entry.key] = entry.value!;
      }
    }

    if (saveFailures == 0) {
      await _markComplete();
    }

    _sessionCache[habitId] = imageMap;
    _images = imageMap;
    _isLoading = false;
    notifyListeners();
  }

  void clearCache() {
    _skipped = false;
    _images = {};
    notifyListeners();
  }
}
