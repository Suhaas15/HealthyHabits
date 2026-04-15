import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguageToggle extends StatelessWidget {
  final String language;
  final VoidCallback onToggle;

  const LanguageToggle({
    super.key,
    required this.language,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        constraints: const BoxConstraints(minWidth: 56),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
        ),
        child: Center(
          child: Text(
            language == 'en' ? '🇺🇸 EN' : '🇪🇸 ES',
            style: GoogleFonts.nunito(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
