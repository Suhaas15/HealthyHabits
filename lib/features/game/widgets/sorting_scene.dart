import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/models.dart';
import '../providers/story_engine_provider.dart';
import 'progress_dots.dart';
import 'language_toggle.dart';

class SortingScene extends StatefulWidget {
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
  final VoidCallback onAdvance;

  const SortingScene({
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
    required this.onAdvance,
  });

  @override
  State<SortingScene> createState() => _SortingSceneState();
}

class _SortingSceneState extends State<SortingScene> {
  late List<SortingStep> _shuffledSteps;
  late List<int> _correctIndices; // maps current position -> original index
  bool _showError = false;
  String? _prevSceneId;

  @override
  void initState() {
    super.initState();
    _prevSceneId = widget.scene.id;
    _initSteps();
    _handlePhaseChange();
  }

  void _initSteps() {
    final steps = widget.scene.sortingSteps ?? [];
    final indices = List.generate(steps.length, (i) => i);
    indices.shuffle(Random());
    _shuffledSteps = indices.map((i) => steps[i]).toList();
    _correctIndices = indices;
  }

  @override
  void didUpdateWidget(covariant SortingScene oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.scene.id != _prevSceneId) {
      _prevSceneId = widget.scene.id;
      _initSteps();
      _showError = false;
    }
    if (widget.scenePhase != oldWidget.scenePhase ||
        widget.scene.id != oldWidget.scene.id ||
        widget.language != oldWidget.language) {
      _handlePhaseChange();
    }
  }

  void _handlePhaseChange() {
    if (widget.scenePhase == StoryPhase.narrating) {
      final text = widget.scene.narration.get(widget.language);
      widget.speakTip(text, widget.language);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && widget.scenePhase == StoryPhase.narrating) {
          widget.onNarrationComplete();
        }
      });
    }
  }

  void _checkOrder() {
    // Correct order: _correctIndices[i] should equal i for each position
    bool correct = true;
    for (int i = 0; i < _correctIndices.length; i++) {
      if (_correctIndices[i] != i) {
        correct = false;
        break;
      }
    }
    if (correct) {
      setState(() { _showError = false; });
      Future.delayed(const Duration(milliseconds: 600), () {
        if (mounted) widget.onComplete();
      });
    } else {
      setState(() {
        _showError = true;
      });
      Future.delayed(const Duration(milliseconds: 2000), () {
        if (mounted) {
          setState(() {
            _showError = false;
          });
        }
      });
    }
  }

  void _onReorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    setState(() {
      final step = _shuffledSteps.removeAt(oldIndex);
      _shuffledSteps.insert(newIndex, step);
      final idx = _correctIndices.removeAt(oldIndex);
      _correctIndices.insert(newIndex, idx);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isNarrating = widget.scenePhase == StoryPhase.narrating;
    final isSorting = widget.scenePhase == StoryPhase.sorting;
    final isCorrect = widget.scenePhase == StoryPhase.respondingCorrect;
    final isLastScene = widget.sceneIndex >= 4;

    // Background gradient
    final topBar = Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
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
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1E293B),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: ProgressDots(currentScene: widget.sceneIndex),
            ),
          ),
          SizedBox(
            width: 72,
            child: Align(
              alignment: Alignment.centerRight,
              child: LanguageToggle(
                language: widget.language,
                onToggle: widget.onToggleLanguage,
              ),
            ),
          ),
        ],
      ),
    );

    final background = Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.scene.roomGradient,
            stops: widget.scene.roomGradientLocations,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );

    // ── Sorting / Correct state ──────────────────────────────────────────────
    Widget reorderableList = ReorderableListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      onReorder: isSorting ? _onReorder : (_, __) {},
      proxyDecorator: (child, index, animation) => AnimatedBuilder(
        animation: animation,
        builder: (context, child) => Transform.scale(
          scale: 1.0 + animation.value * 0.04,
          child: Material(color: Colors.transparent, child: child),
        ),
        child: child,
      ),
      children: List.generate(_shuffledSteps.length, (index) {
        final step = _shuffledSteps[index];
        final isInCorrectPos = _correctIndices[index] == index;

        Color borderColor = Colors.white.withOpacity(0.25);
        Color bgColor = Colors.white.withOpacity(0.08);
        if (isCorrect && isInCorrectPos) {
          borderColor = const Color(0xFF22C55E);
          bgColor = const Color(0xFF22C55E).withOpacity(0.18);
        }

        Color rowBg = Colors.white.withOpacity(0.92);
        Color rowBorder = Colors.white;
        if (isCorrect && isInCorrectPos) {
          rowBg = const Color(0xFFDCFCE7);
          rowBorder = const Color(0xFF22C55E);
        }

        return Container(
          key: ValueKey('step_${widget.scene.id}_$index'),
          margin: const EdgeInsets.symmetric(vertical: 7),
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
          decoration: BoxDecoration(
            color: rowBg,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: rowBorder, width: 2),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: 8, offset: const Offset(0, 3))],
          ),
          child: Row(
            children: [
              if (isSorting)
                Icon(Icons.drag_handle_rounded, color: const Color(0xFF64748B), size: 28),
              if (isSorting) const SizedBox(width: 10),
              Container(
                width: 34,
                height: 34,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B).withOpacity(0.10),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${index + 1}',
                  style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w800, color: const Color(0xFF1E293B)),
                ),
              ),
              const SizedBox(width: 14),
              Text(step.emoji, style: const TextStyle(fontSize: 38)),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  step.text.get(widget.language),
                  style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w700, color: const Color(0xFF1E293B)),
                ),
              ),
              if (isCorrect && isInCorrectPos)
                const Icon(Icons.check_circle_rounded, color: Color(0xFF22C55E), size: 28)
              else if (isSorting)
                Icon(Icons.unfold_more_rounded, color: const Color(0xFF94A3B8), size: 24),
            ],
          ),
        );
      }),
    );

    return Stack(
      children: [
        background,
        SafeArea(
          child: Column(
            children: [
              topBar,
              // Narration card
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
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
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E293B),
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              // Instruction / feedback banner
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: isCorrect
                    ? Container(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF22C55E).withOpacity(0.18),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFF22C55E).withOpacity(0.5)),
                        ),
                        child: Text(
                          widget.language == 'es' ? '¡Orden perfecto! 🎉' : 'Perfect order! 🎉',
                          style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ).animate().fadeIn(duration: 300.ms)
                    : Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.92),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: 6)],
                        ),
                        child: Text(
                          widget.language == 'es'
                              ? 'Arrastra los pasos en el orden correcto'
                              : 'Drag the steps into the correct order',
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFFD97706),
                          ),
                        ),
                      ),
              ),
              // Error banner
              if (_showError)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.92),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: 6)],
                    ),
                    child: Text(
                      widget.language == 'es' ? '¡No exactamente! Intenta reordenar' : 'Not quite! Try rearranging',
                      style: GoogleFonts.nunito(fontSize: 17, fontWeight: FontWeight.w700, color: const Color(0xFFEF4444)),
                      textAlign: TextAlign.center,
                    ),
                  ).animate().fadeIn(duration: 200.ms),
                ),
              // Sortable list fills remaining space
              Expanded(child: reorderableList),
              // Bottom action area
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                child: isCorrect
                    ? GestureDetector(
                        onTap: widget.onAdvance,
                        child: Container(
                          width: double.infinity,
                          constraints: const BoxConstraints(maxWidth: 340),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF22C55E),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [BoxShadow(color: const Color(0xFF22C55E).withOpacity(0.4), offset: const Offset(0, 4), blurRadius: 12)],
                          ),
                          child: Text(
                            '${isLastScene ? widget.storyStrings.finish.get(widget.language) : widget.storyStrings.next.get(widget.language)} →',
                            style: GoogleFonts.nunito(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ).animate().fadeIn(duration: 300.ms)
                    : GestureDetector(
                        onTap: _checkOrder,
                        child: Container(
                          width: double.infinity,
                          constraints: const BoxConstraints(maxWidth: 340),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: widget.habitColor,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [BoxShadow(color: widget.habitColor.withOpacity(0.4), offset: const Offset(0, 4), blurRadius: 12)],
                          ),
                          child: Text(
                            widget.language == 'es' ? '✓  ¡Verificar mi orden!' : '✓  Check My Order!',
                            style: GoogleFonts.nunito(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
