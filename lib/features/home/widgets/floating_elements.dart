import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/colors.dart';

class FloatingElements extends StatelessWidget {
  const FloatingElements({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;

    return IgnorePointer(
      child: Stack(
        children: [
          // Clouds
          _Cloud(top: 60, left: 20, size: 50, delay: 0),
          _Cloud(top: 100, left: w - 100, size: 40, delay: 500),
          _Cloud(top: 200, left: w / 2 - 30, size: 35, delay: 1000),

          // Stars
          _Star(top: 150, left: 50, size: 28, color: AppColors.starYellow, delay: 0),
          _Star(top: 80, left: w - 80, size: 22, color: AppColors.starPink, delay: 300),
          _Star(top: 300, left: w - 60, size: 32, color: AppColors.starYellow, delay: 600),
          _Star(top: 250, left: 30, size: 20, color: AppColors.starYellow, delay: 900),

          // Hearts
          _Heart(top: 180, right: 40, size: 28, delay: 200),
          _Heart(top: 350, right: 80, size: 22, delay: 700),

          // Sparkles
          _Sparkle(top: 120, left: w / 3, delay: 0),
          _Sparkle(top: 280, left: w / 2 + 50, delay: 400),
          _Sparkle(top: 400, left: 100, delay: 800),
        ],
      ),
    );
  }
}

class _Star extends StatelessWidget {
  final double top, left, size;
  final Color color;
  final int delay;
  const _Star({required this.top, required this.left, required this.size, required this.color, required this.delay});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: Text('⭐', style: TextStyle(fontSize: size, color: color))
          .animate(onPlay: (c) => c.repeat())
          .rotate(begin: 0, end: 1, duration: 4000.ms, curve: Curves.linear)
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .scaleXY(begin: 1, end: 1.3, delay: delay.ms, duration: 1000.ms),
    );
  }
}

class _Cloud extends StatelessWidget {
  final double top, left, size;
  final int delay;
  const _Cloud({required this.top, required this.left, required this.size, required this.delay});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: Opacity(
        opacity: 0.7,
        child: Text('☁️', style: TextStyle(fontSize: size))
            .animate(onPlay: (c) => c.repeat(reverse: true))
            .moveY(begin: 0, end: -15, delay: delay.ms, duration: 3000.ms, curve: Curves.easeInOut),
      ),
    );
  }
}

class _Heart extends StatelessWidget {
  final double top, right, size;
  final int delay;
  const _Heart({required this.top, required this.right, required this.size, required this.delay});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: right,
      child: Text('💖', style: TextStyle(fontSize: size))
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .scaleXY(begin: 1, end: 1.4, delay: delay.ms, duration: 600.ms, curve: Curves.easeOut),
    );
  }
}

class _Sparkle extends StatelessWidget {
  final double top, left;
  final int delay;
  const _Sparkle({required this.top, required this.left, required this.delay});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: const Text('✨', style: TextStyle(fontSize: 24))
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .fadeIn(delay: Duration(milliseconds: 0), duration: 500.ms)
          .scaleXY(begin: 0.5, end: 1.2, duration: 500.ms),
    );
  }
}
