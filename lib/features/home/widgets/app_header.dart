import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/colors.dart';
import '../../../core/constants/spacing.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xxl, AppSpacing.xl, AppSpacing.xxl, AppSpacing.md),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Bouncing mascot star
              Text('🌟', style: const TextStyle(fontSize: 40))
                  .animate(onPlay: (c) => c.repeat())
                  .moveY(begin: 0, end: -10, duration: 400.ms, curve: Curves.easeOut)
                  .then()
                  .moveY(begin: -10, end: 0, duration: 400.ms, curve: Curves.easeIn),
              const SizedBox(width: 12),
              // Title
              Text(
                'Hey there, Superstar!',
                style: GoogleFonts.nunito(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ).animate()
                .fadeIn(duration: 600.ms)
                .scaleXY(begin: 0.8, end: 1.1, duration: 400.ms, curve: Curves.easeOutBack)
                .then()
                .scaleXY(begin: 1.1, end: 1.0, duration: 200.ms),
              const SizedBox(width: 12),
              // Waving hand
              Text('👋', style: const TextStyle(fontSize: 36))
                  .animate(onPlay: (c) => c.repeat())
                  .rotate(begin: 0, end: 20 / 360, duration: 200.ms)
                  .then()
                  .rotate(begin: 20 / 360, end: -20 / 360, duration: 200.ms)
                  .then()
                  .rotate(begin: -20 / 360, end: 0, duration: 200.ms),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Column(
            children: [
              Text(
                'Pick a healthy habit to work on today!',
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFFCD34D), width: 2),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('🔥', style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 6),
                    Text(
                      '3 Day Streak!',
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFD97706),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ).animate().fadeIn(delay: 400.ms, duration: 500.ms),
        ],
      ),
    );
  }
}
