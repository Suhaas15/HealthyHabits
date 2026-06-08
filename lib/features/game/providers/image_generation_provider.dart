import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _apiUrl = 'https://openrouter.ai/api/v1/chat/completions';
const String _model = 'google/gemini-2.5-flash-image';
const String _manifestKey = '@habit_images_manifest_v2';
const Duration _networkTimeout = Duration(seconds: 25);
const int _maxRetriesPerImage = 3;

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
  String? _errorMessage;

  ImageGenerationProvider({
    required this.habitId,
    required this.imagePrompts,
    required this.endingPrompt,
  });

  Map<String, String> get images => Map.unmodifiable(_images);
  bool get isLoading => _isLoading;
  ImageProgress get progress => _progress;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null && _errorMessage!.isNotEmpty;

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

  Future<void> _generateLocalPlaceholder({
    required String filePath,
    required String title,
    String? subtitle,
  }) async {
    // Simple deterministic illustration that doesn't require network credits.
    const int w = 1024;
    const int h = 1024;
    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(
      recorder,
      ui.Rect.fromLTWH(0, 0, w.toDouble(), h.toDouble()),
    );

    final seed = title.hashCode ^ (subtitle?.hashCode ?? 0) ^ habitId.hashCode;
    final rng = Random(seed);
    Color randColor(double a) => Color.fromARGB(
      255,
      60 + rng.nextInt(160),
      60 + rng.nextInt(160),
      60 + rng.nextInt(160),
    ).withOpacity(a);

    final c1 = randColor(1);
    final c2 = randColor(1);
    final c3 = randColor(1);
    final bgPaint = ui.Paint()
      ..shader = ui.Gradient.linear(
        const ui.Offset(0, 0),
        ui.Offset(w.toDouble(), h.toDouble()),
        [c1, c2, c3],
        [0, 0.55, 1],
      );
    canvas.drawRect(ui.Rect.fromLTWH(0, 0, w.toDouble(), h.toDouble()), bgPaint);

    // Soft bubbles
    for (int i = 0; i < 18; i++) {
      final cx = rng.nextDouble() * w;
      final cy = rng.nextDouble() * h;
      final r = 26 + rng.nextDouble() * 90;
      canvas.drawCircle(
        ui.Offset(cx, cy),
        r,
        ui.Paint()..color = Colors.white.withOpacity(0.08 + rng.nextDouble() * 0.08),
      );
    }

    // Paper-ish overlay
    canvas.drawRect(
      ui.Rect.fromLTWH(0, 0, w.toDouble(), h.toDouble()),
      ui.Paint()..color = Colors.black.withOpacity(0.06),
    );

    // Text label
    final tp = TextPainter(
      text: TextSpan(
        text: title,
        style: const TextStyle(
          color: Color(0xFFF8FAFC),
          fontSize: 88,
          fontWeight: FontWeight.w800,
          shadows: [
            Shadow(
              color: Color(0x66000000),
              offset: Offset(0, 4),
              blurRadius: 14,
            )
          ],
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      maxLines: 2,
      ellipsis: '…',
    )..layout(maxWidth: 900);
    tp.paint(canvas, ui.Offset((w - tp.width) / 2, 420));

    if (subtitle != null && subtitle.isNotEmpty) {
      final st = TextPainter(
        text: TextSpan(
          text: subtitle,
          style: const TextStyle(
            color: Color(0xFFE2E8F0),
            fontSize: 40,
            fontWeight: FontWeight.w600,
            shadows: [
              Shadow(
                color: Color(0x55000000),
                offset: Offset(0, 2),
                blurRadius: 10,
              )
            ],
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
        maxLines: 2,
        ellipsis: '…',
      )..layout(maxWidth: 900);
      st.paint(canvas, ui.Offset((w - st.width) / 2, 540));
    }

    final picture = recorder.endRecording();
    final img = await picture.toImage(w, h);
    final bytes = await img.toByteData(format: ui.ImageByteFormat.png);
    if (bytes == null) throw Exception('Failed to encode placeholder image');
    await File(filePath).writeAsBytes(bytes.buffer.asUint8List());

    // Marker to indicate this key is a placeholder (used to decide whether to upgrade to AI later).
    try {
      await File('$filePath.placeholder').writeAsString('local');
    } catch (_) {}
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

  Future<void> _markComplete(String source) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final m = await _readManifest();
      // source: 'ai' or 'local'
      m[habitId] = source;
      await prefs.setString(_manifestKey, jsonEncode(m));
    } catch (_) {}
  }

  Future<String?> _getSource() async {
    try {
      final m = await _readManifest();
      final v = m[habitId];
      if (v is String) return v;
      // migrate from legacy bool manifests (treat true as ai)
      if (v == true) return 'ai';
      return null;
    } catch (_) {
      return null;
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
      final response = await http.get(Uri.parse(url)).timeout(_networkTimeout);
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
    ).timeout(_networkTimeout);

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

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    // Level 3: file system cache
    final cached = await _loadFromFileSystem();
    if (cached != null) {
      _sessionCache[habitId] = cached;
      _images = cached;
      _progress = ImageProgress(done: keys.length, total: keys.length);
      _isLoading = false;
      notifyListeners();
      final source = await _getSource();

      // If these were locally generated placeholders and we now have an API key,
      // try upgrading to real AI images once and then cache them for future runs.
      final apiKey = dotenv.env['EXPO_PUBLIC_OPENROUTER_API_KEY'] ?? '';
      final canUpgrade = apiKey.isNotEmpty && source != 'ai';
      if (!canUpgrade) return;

      // Continue to regenerate via AI (overwriting cached files) and mark source as 'ai'.
      _isLoading = true;
      _errorMessage = null;
      _progress = ImageProgress(done: 0, total: keys.length);
      notifyListeners();
    }

    // Level 4: generate via LLM
    _progress = ImageProgress(done: 0, total: keys.length);
    notifyListeners();

    int completed = 0;
    final dir = await _getDir();
    await _ensureDir(dir);
    final imageMap = <String, String>{};

    for (final key in keys) {
      final prompt = prompts[key]!;
      final filePath = _getFilePath(dir, key);
      bool success = false;
      String? lastErr;

      for (int attempt = 1; attempt <= _maxRetriesPerImage; attempt++) {
        try {
          final imageUrl = await _generateSingleImage(prompt);
          await _saveImage(filePath, imageUrl);
          // If we successfully generated with AI, remove any placeholder marker.
          try {
            final marker = File('$filePath.placeholder');
            if (await marker.exists()) await marker.delete();
          } catch (_) {}
          imageMap[key] = filePath;
          success = true;
          break;
        } catch (e) {
          lastErr = e.toString();
          // tiny backoff
          await Future.delayed(Duration(milliseconds: 250 * attempt));
        }
      }

      // If OpenRouter generation fails (e.g. no credits), fall back to a local placeholder
      // so the UI never degrades to emojis and the result can still be cached on device.
      if (!success) {
        try {
          final title = key == 'ending' ? 'The End' : key.replaceAll('_', ' ');
          await _generateLocalPlaceholder(filePath: filePath, title: title);
          imageMap[key] = filePath;
          success = true;
        } catch (e) {
          lastErr = e.toString();
        }
      }

      completed++;
      _progress = ImageProgress(done: completed, total: keys.length);
      notifyListeners();

      if (!success) {
        _errorMessage = 'Failed generating image "$key": ${lastErr ?? 'unknown error'}';
        _isLoading = false;
        notifyListeners();
        throw Exception(_errorMessage);
      }
    }

    // Mark source as AI only if we succeeded via OpenRouter for every key.
    // Otherwise, keep it as local so we can retry upgrading later.
    final allAi = await _noPlaceholderMarkers(keys);
    await _markComplete(allAi ? 'ai' : 'local');
    _sessionCache[habitId] = imageMap;
    _images = imageMap;
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> _noPlaceholderMarkers(List<String> keys) async {
    try {
      final dir = await _getDir();
      for (final key in keys) {
        final fp = _getFilePath(dir, key);
        if (await File('$fp.placeholder').exists()) return false;
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  void clearCache() {
    _images = {};
    _errorMessage = null;
    notifyListeners();
  }
}
