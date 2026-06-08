import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/habits/habit_registry.dart';
import 'data/models.dart';
import 'providers/story_engine_provider.dart';
// ignore: unused_import
import '../../debug_globals.dart'; // remove before production
import 'providers/language_provider.dart';
import 'providers/audio_provider.dart';
import 'providers/image_generation_provider.dart';
import 'widgets/night_sky_background.dart';
import 'widgets/story_intro.dart';
import 'widgets/loading_screen.dart';
import 'widgets/split_choice_scene.dart';
import 'widgets/tap_collect_scene.dart';
import 'widgets/sorting_scene.dart';
import 'widgets/story_ending.dart';

class HabitGamePage extends StatelessWidget {
  final String habitId;
  final VoidCallback onBack;

  const HabitGamePage({
    super.key,
    required this.habitId,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final habit = habitRegistry[habitId]!;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StoryEngineProvider(habit.scenes)),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => AudioProvider()),
        ChangeNotifierProvider(
          create: (_) => ImageGenerationProvider(
            habitId: habitId,
            imagePrompts: habit.imagePrompts,
            endingPrompt: habit.endingPrompt,
          ),
        ),
      ],
      child: _HabitGameView(habit: habit, onBack: onBack),
    );
  }
}

class _HabitGameView extends StatefulWidget {
  final dynamic habit; // HabitRegistryEntry
  final VoidCallback onBack;

  const _HabitGameView({required this.habit, required this.onBack});

  @override
  State<_HabitGameView> createState() => _HabitGameViewState();
}

class _HabitGameViewState extends State<_HabitGameView> {
  StoryEngineProvider? _engine;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final engine = context.read<StoryEngineProvider>();
    if (_engine != engine) {
      _engine?.removeListener(_onEngineChange);
      _engine = engine;
      _engine!.addListener(_onEngineChange);
      debugEngine = engine; // debug ref for VM evaluate testing
    }
  }

  @override
  void dispose() {
    _engine?.removeListener(_onEngineChange);
    super.dispose();
  }

  void _onEngineChange() {
    if (_engine?.phase == StoryPhase.loadingImages) {
      _generateImages();
    }
  }

  Future<void> _generateImages() async {
    final imageProvider = context.read<ImageGenerationProvider>();
    final engine = context.read<StoryEngineProvider>();
    try {
      await imageProvider.generateAllImages();
      if (mounted) engine.startStory();
    } catch (_) {
      // Keep the user on the loading screen with an error message + retry option.
      // (ImageGenerationProvider exposes errorMessage.)
    }
  }

  Future<void> _handleRetryImages() async {
    final engine = context.read<StoryEngineProvider>();
    if (engine.phase != StoryPhase.loadingImages) engine.startLoading();
    await _generateImages();
  }

  void _handleStart() {
    context.read<AudioProvider>().stopSpeech();
    context.read<StoryEngineProvider>().startLoading();
  }

  void _handlePlayAgain() {
    context.read<AudioProvider>().stopSpeech();
    context.read<StoryEngineProvider>().resetStory();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) context.read<StoryEngineProvider>().startLoading();
    });
  }

  void _handleBack() {
    context.read<AudioProvider>().stopSpeech();
    context.read<StoryEngineProvider>().resetStory();
    widget.onBack();
  }

  void _handleAdvance() {
    final engine = context.read<StoryEngineProvider>();
    context.read<AudioProvider>().stopSpeech();
    context.read<LanguageProvider>().setEnglish();
    final sceneIndex = engine.sceneIndex;
    engine.advanceScene();
    if (sceneIndex < widget.habit.scenes.length) {
      Future.delayed(const Duration(milliseconds: 600), () {
        if (mounted) engine.onTransitionComplete();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final engine = context.watch<StoryEngineProvider>();
    final langProvider = context.watch<LanguageProvider>();
    final audioProvider = context.watch<AudioProvider>();
    final imageProvider = context.watch<ImageGenerationProvider>();

    final phase = engine.phase;
    final language = langProvider.language;

    final isIntro = phase == StoryPhase.intro;
    final isLoadingImages = phase == StoryPhase.loadingImages;
    final isEnding = phase == StoryPhase.ending;
    final isScene = !isIntro && !isLoadingImages && !isEnding;
    final showNightSky = isIntro || isLoadingImages || isEnding;

    const endingGradientColors = [
      Color(0xFF0A0920),
      Color(0xFF110F2E),
      Color(0xFF1A1744),
      Color(0xFF0A0920),
    ];
    const endingGradientLocations = [0.0, 0.3, 0.7, 1.0];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          if (showNightSky)
            NightSkyBackground(
              gradientColors: isEnding
                  ? endingGradientColors
                  : widget.habit.introGradientColors,
              gradientLocations: isEnding
                  ? endingGradientLocations
                  : widget.habit.introGradientLocations,
            ),

          SafeArea(
            child: SizedBox.expand(
              child: () {
                if (isIntro) {
                  return StoryIntro(
                    onStart: _handleStart,
                    onBack: _handleBack,
                    language: language,
                    onToggleLanguage: langProvider.toggleLanguage,
                    storyStrings: widget.habit.strings,
                    characterEmoji: widget.habit.characterEmoji,
                    habitColor: widget.habit.habitColor,
                  );
                }

                if (isLoadingImages) {
                  return LoadingScreen(
                    progress: (
                      done: imageProvider.progress.done,
                      total: imageProvider.progress.total,
                    ),
                    errorText: imageProvider.errorMessage,
                    onRetry: _handleRetryImages,
                    onBack: _handleBack,
                  );
                }

                if (isScene && engine.currentScene != null) {
                  final scene = engine.currentScene!;
                  if (scene.sceneType == SceneType.tapCollect) {
                    return TapCollectScene(
                      scene: scene,
                      sceneIndex: engine.sceneIndex,
                      scenePhase: phase,
                      language: language,
                      onNarrationComplete: engine.onNarrationComplete,
                      onComplete: engine.completeSpecialScene,
                      speakTip: audioProvider.speakTip,
                      onToggleLanguage: langProvider.toggleLanguage,
                      onBack: _handleBack,
                      storyStrings: widget.habit.strings,
                      habitColor: widget.habit.habitColor,
                      characterEmoji: widget.habit.characterEmoji,
                      onAdvance: _handleAdvance,
                    );
                  } else if (scene.sceneType == SceneType.sorting) {
                    return SortingScene(
                      scene: scene,
                      sceneIndex: engine.sceneIndex,
                      scenePhase: phase,
                      language: language,
                      onNarrationComplete: engine.onNarrationComplete,
                      onComplete: engine.completeSpecialScene,
                      speakTip: audioProvider.speakTip,
                      onToggleLanguage: langProvider.toggleLanguage,
                      onBack: _handleBack,
                      storyStrings: widget.habit.strings,
                      habitColor: widget.habit.habitColor,
                      onAdvance: _handleAdvance,
                    );
                  } else {
                    return SplitChoiceScene(
                      scene: scene,
                      sceneIndex: engine.sceneIndex,
                      scenePhase: phase,
                      selectedOptionId: engine.selectedOptionId,
                      language: language,
                      getImage: imageProvider.getImage,
                      onNarrationComplete: engine.onNarrationComplete,
                      onSelectOption: engine.selectOption,
                      onRetry: engine.retryQuestion,
                      onAdvance: _handleAdvance,
                      speakTip: audioProvider.speakTip,
                      onToggleLanguage: langProvider.toggleLanguage,
                      onBack: _handleBack,
                      storyStrings: widget.habit.strings,
                    );
                  }
                }

                if (isEnding) {
                  return StoryEnding(
                    collectedTips: engine.collectedTips,
                    language: language,
                    onPlayAgain: _handlePlayAgain,
                    onBack: _handleBack,
                    endingImage: imageProvider.getEndingImage(),
                    storyStrings: widget.habit.strings,
                    habitColor: widget.habit.habitColor,
                    endingEmoji: widget.habit.endingEmoji,
                  );
                }

                return const SizedBox.shrink();
              }(),
            ),
          ),
        ],
      ),
    );
  }
}
