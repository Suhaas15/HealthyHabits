import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingScreen extends StatefulWidget {
  final ({int done, int total}) progress;
  final VoidCallback? onSkip;
  final VoidCallback? onBack;

  const LoadingScreen({
    super.key,
    required this.progress,
    this.onSkip,
    this.onBack,
  });

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool _showSkip = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 4000), () {
      if (mounted) setState(() => _showSkip = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          if (widget.onBack != null)
            Positioned(
              top: 16,
              left: 20,
              child: GestureDetector(
                onTap: widget.onBack,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '← Back',
                    style: GoogleFonts.nunito(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Bouncing teddy
                Text('🧸', style: const TextStyle(fontSize: 72))
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .scaleXY(begin: 0.8, end: 1.1, duration: 1000.ms, curve: Curves.easeInOut),
                const SizedBox(height: 20),
                Text(
                  "Preparing Teddy's adventure...",
                  style: GoogleFonts.nunito(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    shadows: const [Shadow(color: Color(0x4D000000), offset: Offset(0, 2), blurRadius: 4)],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // Bouncing dots row
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _BouncingDot(delay: 0),
                    const SizedBox(width: 10),
                    _BouncingDot(delay: 150),
                    const SizedBox(width: 10),
                    _BouncingDot(delay: 300),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  '${widget.progress.done} / ${widget.progress.total} images ready',
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(0.6),
                  ),
                  textAlign: TextAlign.center,
                ),
                if (_showSkip && widget.onSkip != null) ...[
                  const SizedBox(height: 24),
                  Text(
                    'Taking too long?',
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ).animate().fadeIn(duration: 300.ms),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: widget.onSkip,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.white.withOpacity(0.4), width: 2),
                      ),
                      child: Text(
                        'Skip & play with emojis',
                        style: GoogleFonts.nunito(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ).animate().fadeIn(duration: 300.ms),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BouncingDot extends StatelessWidget {
  final int delay;

  const _BouncingDot({required this.delay});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFFBBF24),
      ),
    )
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .moveY(
          begin: 0,
          end: -12,
          delay: Duration(milliseconds: delay),
          duration: 400.ms,
          curve: Curves.easeOut,
        );
  }
}
