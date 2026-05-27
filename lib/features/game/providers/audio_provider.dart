import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

class AudioProvider extends ChangeNotifier {
  final FlutterTts _tts = FlutterTts();
  bool _isSpeaking = false;

  AudioProvider() {
    _initTts();
  }

  Future<void> _initTts() async {
    // iOS requires the audio session to be configured before TTS will produce sound.
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      await _tts.setSharedInstance(true);
      await _tts.setIosAudioCategory(
        IosTextToSpeechAudioCategory.playback,
        [
          IosTextToSpeechAudioCategoryOptions.allowBluetooth,
          IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
          IosTextToSpeechAudioCategoryOptions.mixWithOthers,
        ],
        IosTextToSpeechAudioMode.defaultMode,
      );
    }
    await _tts.setVolume(1.0);
    _tts.setCompletionHandler(() {
      _isSpeaking = false;
    });
    _tts.setErrorHandler((msg) {
      _isSpeaking = false;
    });
  }

  Future<void> speakTip(String text, String language) async {
    if (_isSpeaking) {
      await _tts.stop();
    }
    _isSpeaking = true;
    await _tts.setLanguage(language == 'es' ? 'es-MX' : 'en-US');
    await _tts.setSpeechRate(0.45); // 0.5 = AVSpeechUtteranceDefaultSpeechRate on iOS; 0.45 ≈ expo-speech rate 0.9
    await _tts.speak(text);
  }

  Future<void> stopSpeech() async {
    await _tts.stop();
    _isSpeaking = false;
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }
}
