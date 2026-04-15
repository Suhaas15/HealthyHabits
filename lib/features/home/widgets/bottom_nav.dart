import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/colors.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color(0xFFF1F5F9), width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 4),
              blurRadius: 20,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(emoji: '🏠', label: 'Home', isActive: true, delay: 0),
            _NavItem(emoji: '📊', label: 'Progress', isActive: false, delay: 100),
            _NavItem(emoji: '🏆', label: 'Rewards', isActive: false, delay: 200),
            _NavItem(emoji: '⚙️', label: 'Settings', isActive: false, delay: 300),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String emoji;
  final String label;
  final bool isActive;
  final int delay;

  const _NavItem({
    required this.emoji,
    required this.label,
    required this.isActive,
    required this.delay,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.9),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 150),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48, height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.isActive
                      ? const Color(0xFFEEF2FF)
                      : const Color(0xFFF8FAFC),
                ),
                child: Center(
                  child: Text(widget.emoji, style: const TextStyle(fontSize: 24)),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.label,
                style: GoogleFonts.nunito(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: widget.isActive ? AppColors.sleep : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate()
      .fadeIn(delay: Duration(milliseconds: widget.delay), duration: 400.ms)
      .slideY(begin: 0.2, end: 0, delay: Duration(milliseconds: widget.delay), duration: 400.ms, curve: Curves.easeOutBack);
  }
}
