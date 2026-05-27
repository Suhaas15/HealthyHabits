import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/models.dart';
import '../providers/story_engine_provider.dart';
import 'progress_dots.dart';
import 'language_toggle.dart';

// Natural scatter positions for 6 items across the scene (x, y as fractions 0–1).
// Items are in the middle zone, avoiding top HUD (~22%) and bottom character area.
const _itemPositions = [
  Offset(0.12, 0.42),
  Offset(0.38, 0.26),
  Offset(0.68, 0.30),
  Offset(0.25, 0.72),
  Offset(0.57, 0.74),
  Offset(0.85, 0.55),
];

// Each item has a bright distinct glow color — not indicative of healthy/unhealthy
const _itemGlows = [
  Color(0xFFFF6B6B),  // coral
  Color(0xFF4ECDC4),  // teal
  Color(0xFFFFD93D),  // yellow
  Color(0xFF6BCB77),  // green
  Color(0xFF4D96FF),  // blue
  Color(0xFFFF9A3C),  // orange
];

class TapCollectScene extends StatefulWidget {
  final StoryScene scene;
  final int sceneIndex;
  final StoryPhase scenePhase;
  final String language;
  final VoidCallback onNarrationComplete;
  final VoidCallback onComplete;
  final void Function(String text, String language) speakTip;
  final VoidCallback onToggleLanguage;
  final VoidCallback onBack;
  final StoryStrings storyStrings;
  final Color habitColor;
  final String characterEmoji;
  final VoidCallback onAdvance;

  const TapCollectScene({
    super.key,
    required this.scene,
    required this.sceneIndex,
    required this.scenePhase,
    required this.language,
    required this.onNarrationComplete,
    required this.onComplete,
    required this.speakTip,
    required this.onToggleLanguage,
    required this.onBack,
    required this.storyStrings,
    required this.habitColor,
    required this.characterEmoji,
    required this.onAdvance,
  });

  @override
  State<TapCollectScene> createState() => _TapCollectSceneState();
}

class _TapCollectSceneState extends State<TapCollectScene>
    with TickerProviderStateMixin {
  late List<TapItem> _items;
  final Set<int> _tappedHealthy = {};
  final Set<int> _wrongTapped = {};
  late List<AnimationController> _shakeControllers;
  late List<Animation<double>> _shakeAnimations;
  String? _prevSceneId;
  String? _speechText;
  Timer? _speechTimer;

  @override
  void initState() {
    super.initState();
    _prevSceneId = widget.scene.id;
    _items = List.from(widget.scene.tapItems ?? [])..shuffle(Random());
    _initShake();
    _handlePhaseChange();
  }

  void _initShake() {
    _shakeControllers = List.generate(
      _items.length,
      (_) => AnimationController(vsync: this, duration: const Duration(milliseconds: 380)),
    );
    _shakeAnimations = _shakeControllers.map((ctrl) =>
      TweenSequence<double>([
        TweenSequenceItem(tween: Tween(begin: 0.0, end: 10.0), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 10.0, end: -10.0), weight: 2),
        TweenSequenceItem(tween: Tween(begin: -10.0, end: 10.0), weight: 2),
        TweenSequenceItem(tween: Tween(begin: 10.0, end: 0.0), weight: 1),
      ]).animate(CurvedAnimation(parent: ctrl, curve: Curves.easeInOut)),
    ).toList();
  }

  @override
  void didUpdateWidget(covariant TapCollectScene oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.scene.id != _prevSceneId) {
      _prevSceneId = widget.scene.id;
      _items = List.from(widget.scene.tapItems ?? [])..shuffle(Random());
      for (var c in _shakeControllers) c.dispose();
      _tappedHealthy.clear();
      _wrongTapped.clear();
      _initShake();
    }
    if (widget.scenePhase != oldWidget.scenePhase ||
        widget.scene.id != oldWidget.scene.id ||
        widget.language != oldWidget.language) {
      _handlePhaseChange();
    }
  }

  void _handlePhaseChange() {
    if (widget.scenePhase == StoryPhase.narrating) {
      widget.speakTip(widget.scene.narration.get(widget.language), widget.language);
      // Show items immediately alongside the story text
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && widget.scenePhase == StoryPhase.narrating) {
          widget.onNarrationComplete();
        }
      });
    }
  }

  void _showSpeech(String text) {
    _speechTimer?.cancel();
    setState(() => _speechText = text);
    _speechTimer = Timer(const Duration(milliseconds: 1800), () {
      if (mounted) setState(() => _speechText = null);
    });
  }

  void _onTapItem(int index) {
    if (widget.scenePhase != StoryPhase.tapping) return;
    final item = _items[index];
    if (item.isHealthy) {
      if (_tappedHealthy.contains(index)) return;
      setState(() => _tappedHealthy.add(index));
      final total = _items.where((i) => i.isHealthy).length;
      if (_tappedHealthy.length == total) {
        setState(() => _speechText = widget.language == 'es' ? '¡Increíble! 🎉' : 'Amazing! 🎉');
        Future.delayed(const Duration(milliseconds: 600), () {
          if (mounted) widget.onComplete();
        });
      } else {
        _showSpeech(widget.language == 'es' ? '¡Buena elección! ✨' : 'Great choice! ✨');
      }
    } else {
      if (_wrongTapped.contains(index)) return;
      setState(() => _wrongTapped.add(index));
      _showSpeech(widget.language == 'es' ? 'Hmm, no ese...' : 'Hmm, not that one...');
      _shakeControllers[index].forward(from: 0).then((_) {
        if (mounted) setState(() => _wrongTapped.remove(index));
      });
    }
  }

  @override
  void dispose() {
    _speechTimer?.cancel();
    for (var c in _shakeControllers) c.dispose();
    super.dispose();
  }

  Widget _buildItemBubble(int index, double sceneW, double sceneH) {
    final item = _items[index];
    final isTapped = _tappedHealthy.contains(index);
    final isWrong = _wrongTapped.contains(index);
    final isTapping = widget.scenePhase == StoryPhase.tapping;
    final glow = _itemGlows[index % _itemGlows.length];

    // Bubble size scales with scene
    final bubbleSize = (sceneW * 0.10).clamp(82.0, 120.0);
    final emojiSize = bubbleSize * 0.58;

    Widget bubble = GestureDetector(
      onTap: (isTapping && !isTapped) ? () => _onTapItem(index) : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: bubbleSize,
            height: bubbleSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: isTapped
                    ? [const Color(0xFF4ADE80), const Color(0xFF16A34A)]
                    : isWrong
                        ? [const Color(0xFFF87171), const Color(0xFFDC2626)]
                        : [
                            glow.withOpacity(0.95),
                            glow.withOpacity(0.60),
                          ],
              ),
              boxShadow: [
                BoxShadow(
                  color: isTapped
                      ? const Color(0xFF22C55E).withOpacity(0.7)
                      : isWrong
                          ? const Color(0xFFEF4444).withOpacity(0.6)
                          : glow.withOpacity(0.55),
                  blurRadius: isTapped ? 28 : 18,
                  spreadRadius: isTapped ? 4 : 0,
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(item.emoji, style: TextStyle(fontSize: emojiSize)),
                if (isTapped)
                  Positioned(
                    right: 4, bottom: 4,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check, size: 13, color: Color(0xFF16A34A)),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 7),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.92),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: 4, offset: const Offset(0, 2)),
              ],
            ),
            child: Text(
              item.label.get(widget.language),
              style: GoogleFonts.nunito(
                fontSize: (bubbleSize * 0.165).clamp(13.0, 17.0),
                fontWeight: FontWeight.w800,
                color: isTapped ? const Color(0xFF16A34A) : const Color(0xFF1E293B),
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );

    // Gentle float while idle
    if (isTapping && !isTapped && !isWrong) {
      bubble = bubble
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .moveY(
            begin: 0, end: -7,
            duration: Duration(milliseconds: 1700 + index * 250),
            curve: Curves.easeInOut,
          );
    }

    // Entrance bounce
    bubble = bubble
        .animate()
        .scale(
          begin: const Offset(0, 0), end: const Offset(1, 1),
          delay: Duration(milliseconds: 80 + index * 90),
          duration: 500.ms,
          curve: Curves.easeOutBack,
        );

    // Shake on wrong
    if (isWrong) {
      bubble = AnimatedBuilder(
        animation: _shakeAnimations[index],
        builder: (ctx, child) => Transform.translate(
          offset: Offset(_shakeAnimations[index].value, 0),
          child: child,
        ),
        child: bubble,
      );
    }

    return bubble;
  }

  @override
  Widget build(BuildContext context) {
    final isNarrating = widget.scenePhase == StoryPhase.narrating;
    final isTapping = widget.scenePhase == StoryPhase.tapping;
    final isCorrect = widget.scenePhase == StoryPhase.respondingCorrect;
    final isLastScene = widget.sceneIndex >= 4;
    final totalHealthy = _items.where((i) => i.isHealthy).length;

    return Stack(
      fit: StackFit.expand,
      children: [
        // ── Full background ────────────────────────────────────────────────
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.scene.roomGradient,
              stops: widget.scene.roomGradientLocations,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),

        // ── Items scattered across the scene ──────────────────────────────
        if (isTapping || isCorrect)
          SafeArea(
            child: LayoutBuilder(
              builder: (ctx, constraints) {
                final W = constraints.maxWidth;
                final H = constraints.maxHeight;
                return Stack(
                  children: List.generate(_items.length, (i) {
                    final pos = _itemPositions[i % _itemPositions.length];
                    final bubble = _buildItemBubble(i, W, H);
                    // Offset so the bubble center sits at pos
                    final bubbleSize = (W * 0.085).clamp(72.0, 108.0);
                    final labelH = 28.0;
                    final totalH = bubbleSize + 7 + labelH;
                    final totalW = bubbleSize + 20;
                    return Positioned(
                      left: (pos.dx * W - totalW / 2).clamp(0, W - totalW),
                      top: (pos.dy * H - totalH / 2).clamp(H * 0.22, H - totalH - 10),
                      child: bubble,
                    );
                  }),
                );
              },
            ),
          ),

        // ── HUD overlay (top) ─────────────────────────────────────────────
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top bar
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: GestureDetector(
                        onTap: widget.onBack,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.90),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 6)],
                          ),
                          child: Text(
                            '← ${widget.storyStrings.back.get(widget.language)}',
                            style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF1E293B)),
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: Center(child: ProgressDots(currentScene: widget.sceneIndex))),
                    SizedBox(
                      width: 72,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: LanguageToggle(language: widget.language, onToggle: widget.onToggleLanguage),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Narration card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 10, offset: const Offset(0, 4))],
                  ),
                  child: Text(
                    widget.scene.narration.get(widget.language),
                    style: GoogleFonts.nunito(
                      fontSize: 17, fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E293B), height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Instruction + star progress
              if (isTapping || isCorrect)
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!isCorrect)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.92),
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: 6)],
                          ),
                          child: Text(
                            widget.language == 'es' ? 'Toca los objetos saludables' : 'Tap the healthy items',
                            style: GoogleFonts.nunito(
                              fontSize: 17, fontWeight: FontWeight.w800,
                              color: const Color(0xFFD97706),
                            ),
                          ),
                        ),
                      const SizedBox(width: 10),
                      // Stars for progress
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(totalHealthy, (i) =>
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Icon(
                              i < _tappedHealthy.length ? Icons.star_rounded : Icons.star_outline_rounded,
                              color: i < _tappedHealthy.length
                                  ? const Color(0xFFFCD34D)
                                  : Colors.white.withOpacity(0.35),
                              size: 26,
                            ).animate(target: i < _tappedHealthy.length ? 1 : 0)
                              .scale(begin: const Offset(0.7, 0.7), end: const Offset(1.2, 1.2), duration: 300.ms, curve: Curves.easeOutBack)
                              .then()
                              .scale(begin: const Offset(1.2, 1.2), end: const Offset(1.0, 1.0), duration: 150.ms),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              // Narrating dots
              if (isNarrating)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(3, (i) =>
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text('•', style: TextStyle(fontSize: 26, color: Colors.white.withOpacity(0.35)))
                              .animate(onPlay: (c) => c.repeat(reverse: true))
                              .fadeIn(delay: Duration(milliseconds: i * 280), duration: 450.ms),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),

        // ── Character in bottom-left ──────────────────────────────────────
        if (isTapping || isCorrect)
          Positioned(
            bottom: 16, left: 16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Speech bubble
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: _speechText != null
                      ? Container(
                          key: ValueKey(_speechText),
                          margin: const EdgeInsets.only(left: 8, bottom: 6),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.95),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 8, offset: const Offset(0, 3)),
                            ],
                          ),
                          child: Text(
                            _speechText!,
                            style: GoogleFonts.nunito(
                              fontSize: 16, fontWeight: FontWeight.w800,
                              color: const Color(0xFF1E293B),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                // Character emoji
                Text(widget.characterEmoji, style: const TextStyle(fontSize: 64))
                    .animate()
                    .fadeIn(delay: 500.ms, duration: 400.ms)
                    .slideY(begin: 0.3, end: 0, delay: 500.ms, duration: 400.ms, curve: Curves.easeOut),
              ],
            ),
          ),

        // ── Correct: success overlay + Next button ────────────────────────
        if (isCorrect)
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(80, 0, 80, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: widget.onAdvance,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF22C55E), Color(0xFF16A34A)],
                            begin: Alignment.topLeft, end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(color: const Color(0xFF22C55E).withOpacity(0.5),
                              offset: const Offset(0, 5), blurRadius: 16),
                          ],
                        ),
                        child: Text(
                          '${isLastScene ? widget.storyStrings.finish.get(widget.language) : widget.storyStrings.next.get(widget.language)} →',
                          style: GoogleFonts.nunito(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ).animate().fadeIn(duration: 350.ms).slideY(begin: 0.3, end: 0, duration: 350.ms, curve: Curves.easeOut),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
