import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../game/data/models.dart';

class HabitCardWidget extends StatefulWidget {
  final HabitCard habit;
  final int index;
  final void Function(HabitCard) onPress;

  const HabitCardWidget({
    super.key,
    required this.habit,
    required this.index,
    required this.onPress,
  });

  @override
  State<HabitCardWidget> createState() => _HabitCardWidgetState();
}

class _HabitCardWidgetState extends State<HabitCardWidget> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _scale,
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOutBack,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _scale = 0.92),
        onTapUp: (_) {
          setState(() => _scale = 1.0);
          widget.onPress(widget.habit);
        },
        onTapCancel: () => setState(() => _scale = 1.0),
        child: AspectRatio(
          aspectRatio: 0.75,
          child: Container(
            decoration: BoxDecoration(
              color: widget.habit.color,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.3), width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  offset: const Offset(0, 8),
                  blurRadius: 20,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Stack(
                children: [
                  // Decorative circles
                  Positioned(
                    top: -18, right: -18,
                    child: Container(
                      width: 70, height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -12, left: -12,
                    child: Container(
                      width: 50, height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.15),
                      ),
                    ),
                  ),
                  // Card content
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Emoji icon container
                        Container(
                          width: 56, height: 56,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.9),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(0, 2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              widget.habit.emoji,
                              style: const TextStyle(fontSize: 30),
                            ).animate(onPlay: (c) => c.repeat(reverse: true))
                              .moveY(begin: 0, end: -4,
                                delay: Duration(milliseconds: widget.index * 120 + 500),
                                duration: 1500.ms, curve: Curves.easeInOut),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.habit.name,
                          style: GoogleFonts.nunito(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            shadows: [Shadow(color: Colors.black.withOpacity(0.1), offset: const Offset(0, 1), blurRadius: 2)],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.habit.subtitle,
                          style: GoogleFonts.nunito(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.9),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        // Progress bar
                        Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(3),
                                child: LinearProgressIndicator(
                                  value: widget.habit.progress / 100.0,
                                  backgroundColor: Colors.white.withOpacity(0.3),
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white.withOpacity(0.9)),
                                  minHeight: 6,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${widget.habit.progress}%',
                              style: GoogleFonts.nunito(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ).animate()
      .fadeIn(delay: Duration(milliseconds: widget.index * 120), duration: 400.ms)
      .slideY(begin: 0.3, end: 0, delay: Duration(milliseconds: widget.index * 120),
              duration: 400.ms, curve: Curves.easeOutBack);
  }
}
