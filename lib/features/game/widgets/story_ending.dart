import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/models.dart';

class StoryEnding extends StatelessWidget {
  final List<CollectedTip> collectedTips;
  final String language;
  final VoidCallback onPlayAgain;
  final VoidCallback onBack;
  final String? endingImage;
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
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    if (isLandscape) {
      return _LandscapeEnding(
        collectedTips: collectedTips,
        language: language,
        onPlayAgain: onPlayAgain,
        onBack: onBack,
        endingImage: endingImage,
        storyStrings: storyStrings,
        habitColor: habitColor,
        endingEmoji: endingEmoji,
      );
    }

    return _PortraitEnding(
      collectedTips: collectedTips,
      language: language,
      onPlayAgain: onPlayAgain,
      onBack: onBack,
      endingImage: endingImage,
      storyStrings: storyStrings,
      habitColor: habitColor,
      endingEmoji: endingEmoji,
    );
  }
}

// ── Landscape Layout ─────────────────────────────────────────────────────────

class _LandscapeEnding extends StatelessWidget {
  final List<CollectedTip> collectedTips;
  final String language;
  final VoidCallback onPlayAgain;
  final VoidCallback onBack;
  final String? endingImage;
  final StoryStrings storyStrings;
  final Color habitColor;
  final String endingEmoji;

  const _LandscapeEnding({
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
    return Row(
      children: [
        // ── Left panel: celebration image + title ────────────────────────────
        Expanded(
          flex: 5,
          child: _LeftPanel(
            endingImage: endingImage,
            endingEmoji: endingEmoji,
            storyStrings: storyStrings,
            language: language,
            habitColor: habitColor,
          ),
        ),
        // Thin divider
        Container(width: 1, color: Colors.white.withOpacity(0.1)),
        // ── Right panel: matching game ───────────────────────────────────────
        Expanded(
          flex: 7,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
            child: collectedTips.isNotEmpty
                ? _MatchingGame(
                    tips: collectedTips,
                    language: language,
                    habitColor: habitColor,
                    storyStrings: storyStrings,
                    onPlayAgain: onPlayAgain,
                    onBack: onBack,
                  )
                : _ActionButtons(
                    storyStrings: storyStrings,
                    language: language,
                    habitColor: habitColor,
                    onPlayAgain: onPlayAgain,
                    onBack: onBack,
                  ),
          ),
        ),
      ],
    );
  }
}

class _LeftPanel extends StatelessWidget {
  final String? endingImage;
  final String endingEmoji;
  final StoryStrings storyStrings;
  final String language;
  final Color habitColor;

  const _LeftPanel({
    this.endingImage,
    required this.endingEmoji,
    required this.storyStrings,
    required this.language,
    required this.habitColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Confetti
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: ['🎉', '✨', '🌟', '✨', '🎉'].map((e) =>
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(e, style: const TextStyle(fontSize: 22)),
            ),
          ).toList(),
        ).animate().fadeIn(delay: 200.ms, duration: 500.ms),
        const SizedBox(height: 12),
        // Character image
        Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: endingImage != null
                  ? Image.file(File(endingImage!), width: 170, height: 170, fit: BoxFit.cover)
                  : Text(endingEmoji, style: const TextStyle(fontSize: 80)),
            ),
            Positioned(
              top: -8, right: -12,
              child: Row(
                children: [
                  _ZzzBubble(delay: 0),
                  const SizedBox(width: 6),
                  _ZzzBubble(delay: 700),
                  const SizedBox(width: 6),
                  _ZzzBubble(delay: 1400),
                ],
              ),
            ),
          ],
        ).animate().scale(
          begin: const Offset(0.85, 0.85), end: const Offset(1.0, 1.0),
          delay: 100.ms, duration: 500.ms, curve: Curves.easeOutBack,
        ),
        const SizedBox(height: 14),
        // Title
        Text(
          storyStrings.endingTitle.get(language),
          style: GoogleFonts.nunito(
            fontSize: 24, fontWeight: FontWeight.w800,
            color: const Color(0xFFFCD34D),
            shadows: const [Shadow(color: Color(0x4D000000), offset: Offset(0, 2), blurRadius: 4)],
          ),
          textAlign: TextAlign.center,
        ).animate().fadeIn(delay: 400.ms, duration: 400.ms),
        const SizedBox(height: 6),
        Text(
          storyStrings.endingSubtitle.get(language),
          style: GoogleFonts.nunito(
            fontSize: 13, fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.7),
          ),
          textAlign: TextAlign.center,
        ).animate().fadeIn(delay: 600.ms, duration: 400.ms),
      ],
    );
  }
}

// ── Portrait Layout ───────────────────────────────────────────────────────────

class _PortraitEnding extends StatelessWidget {
  final List<CollectedTip> collectedTips;
  final String language;
  final VoidCallback onPlayAgain;
  final VoidCallback onBack;
  final String? endingImage;
  final StoryStrings storyStrings;
  final Color habitColor;
  final String endingEmoji;

  const _PortraitEnding({
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
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: ['🎉', '✨', '🌟', '✨', '🎉'].map((e) =>
              Padding(padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Text(e, style: const TextStyle(fontSize: 20))),
            ).toList(),
          ).animate().fadeIn(delay: 200.ms),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: endingImage != null
                ? Image.file(File(endingImage!), width: 160, height: 160, fit: BoxFit.cover)
                : Text(endingEmoji, style: const TextStyle(fontSize: 70)),
          ),
          const SizedBox(height: 12),
          Text(storyStrings.endingTitle.get(language),
            style: GoogleFonts.nunito(fontSize: 26, fontWeight: FontWeight.w800, color: const Color(0xFFFCD34D)),
            textAlign: TextAlign.center),
          const SizedBox(height: 6),
          Text(storyStrings.endingSubtitle.get(language),
            style: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white.withOpacity(0.7)),
            textAlign: TextAlign.center),
          const SizedBox(height: 20),
          if (collectedTips.isNotEmpty)
            _MatchingGame(tips: collectedTips, language: language, habitColor: habitColor,
              storyStrings: storyStrings, onPlayAgain: onPlayAgain, onBack: onBack)
          else
            _ActionButtons(storyStrings: storyStrings, language: language, habitColor: habitColor,
              onPlayAgain: onPlayAgain, onBack: onBack),
        ],
      ),
    );
  }
}

// ── Matching Game ─────────────────────────────────────────────────────────────

class _MatchingGame extends StatefulWidget {
  final List<CollectedTip> tips;
  final String language;
  final Color habitColor;
  final StoryStrings storyStrings;
  final VoidCallback onPlayAgain;
  final VoidCallback onBack;

  const _MatchingGame({
    required this.tips,
    required this.language,
    required this.habitColor,
    required this.storyStrings,
    required this.onPlayAgain,
    required this.onBack,
  });

  @override
  State<_MatchingGame> createState() => _MatchingGameState();
}

class _MatchingGameState extends State<_MatchingGame> with TickerProviderStateMixin {
  late List<int> _emojiOrder;
  late List<int> _textOrder;
  int? _selectedEmojiPos;   // position index in _emojiOrder
  final Set<int> _matched = {}; // matched original tip indices
  bool _wrongFlash = false;
  Timer? _wrongTimer;
  late AnimationController _shakeCtrl;
  late Animation<double> _shakeAnim;

  @override
  void initState() {
    super.initState();
    _shuffle();
    _shakeCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 350));
    _shakeAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 7.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 7.0, end: -7.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -7.0, end: 7.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 7.0, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(parent: _shakeCtrl, curve: Curves.easeInOut));
  }

  void _shuffle() {
    final n = widget.tips.length;
    _emojiOrder = List.generate(n, (i) => i)..shuffle(Random());
    _textOrder = List.generate(n, (i) => i)..shuffle(Random());
  }

  bool get _allMatched => _matched.length == widget.tips.length;

  void _onTapEmoji(int pos) {
    if (_allMatched) return;
    final tipIdx = _emojiOrder[pos];
    if (_matched.contains(tipIdx)) return;
    setState(() => _selectedEmojiPos = pos);
  }

  void _onTapText(int pos) {
    if (_allMatched || _selectedEmojiPos == null) return;
    final tipIdx = _textOrder[pos];
    if (_matched.contains(tipIdx)) return;
    final selectedTip = _emojiOrder[_selectedEmojiPos!];
    if (selectedTip == tipIdx) {
      setState(() {
        _matched.add(tipIdx);
        _selectedEmojiPos = null;
      });
    } else {
      setState(() => _wrongFlash = true);
      _shakeCtrl.forward(from: 0);
      _wrongTimer?.cancel();
      _wrongTimer = Timer(const Duration(milliseconds: 500), () {
        if (mounted) setState(() { _wrongFlash = false; _selectedEmojiPos = null; });
      });
    }
  }

  @override
  void dispose() {
    _wrongTimer?.cancel();
    _shakeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_allMatched) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          Text('🎉',style: const TextStyle(fontSize: 48))
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scale(begin: const Offset(0.85, 0.85), end: const Offset(1.15, 1.15), duration: 700.ms),
          const SizedBox(height: 10),
          Text(
            widget.language == 'es' ? '¡Emparejamiento Perfecto!' : 'Perfect Match!',
            style: GoogleFonts.nunito(fontSize: 28, fontWeight: FontWeight.w800, color: const Color(0xFFFCD34D)),
            textAlign: TextAlign.center,
          ).animate().scale(begin: const Offset(0.6, 0.6), end: const Offset(1.0, 1.0),
              curve: Curves.elasticOut, duration: 700.ms),
          const SizedBox(height: 24),
          _ActionButtons(
            storyStrings: widget.storyStrings,
            language: widget.language,
            habitColor: widget.habitColor,
            onPlayAgain: widget.onPlayAgain,
            onBack: widget.onBack,
          ).animate().fadeIn(delay: 400.ms, duration: 400.ms),
        ],
      );
    }

    final n = widget.tips.length;
    const rowHeight = 68.0;
    const emojiSize = 52.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Instruction
        Text(
          widget.language == 'es' ? 'Empareja cada emoji con su consejo' : 'Match each emoji to its tip',
          style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.w700, color: const Color(0xFFFCD34D)),
          textAlign: TextAlign.center,
        ).animate().fadeIn(delay: 700.ms, duration: 300.ms),
        const SizedBox(height: 14),
        // Rows: emoji chip | gap | text card — fixed height, perfectly aligned
        AnimatedBuilder(
          animation: _shakeAnim,
          builder: (context, child) => Transform.translate(
            offset: Offset(_wrongFlash ? _shakeAnim.value : 0, 0),
            child: child,
          ),
          child: Column(
            children: List.generate(n, (i) {
              final emojiTipIdx = _emojiOrder[i];
              final textTipIdx = _textOrder[i];
              final emojiMatched = _matched.contains(emojiTipIdx);
              final textMatched = _matched.contains(textTipIdx);
              final isSelected = _selectedEmojiPos == i;

              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  height: rowHeight,
                  child: Row(
                    children: [
                      // ── Emoji chip ───────────────────────────────────────
                      GestureDetector(
                        onTap: emojiMatched ? null : () => _onTapEmoji(i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: rowHeight,
                          height: rowHeight,
                          decoration: BoxDecoration(
                            color: emojiMatched
                                ? const Color(0xFF22C55E).withOpacity(0.25)
                                : isSelected
                                    ? const Color(0xFFFCD34D).withOpacity(0.2)
                                    : Colors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: emojiMatched
                                  ? const Color(0xFF22C55E)
                                  : isSelected
                                      ? const Color(0xFFFCD34D)
                                      : Colors.white.withOpacity(0.2),
                              width: isSelected || emojiMatched ? 2.5 : 1.5,
                            ),
                            boxShadow: isSelected
                                ? [BoxShadow(color: const Color(0xFFFCD34D).withOpacity(0.35), blurRadius: 12)]
                                : emojiMatched
                                    ? [BoxShadow(color: const Color(0xFF22C55E).withOpacity(0.3), blurRadius: 10)]
                                    : [],
                          ),
                          child: Center(
                            child: Text(
                              widget.tips[emojiTipIdx].emoji,
                              style: TextStyle(
                                fontSize: emojiSize * 0.65,
                                color: emojiMatched ? Colors.white.withOpacity(0.5) : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // ── Text card ────────────────────────────────────────
                      Expanded(
                        child: GestureDetector(
                          onTap: textMatched ? null : () => _onTapText(i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: rowHeight,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: textMatched
                                  ? const Color(0xFF22C55E).withOpacity(0.2)
                                  : (_selectedEmojiPos != null && !_wrongFlash)
                                      ? Colors.white.withOpacity(0.12)
                                      : Colors.white.withOpacity(0.07),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: textMatched
                                    ? const Color(0xFF22C55E)
                                    : (_selectedEmojiPos != null && !_wrongFlash)
                                        ? Colors.white.withOpacity(0.4)
                                        : Colors.white.withOpacity(0.15),
                                width: textMatched ? 2 : 1.5,
                              ),
                              boxShadow: textMatched
                                  ? [BoxShadow(color: const Color(0xFF22C55E).withOpacity(0.25), blurRadius: 8)]
                                  : [],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.tips[textTipIdx].tip.get(widget.language),
                                    style: GoogleFonts.nunito(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: textMatched ? const Color(0xFF86EFAC) : Colors.white.withOpacity(0.9),
                                      height: 1.35,
                                    ),
                                  ),
                                ),
                                if (textMatched) ...[
                                  const SizedBox(width: 8),
                                  const Icon(Icons.check_circle_rounded, color: Color(0xFF22C55E), size: 20),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: Duration(milliseconds: 800 + i * 80), duration: 300.ms)
                  .slideX(begin: 0.1, end: 0, delay: Duration(milliseconds: 800 + i * 80), duration: 300.ms),
              );
            }),
          ),
        ),
      ],
    );
  }
}

// ── Action Buttons ────────────────────────────────────────────────────────────

class _ActionButtons extends StatelessWidget {
  final StoryStrings storyStrings;
  final String language;
  final Color habitColor;
  final VoidCallback onPlayAgain;
  final VoidCallback onBack;

  const _ActionButtons({
    required this.storyStrings, required this.language,
    required this.habitColor, required this.onPlayAgain, required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPlayAgain,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: habitColor,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [BoxShadow(color: habitColor.withOpacity(0.4), offset: const Offset(0, 4), blurRadius: 12)],
            ),
            child: Text(storyStrings.playAgain.get(language),
              style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
              textAlign: TextAlign.center),
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: onBack,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.25), width: 1.5),
            ),
            child: Text(storyStrings.backToHabits.get(language),
              style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white.withOpacity(0.75)),
              textAlign: TextAlign.center),
          ),
        ),
      ],
    );
  }
}

// ── Zzz Bubble ────────────────────────────────────────────────────────────────

class _ZzzBubble extends StatelessWidget {
  final int delay;
  const _ZzzBubble({required this.delay});

  @override
  Widget build(BuildContext context) {
    return const Text('💤', style: TextStyle(fontSize: 20))
        .animate(onPlay: (c) => c.repeat())
        .fadeIn(delay: Duration(milliseconds: delay), duration: 400.ms)
        .moveY(begin: 0, end: -40, delay: Duration(milliseconds: delay), duration: 1800.ms)
        .then()
        .fadeOut(duration: 500.ms);
  }
}
