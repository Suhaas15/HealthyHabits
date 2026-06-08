import 'package:flutter/material.dart';
import '../game/data/models.dart';
import 'widgets/app_header.dart';
import 'widgets/habit_grid.dart';
import 'widgets/floating_elements.dart';
import '../../core/constants/spacing.dart';

class HomePage extends StatelessWidget {
  final void Function(HabitCard) onHabitPress;

  const HomePage({super.key, required this.onHabitPress});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background gradient
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE0F2FE), Color(0xFFFEF3C7), Color(0xFFFCE7F3)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        // Floating decorative elements
        const FloatingElements(),

        // Main content
        SafeArea(
          child: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(child: const AppHeader()),
                    const SliverToBoxAdapter(
                      child: SizedBox(height: AppSpacing.lg),
                    ),
                    SliverToBoxAdapter(
                      child: HabitGrid(onHabitPress: onHabitPress),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(height: AppSpacing.xl),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
