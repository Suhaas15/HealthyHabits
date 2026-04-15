import '../../game/data/models.dart';
import '../../../core/theme/colors.dart';

final List<HabitCard> habits = [
  HabitCard(
    id: 'sleep',
    name: 'Sleep',
    emoji: '😴',
    color: AppColors.sleep,
    subtitle: 'Sweet dreams!',
    progress: 75,
  ),
  HabitCard(
    id: 'screen_time',
    name: 'Screen Time',
    emoji: '📱',
    color: AppColors.screenTime,
    subtitle: 'Take a break!',
    progress: 45,
  ),
  HabitCard(
    id: 'hydration',
    name: 'Hydration',
    emoji: '💧',
    color: AppColors.hydration,
    subtitle: 'Drink up!',
    progress: 80,
  ),
  HabitCard(
    id: 'movement',
    name: 'Movement',
    emoji: '🏃',
    color: AppColors.movement,
    subtitle: "Let's move!",
    progress: 60,
  ),
  HabitCard(
    id: 'hygiene',
    name: 'Hygiene',
    emoji: '🧼',
    color: AppColors.hygiene,
    subtitle: 'Squeaky clean!',
    progress: 90,
  ),
  HabitCard(
    id: 'healthy_eating',
    name: 'Healthy Eating',
    emoji: '🥗',
    color: AppColors.healthyEating,
    subtitle: 'Yummy & healthy!',
    progress: 55,
  ),
];
