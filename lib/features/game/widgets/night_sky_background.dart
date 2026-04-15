import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class NightSkyBackground extends StatelessWidget {
  final List<Color> gradientColors;
  final List<double> gradientLocations;

  const NightSkyBackground({
    super.key,
    this.gradientColors = const [
      Color(0xFF1E1B4B), Color(0xFF312E81), Color(0xFF4C1D95), Color(0xFF1E1B4B)
    ],
    this.gradientLocations = const [0, 0.3, 0.7, 1],
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final rng = Random(42); // Fixed seed for consistent layout
    final stars = List.generate(20, (i) => (
      x: rng.nextDouble() * (size.width - 20),
      y: rng.nextDouble() * (size.height - 100),
      s: 8 + rng.nextDouble() * 14,
      delay: (rng.nextDouble() * 3000).round(),
    ));

    return Stack(
      children: [
        // Gradient background
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
                stops: gradientLocations,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        // Twinkling stars
        ...stars.map((star) => Positioned(
          left: star.x,
          top: star.y,
          child: Text('✨', style: TextStyle(fontSize: star.s))
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .fadeIn(delay: Duration(milliseconds: star.delay), duration: 800.ms)
              .scaleXY(begin: 0.8, end: 1.3, delay: Duration(milliseconds: star.delay), duration: 1000.ms),
        )),
      ],
    );
  }
}
