import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/models.dart';
import '../providers/story_engine_provider.dart';
import 'progress_dots.dart';
import 'language_toggle.dart';
import 'image_choice_card.dart';

List<StoryOption> _shuffleOptions(List<StoryOption> options) {
  final arr = [...options];
  final rng = Random();
  for (int i = arr.length - 1; i > 0; i--) {
    final j = rng.nextInt(i + 1);
    final tmp = arr[i];
    arr[i] = arr[j];
    arr[j] = tmp;
  }
  return arr;
}

class SplitChoiceScene extends StatefulWidget {
  final StoryScene scene;
  final int sceneIndex;
  final StoryPhase scenePhase;
  final String? selectedOptionId;
  final String language;
  final String? Function(String sceneId, String optionId) getImage;
  final VoidCallback onNarrationComplete;
  final void Function(StoryOption option) onSelectOption;
  final VoidCallback onRetry;
  final VoidCallback onAdvance;
  final void Function(String text, String language) speakTip;
  final VoidCallback onToggleLanguage;
  final VoidCallback onBack;
  final StoryStrings storyStrings;

  const SplitChoiceScene({
    super.key,
    required this.scene,
    required this.sceneIndex,
    required this.scenePhase,
    this.selectedOptionId,
    required this.language,
    required this.getImage,
    required this.onNarrationComplete,
    required this.onSelectOption,
    required this.onRetry,
    required this.onAdvance,
    required this.speakTip,
    required this.onToggleLanguage,
    required this.onBack,
    required this.storyStrings,
  });

  @override
  State<SplitChoiceScene> createState() => _SplitChoiceSceneState();
}

class _SplitChoiceSceneState extends State<SplitChoiceScene> {
  late List<StoryOption> _displayOptions;
  String? _prevSceneId;

  @override
  void initState() {
    super.initState();
    _prevSceneId = widget.scene.id;
    _displayOptions = _shuffleOptions(widget.scene.options);
    _handlePhaseChange();
  }

  @override
  void didUpdateWidget(covariant SplitChoiceScene oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.scene.id != _prevSceneId) {
      _prevSceneId = widget.scene.id;
      _displayOptions = _shuffleOptions(widget.scene.options);
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
      Future.delayed(const Duration(milliseconds: 3500), () {
        if (mounted && widget.scenePhase == StoryPhase.narrating) {
          widget.onNarrationComplete();
        }
      });
    } else if (widget.scenePhase == StoryPhase.respondingCorrect ||
        widget.scenePhase == StoryPhase.respondingWrong) {
      if (widget.selectedOptionId != null) {
        final opt = widget.scene.options.where((o) => o.id == widget.selectedOptionId).firstOrNull;
        if (opt != null) {
          widget.speakTip(opt.acknowledge.get(widget.language), widget.language);
        }
      }
    }
  }

  String _getCardState(StoryOption option) {
    final isResponding = widget.scenePhase == StoryPhase.respondingCorrect ||
        widget.scenePhase == StoryPhase.respondingWrong;
    if (!isResponding) return 'default';
    if (option.id == widget.selectedOptionId) {
      final selected = widget.scene.options.where((o) => o.id == widget.selectedOptionId).firstOrNull;
      return (selected?.correct ?? false) ? 'correct' : 'wrong';
    }
    return 'faded';
  }

  double _cardWidth(BuildContext context, {required bool isLandscape}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final raw = ((screenWidth - 48) / 2) * 0.9;
    if (!isLandscape) return raw;
    // In landscape: size cards so their height fills ~52% of screen height.
    // This leaves enough room for narration + question + feedback + Next button
    // without requiring scrolling.
    final screenHeight = MediaQuery.of(context).size.height;
    final fromHeight = (screenHeight * 0.52) / 1.1;
    return fromHeight.clamp(0.0, raw);
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    final isAsking = widget.scenePhase == StoryPhase.asking;
    final isNarrating = widget.scenePhase == StoryPhase.narrating;
    final isResponding = widget.scenePhase == StoryPhase.respondingCorrect ||
        widget.scenePhase == StoryPhase.respondingWrong;
    final isCorrect = widget.scenePhase == StoryPhase.respondingCorrect;
    final isLastScene = widget.sceneIndex >= 4;

    final selectedOption = widget.selectedOptionId != null
        ? widget.scene.options.where((o) => o.id == widget.selectedOptionId).firstOrNull
        : null;
    final feedbackText = selectedOption != null
        ? selectedOption.feedback.get(widget.language)
        : '';
    final acknowledgeText = selectedOption != null
        ? selectedOption.acknowledge.get(widget.language)
        : '';

    // ---- Top bar (shared between portrait and landscape) ----
    final topBar = Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
      child: Row(
        children: [
          SizedBox(
            width: 72,
            child: GestureDetector(
              onTap: widget.onBack,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  '← ${widget.storyStrings.back.get(widget.language)}',
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
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

    // ---- Narration + question section ----
    final narrationSection = Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Column(
        children: [
          Text(
            widget.scene.narration.get(widget.language),
            style: GoogleFonts.nunito(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.4,
              shadows: const [
                Shadow(color: Color(0x4D000000), offset: Offset(0, 1), blurRadius: 3),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          if (isAsking || isResponding) ...[
            const SizedBox(height: 6),
            Text(
              widget.scene.question.get(widget.language),
              style: GoogleFonts.nunito(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFFCD34D),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );

    // ---- Choice cards ----
    final cardW = _cardWidth(context, isLandscape: isLandscape);
    final choiceCards = Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _displayOptions.map((option) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ImageChoiceCard(
              cardWidth: cardW,
              imagePath: widget.getImage(widget.scene.id, option.id),
              emoji: option.emoji,
              label: option.label.get(widget.language),
              state: _getCardState(option),
              onPress: isAsking ? () => widget.onSelectOption(option) : null,
              disabled: !isAsking,
            ),
          );
        }).toList(),
      ),
    );

    // ---- Feedback / narrating indicator ----
    Widget? feedbackSection;
    if (isResponding) {
      feedbackSection = Container(
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: isCorrect
              ? const Color(0xFF22C55E).withOpacity(0.15)
              : const Color(0xFFEF4444).withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isCorrect
                ? const Color(0xFF22C55E).withOpacity(0.4)
                : const Color(0xFFEF4444).withOpacity(0.4),
          ),
        ),
        child: Column(
          children: [
            Text(
              acknowledgeText,
              style: GoogleFonts.nunito(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            if (feedbackText.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(
                feedbackText,
                style: GoogleFonts.nunito(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.9),
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ).animate().fadeIn(duration: 300.ms);
    } else if (isNarrating) {
      feedbackSection = Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Text(
          '...',
          style: TextStyle(fontSize: 24, color: Colors.white.withOpacity(0.4)),
        ),
      );
    }

    // ---- Action button ----
    Widget? actionButton;
    if (widget.scenePhase == StoryPhase.respondingCorrect) {
      actionButton = GestureDetector(
        onTap: widget.onAdvance,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF22C55E),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF22C55E).withOpacity(0.4),
                offset: const Offset(0, 4),
                blurRadius: 12,
              ),
            ],
          ),
          child: Text(
            '${isLastScene ? widget.storyStrings.finish.get(widget.language) : widget.storyStrings.next.get(widget.language)} →',
            style: GoogleFonts.nunito(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ).animate().fadeIn(duration: 300.ms);
    } else if (widget.scenePhase == StoryPhase.respondingWrong) {
      actionButton = GestureDetector(
        onTap: widget.onRetry,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFEF4444).withOpacity(0.3),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: const Color(0xFFEF4444).withOpacity(0.5),
              width: 2,
            ),
          ),
          child: Text(
            '${widget.storyStrings.retry.get(widget.language)} 🔄',
            style: GoogleFonts.nunito(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ).animate().fadeIn(duration: 300.ms);
    }

    // ---- Background ----
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

    // ---- Single-column layout (same in portrait and landscape) ----
    final content = SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 28),
      child: Column(
        children: [
          narrationSection,
          choiceCards,
          if (feedbackSection != null) feedbackSection,
          const SizedBox(height: 12),
          if (actionButton != null) actionButton,
          const SizedBox(height: 12),
        ],
      ),
    );

    return Stack(
      children: [
        background,
        Column(
          children: [
            topBar,
            Expanded(child: content),
          ],
        ),
      ],
    );
  }
}
