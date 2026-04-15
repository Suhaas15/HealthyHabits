import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/models.dart';

class StoryEnding extends StatelessWidget {
  final List<CollectedTip> collectedTips;
  final String language;
  final VoidCallback onPlayAgain;
  final VoidCallback onBack;
  final String? endingImage; // file path
  final StoryStrings storyStrings;
  final Color habitColor;
  final String endingEmoji;

  const StoryEnding({
    super.key,
    required this.collectedTips,
    required this.language,
    required this.onPlayAgain,
    required this.onBack,
    this.endingImage,
    required this.storyStrings,
    required this.habitColor,
    required this.endingEmoji,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
      child: Column(
        children: [
          // Confetti row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: ['🎉', '✨', '🌟', '✨', '🎉'].map((e) =>
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(e, style: const TextStyle(fontSize: 24)),
              )
            ).toList(),
          ).animate().fadeIn(delay: 200.ms, duration: 600.ms),

          const SizedBox(height: 8),

          // Character area
          Stack(
            clipBehavior: Clip.none,
            children: [
              if (endingImage != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.file(
                    File(endingImage!),
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                )
              else
                Text(endingEmoji, style: const TextStyle(fontSize: 80)),

              // Zzz bubbles
              Positioned(
                top: -10,
                right: -20,
                child: Row(
                  children: [
                    _ZzzBubble(delay: 0),
                    const SizedBox(width: 8),
                    _ZzzBubble(delay: 800),
                    const SizedBox(width: 8),
                    _ZzzBubble(delay: 1600),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Title
          Text(
            storyStrings.endingTitle.get(language),
            style: GoogleFonts.nunito(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: const Color(0xFFFCD34D),
              shadows: const [Shadow(color: Color(0x4D000000), offset: Offset(0, 2), blurRadius: 4)],
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 300.ms, duration: 500.ms),

          const SizedBox(height: 8),

          // Subtitle
          Text(
            storyStrings.endingSubtitle.get(language),
            style: GoogleFonts.nunito(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 600.ms, duration: 500.ms),

          const SizedBox(height: 20),

          // Tip cards
          ...collectedTips.asMap().entries.map((entry) =>
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _TipCard(tip: entry.value, index: entry.key, language: language),
            )
          ),

          const SizedBox(height: 24),

          // Play again button
          GestureDetector(
            onTap: onPlayAgain,
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 320),
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: habitColor,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: habitColor.withOpacity(0.4),
                    offset: const Offset(0, 4),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: Text(
                storyStrings.playAgain.get(language),
                style: GoogleFonts.nunito(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ).animate().fadeIn(delay: 1500.ms, duration: 500.ms),

          const SizedBox(height: 12),

          // Back to habits button
          GestureDetector(
            onTap: onBack,
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 320),
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
              ),
              child: Text(
                storyStrings.backToHabits.get(language),
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.8),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ).animate().fadeIn(delay: 1500.ms, duration: 500.ms),
        ],
      ),
    );
  }
}

class _TipCard extends StatelessWidget {
  final CollectedTip tip;
  final int index;
  final String language;

  const _TipCard({required this.tip, required this.index, required this.language});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Text(tip.emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              tip.tip.get(language),
              style: GoogleFonts.nunito(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: 800 + index * 200), duration: 400.ms)
        .slideY(begin: 0.3, end: 0, delay: Duration(milliseconds: 800 + index * 200), duration: 400.ms, curve: Curves.easeOut);
  }
}

class _ZzzBubble extends StatelessWidget {
  final int delay;

  const _ZzzBubble({required this.delay});

  @override
  Widget build(BuildContext context) {
    return const Text('💤', style: TextStyle(fontSize: 24))
        .animate(onPlay: (c) => c.repeat())
        .fadeIn(delay: Duration(milliseconds: delay), duration: 400.ms)
        .moveY(begin: 0, end: -50, delay: Duration(milliseconds: delay), duration: 2000.ms)
        .then()
        .fadeOut(duration: 600.ms);
  }
}
