import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProgressDots extends StatelessWidget {
  final int currentScene; // 1–4 (which scene we're on), 5 = all done
  final int totalScenes;

  const ProgressDots({
    super.key,
    required this.currentScene,
    this.totalScenes = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalScenes, (i) {
        final sceneNum = i + 1;
        final String status;
        if (sceneNum < currentScene) {
          status = 'done';
        } else if (sceneNum == currentScene) {
          status = 'current';
        } else {
          status = 'future';
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: _Dot(status: status),
        );
      }),
    );
  }
}

class _Dot extends StatelessWidget {
  final String status; // 'done' | 'current' | 'future'

  const _Dot({required this.status});

  @override
  Widget build(BuildContext context) {
    final Color color;
    final double opacity;

    if (status == 'done') {
      color = const Color(0xFFFCD34D);
      opacity = 1.0;
    } else if (status == 'current') {
      color = const Color(0xFFFBBF24);
      opacity = 1.0;
    } else {
      color = Colors.white.withOpacity(0.2);
      opacity = 0.3;
    }

    Widget dot = Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: status == 'current'
            ? [
                BoxShadow(
                  color: const Color(0xFFFCD34D).withOpacity(0.8),
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
    );

    if (status == 'current') {
      dot = dot
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .scaleXY(begin: 1.0, end: 1.3, duration: 600.ms, curve: Curves.easeInOut);
    }

    return Opacity(opacity: opacity, child: dot);
  }
}
