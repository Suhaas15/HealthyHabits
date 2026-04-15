import 'package:flutter/foundation.dart';
import '../data/models.dart';

enum StoryPhase {
  intro,
  loadingImages,
  narrating,
  asking,
  respondingCorrect,
  respondingWrong,
  transitioning,
  ending,
}

class StoryEngineProvider extends ChangeNotifier {
  final List<StoryScene> _scenes;

  int _sceneIndex = 0;
  StoryPhase _phase = StoryPhase.intro;
  List<CollectedTip> _collectedTips = [];
  String? _selectedOptionId;

  StoryEngineProvider(this._scenes);

  int get sceneIndex => _sceneIndex;
  StoryPhase get phase => _phase;
  List<CollectedTip> get collectedTips => List.unmodifiable(_collectedTips);
  String? get selectedOptionId => _selectedOptionId;

  StoryScene? get currentScene {
    if (_sceneIndex >= 1 && _sceneIndex <= _scenes.length) {
      return _scenes[_sceneIndex - 1];
    }
    return null;
  }

  void startLoading() {
    _phase = StoryPhase.loadingImages;
    notifyListeners();
  }

  void startStory() {
    _sceneIndex = 1;
    _phase = StoryPhase.narrating;
    _collectedTips = [];
    _selectedOptionId = null;
    notifyListeners();
  }

  void onNarrationComplete() {
    _phase = StoryPhase.asking;
    notifyListeners();
  }

  void selectOption(StoryOption option) {
    _selectedOptionId = option.id;
    if (option.correct) {
      _phase = StoryPhase.respondingCorrect;
      final scene = _sceneIndex >= 1 ? _scenes[_sceneIndex - 1] : null;
      if (scene != null) {
        final alreadyCollected = _collectedTips.any((t) => t.id == scene.id);
        if (!alreadyCollected) {
          final correctOption = scene.options.firstWhere(
            (o) => o.correct,
            orElse: () => option,
          );
          _collectedTips = [
            ..._collectedTips,
            CollectedTip(
              id: scene.id,
              tip: scene.tip,
              emoji: correctOption.emoji,
            ),
          ];
        }
      }
    } else {
      _phase = StoryPhase.respondingWrong;
    }
    notifyListeners();
  }

  void retryQuestion() {
    _selectedOptionId = null;
    _phase = StoryPhase.asking;
    notifyListeners();
  }

  void advanceScene() {
    if (_sceneIndex >= _scenes.length) {
      _sceneIndex = _scenes.length + 1;
      _phase = StoryPhase.ending;
    } else {
      _phase = StoryPhase.transitioning;
    }
    notifyListeners();
  }

  void onTransitionComplete() {
    _sceneIndex++;
    _selectedOptionId = null;
    _phase = StoryPhase.narrating;
    notifyListeners();
  }

  void resetStory() {
    _sceneIndex = 0;
    _phase = StoryPhase.intro;
    _collectedTips = [];
    _selectedOptionId = null;
    notifyListeners();
  }
}
