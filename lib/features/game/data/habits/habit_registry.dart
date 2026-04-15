import 'package:flutter/material.dart';
import '../models.dart';
import 'sleep/story_data.dart';
import 'sleep/image_prompts.dart';
import 'screen_time/story_data.dart';
import 'screen_time/image_prompts.dart';
import 'hydration/story_data.dart';
import 'hydration/image_prompts.dart';
import 'movement/story_data.dart';
import 'movement/image_prompts.dart';
import 'hygiene/story_data.dart';
import 'hygiene/image_prompts.dart';
import 'healthy_eating/story_data.dart';
import 'healthy_eating/image_prompts.dart';

final Map<String, HabitRegistryEntry> habitRegistry = {
  'sleep': HabitRegistryEntry(
    scenes: sleepScenes,
    strings: sleepStrings,
    imagePrompts: sleepImagePrompts,
    endingPrompt: sleepEndingPrompt,
    characterEmoji: '🧸',
    habitColor: const Color(0xFF7C3AED),
    endingEmoji: '🧸💤',
    introGradientColors: [Color(0xFF1E1B4B), Color(0xFF312E81), Color(0xFF4C1D95), Color(0xFF1E1B4B)],
    introGradientLocations: [0, 0.3, 0.7, 1],
  ),
  'screen_time': HabitRegistryEntry(
    scenes: screenTimeScenes,
    strings: screenTimeStrings,
    imagePrompts: screenTimeImagePrompts,
    endingPrompt: screenTimeEndingPrompt,
    characterEmoji: '🤖',
    habitColor: const Color(0xFF06B6D4),
    endingEmoji: '🤖✨',
    introGradientColors: [Color(0xFF0C2332), Color(0xFF0A3D54), Color(0xFF0C4A6E), Color(0xFF0C2332)],
    introGradientLocations: [0, 0.3, 0.7, 1],
  ),
  'hydration': HabitRegistryEntry(
    scenes: hydrationScenes,
    strings: hydrationStrings,
    imagePrompts: hydrationImagePrompts,
    endingPrompt: hydrationEndingPrompt,
    characterEmoji: '🐰',
    habitColor: const Color(0xFF3B82F6),
    endingEmoji: '🐰💧',
    introGradientColors: [Color(0xFF0D1F3C), Color(0xFF1E3A5F), Color(0xFF1E40AF), Color(0xFF0D1F3C)],
    introGradientLocations: [0, 0.3, 0.7, 1],
  ),
  'movement': HabitRegistryEntry(
    scenes: movementScenes,
    strings: movementStrings,
    imagePrompts: movementImagePrompts,
    endingPrompt: movementEndingPrompt,
    characterEmoji: '🦘',
    habitColor: const Color(0xFFF59E0B),
    endingEmoji: '🦘✨',
    introGradientColors: [Color(0xFF1A0F00), Color(0xFF2C1A00), Color(0xFF4A2800), Color(0xFF1A0F00)],
    introGradientLocations: [0, 0.3, 0.7, 1],
  ),
  'hygiene': HabitRegistryEntry(
    scenes: hygieneScenes,
    strings: hygieneStrings,
    imagePrompts: hygieneImagePrompts,
    endingPrompt: hygieneEndingPrompt,
    characterEmoji: '🦆',
    habitColor: const Color(0xFF10B981),
    endingEmoji: '🦆✨',
    introGradientColors: [Color(0xFF021A10), Color(0xFF042E1E), Color(0xFF06402A), Color(0xFF021A10)],
    introGradientLocations: [0, 0.3, 0.7, 1],
  ),
  'healthy_eating': HabitRegistryEntry(
    scenes: healthyEatingScenes,
    strings: healthyEatingStrings,
    imagePrompts: healthyEatingImagePrompts,
    endingPrompt: healthyEatingEndingPrompt,
    characterEmoji: '🐒',
    habitColor: const Color(0xFFEF4444),
    endingEmoji: '🐒✨',
    introGradientColors: [Color(0xFF1C0505), Color(0xFF2D0808), Color(0xFF4A0E0E), Color(0xFF1C0505)],
    introGradientLocations: [0, 0.3, 0.7, 1],
  ),
};
