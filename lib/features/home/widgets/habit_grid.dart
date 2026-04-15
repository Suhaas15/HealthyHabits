import 'package:flutter/material.dart';
import '../data/habits.dart';
import '../../game/data/models.dart';
import 'habit_card.dart';

class HabitGrid extends StatelessWidget {
  final void Function(HabitCard) onHabitPress;

  const HabitGrid({super.key, required this.onHabitPress});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 900;
    final horizontalPadding = isDesktop ? 60.0 : 40.0;
    final baseCardWidth = (width - (horizontalPadding * 2) - 60) / 3;
    final cardWidth = baseCardWidth * 0.7;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        spacing: 0,
        runSpacing: 24,
        children: habits.asMap().entries.map((entry) {
          return SizedBox(
            width: cardWidth,
            child: HabitCardWidget(
              habit: entry.value,
              index: entry.key,
              onPress: onHabitPress,
            ),
          );
        }).toList(),
      ),
    );
  }
}
