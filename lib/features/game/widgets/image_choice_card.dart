import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// state: 'default' | 'correct' | 'wrong' | 'faded'
class ImageChoiceCard extends StatelessWidget {
  final String? imagePath;
  final String emoji;
  final String label;
  final String state;
  final VoidCallback? onPress;
  final bool disabled;
  // Explicit size; if null, computed from screen width
  final double? cardWidth;

  const ImageChoiceCard({
    super.key,
    this.imagePath,
    required this.emoji,
    required this.label,
    this.state = 'default',
    this.onPress,
    this.disabled = false,
    this.cardWidth,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = this.cardWidth ?? ((screenWidth - 48) / 2) * 0.9;
    final cardHeight = cardWidth * 1.1;

    final Color borderColor;
    final double borderWidth;
    final double scale;
    final double opacity;

    switch (state) {
      case 'correct':
        borderColor = const Color(0xFF22C55E);
        borderWidth = 3;
        scale = 1.03;
        opacity = 1.0;
      case 'wrong':
        borderColor = const Color(0xFFEF4444);
        borderWidth = 3;
        scale = 1.03;
        opacity = 1.0;
      case 'faded':
        borderColor = Colors.white.withOpacity(0.2);
        borderWidth = 1;
        scale = 0.95;
        opacity = 0.4;
      default:
        borderColor = Colors.white.withOpacity(0.2);
        borderWidth = 1;
        scale = 1.0;
        opacity = 1.0;
    }

    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 300),
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        child: GestureDetector(
          onTap: disabled ? null : onPress,
          child: Container(
            width: cardWidth,
            height: cardHeight,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1744),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: borderColor, width: borderWidth),
            ),
            clipBehavior: Clip.hardEdge,
            child: Stack(
              children: [
                // Image or fallback
                if (imagePath != null)
                  Positioned.fill(
                    child: Image.file(File(imagePath!), fit: BoxFit.cover),
                  )
                else
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF2D1B69),
                            Color(0xFF3B2178),
                            Color(0xFF5B21B6),
                            Color(0xFF4C1D95),
                          ],
                          stops: [0, 0.4, 0.7, 1],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: Container(
                          width: 92,
                          height: 92,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.12),
                          ),
                          child: Center(
                            child: Text(
                              'Generating…',
                              style: GoogleFonts.nunito(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: Colors.white.withOpacity(0.85),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                // Label overlay at bottom
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 48),
                    color: Colors.black.withOpacity(0.72),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    child: Row(
                      children: [
                        Text(emoji, style: const TextStyle(fontSize: 18)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            label,
                            style: GoogleFonts.nunito(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Status badge
                if (state == 'correct')
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF22C55E),
                      ),
                      child: const Center(
                        child: Text('✓', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                if (state == 'wrong')
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFEF4444),
                      ),
                      child: const Center(
                        child: Text('✗', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
