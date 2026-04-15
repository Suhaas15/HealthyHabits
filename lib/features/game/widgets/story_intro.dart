import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/models.dart';
import 'language_toggle.dart';

class StoryIntro extends StatelessWidget {
  final VoidCallback onStart;
  final VoidCallback onBack;
  final String language;
  final VoidCallback onToggleLanguage;
  final StoryStrings storyStrings;
  final String characterEmoji;
  final Color habitColor;

  const StoryIntro({
    super.key,
    required this.onStart,
    required this.onBack,
    required this.language,
    required this.onToggleLanguage,
    required this.storyStrings,
    required this.characterEmoji,
    required this.habitColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top row: back button + language toggle
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onBack,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '← ${storyStrings.back.get(language)}',
                    style: GoogleFonts.nunito(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              LanguageToggle(language: language, onToggle: onToggleLanguage),
            ],
          ),
        ),

        // Main content — scrollable so it works in both portrait and landscape
        Expanded(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top - 60,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(characterEmoji, style: const TextStyle(fontSize: 100))
                      .animate()
                      .scale(
                        begin: const Offset(0, 0),
                        end: const Offset(1, 1),
                        delay: 100.ms,
                        duration: 600.ms,
                        curve: Curves.elasticOut,
                      ),
                  const SizedBox(height: 20),
                  Text(
                    storyStrings.title.get(language),
                    style: GoogleFonts.nunito(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      shadows: const [
                        Shadow(color: Color(0x4D000000), offset: Offset(0, 2), blurRadius: 4),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  )
                      .animate()
                      .fadeIn(delay: 400.ms, duration: 600.ms)
                      .slideY(
                        begin: -0.3,
                        end: 0,
                        delay: 400.ms,
                        duration: 600.ms,
                        curve: Curves.easeOut,
                      ),
                  const SizedBox(height: 12),
                  Text(
                    storyStrings.subtitle.get(language),
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(delay: 800.ms, duration: 500.ms),
                  const SizedBox(height: 32),
                  GestureDetector(
                    onTap: onStart,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
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
                        storyStrings.startButton.get(language),
                        style: GoogleFonts.nunito(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 1100.ms, duration: 400.ms)
                      .scale(
                        begin: const Offset(0, 0),
                        end: const Offset(1, 1),
                        delay: 1100.ms,
                        duration: 500.ms,
                        curve: Curves.elasticOut,
                      ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
