import 'package:flutter/material.dart';

// Bilingual text container
class BilingualText {
  final String en;
  final String es;
  const BilingualText({required this.en, required this.es});

  String get(String language) => language == 'es' ? es : en;
}

// A selectable option inside a scene
class StoryOption {
  final String id;
  final String emoji;
  final BilingualText label;
  final bool correct;
  final BilingualText acknowledge;
  final BilingualText feedback;

  const StoryOption({
    required this.id,
    required this.emoji,
    required this.label,
    required this.correct,
    required this.acknowledge,
    required this.feedback,
  });
}

enum SceneType {
  choices,
  tapCollect,
  sorting,
}

class TapItem {
  final String emoji;
  final BilingualText label;
  final bool isHealthy;

  const TapItem({
    required this.emoji,
    required this.label,
    required this.isHealthy,
  });
}

class SortingStep {
  final String emoji;
  final BilingualText text;

  const SortingStep({
    required this.emoji,
    required this.text,
  });
}

// One scene in the story
class StoryScene {
  final String id;
  final List<Color> roomGradient;
  final List<double> roomGradientLocations;
  final BilingualText narration;
  final BilingualText question;
  final List<StoryOption> options;
  final BilingualText tip;
  final SceneType sceneType;
  final String? completionEmoji;
  final List<TapItem>? tapItems;
  final List<SortingStep>? sortingSteps;

  const StoryScene({
    required this.id,
    required this.roomGradient,
    required this.roomGradientLocations,
    required this.narration,
    required this.question,
    required this.options,
    required this.tip,
    this.sceneType = SceneType.choices,
    this.completionEmoji,
    this.tapItems,
    this.sortingSteps,
  });
}

// UI strings for a habit story
class StoryStrings {
  final BilingualText title;
  final BilingualText subtitle;
  final BilingualText startButton;
  final BilingualText endingTitle;
  final BilingualText endingSubtitle;
  final BilingualText playAgain;
  final BilingualText backToHabits;
  final BilingualText back;
  final BilingualText goodJob;
  final BilingualText tryAgain;
  final BilingualText next;
  final BilingualText finish;
  final BilingualText retry;

  const StoryStrings({
    required this.title,
    required this.subtitle,
    required this.startButton,
    required this.endingTitle,
    required this.endingSubtitle,
    required this.playAgain,
    required this.backToHabits,
    required this.back,
    required this.goodJob,
    required this.tryAgain,
    required this.next,
    required this.finish,
    required this.retry,
  });
}

// A collected tip after completing a scene correctly
class CollectedTip {
  final String id;
  final BilingualText tip;
  final String emoji;

  const CollectedTip({required this.id, required this.tip, required this.emoji});
}

// Full habit entry in the registry
class HabitRegistryEntry {
  final List<StoryScene> scenes;
  final StoryStrings strings;
  final Map<String, String> imagePrompts;
  final String endingPrompt;
  final String characterEmoji;
  final Color habitColor;
  final String endingEmoji;
  final List<Color> introGradientColors;
  final List<double> introGradientLocations;

  const HabitRegistryEntry({
    required this.scenes,
    required this.strings,
    required this.imagePrompts,
    required this.endingPrompt,
    required this.characterEmoji,
    required this.habitColor,
    required this.endingEmoji,
    required this.introGradientColors,
    required this.introGradientLocations,
  });
}

// Home screen habit card data
class HabitCard {
  final String id;
  final String name;
  final String emoji;
  final Color color;
  final String subtitle;
  final int progress;

  const HabitCard({
    required this.id,
    required this.name,
    required this.emoji,
    required this.color,
    required this.subtitle,
    required this.progress,
  });
}
