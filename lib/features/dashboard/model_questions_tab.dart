// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import 'rbb_model_papers_data.dart';

// ─────────────────────────────────────────────────────────────────────────────
// MODEL QUESTION PAPERS — Authentic Lok Sewa Aayog Question Paper Format
// Pixel-accurate reproduction of official PSC examination question papers
// ─────────────────────────────────────────────────────────────────────────────

class ModelQuestionsTab extends StatefulWidget {
  final VoidCallback onGoToExams;
  const ModelQuestionsTab({super.key, required this.onGoToExams});

  @override
  State<ModelQuestionsTab> createState() => _ModelQuestionsTabState();
}

class _ModelQuestionsTabState extends State<ModelQuestionsTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentPaper = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: rbbModelPapers.length, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() => _currentPaper = _tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _printPaper() {
    if (kIsWeb) {
      try {
        html.window.print();
      } catch (_) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 768;

    return Column(
      children: [
        // Top Toolbar
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 12 : 24,
            vertical: isMobile ? 8 : 12,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: AppTheme.iconRedLight,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(Icons.description, color: AppTheme.iconRed, size: 18),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'राष्ट्रिय वाणिज्य बैंक (RBB) IT Level 5 — नमूना प्रश्नपत्र (Model Sets)',
                          style: TextStyle(
                            fontSize: isMobile ? 13.5 : 15.5,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        Text(
                          'Strictly according to RBB IT syllabus • Tap \'Reveal Answer\' to view model solutions',
                          style: TextStyle(
                            fontSize: isMobile ? 11 : 12,
                            color: const Color(0xFF64748B),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (kIsWeb)
                    OutlinedButton.icon(
                      onPressed: _printPaper,
                      icon: const Icon(Icons.print_outlined, size: 16),
                      label: Text(isMobile ? 'Print' : 'Print Paper (प्रिन्ट)'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF334155),
                        side: const BorderSide(color: Color(0xFFCBD5E1)),
                        padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 14, vertical: 8),
                        textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 10),
              // Tab bar
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(3),
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  labelColor: AppTheme.iconRedDark,
                  unselectedLabelColor: const Color(0xFF64748B),
                  labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5),
                  unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12.5),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  tabs: rbbModelPapers.asMap().entries.map((e) {
                    final isSel = _currentPaper == e.key;
                    return Tab(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(e.value.icon, size: 14, color: isSel ? AppTheme.iconRed : const Color(0xFF64748B)),
                            const SizedBox(width: 6),
                            Text(e.value.tabLabel),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),

        // Paper View container on realistic neutral desk background
        Expanded(
          child: Container(
            color: const Color(0xFFE5E7EB), // Neutral desk surface
            child: TabBarView(
              controller: _tabController,
              children: rbbModelPapers.map((paper) => _PaperView(paper: paper)).toList(),
            ),
          ),
        ),
      ],
    );
  }
}



class _AnswerBody extends StatelessWidget {
  final String text;
  const _AnswerBody({required this.text});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 768;
    final baseFontSize = isMobile ? 12.5 : 13.5;

    final lines = text.trim().split('\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: lines.map((line) {
        final t = line.trim();
        if (t.isEmpty) return const SizedBox(height: 8);

        // Heading: ### or ## or #
        if (t.startsWith('### ') || t.startsWith('## ') || t.startsWith('# ')) {
          final h = t.replaceAll(RegExp(r'^#+\s*'), '');
          return Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 4),
            child: Text(
              h,
              style: TextStyle(
                fontFamily: 'serif',
                fontSize: baseFontSize + 1.5,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF0F172A),
              ),
            ),
          );
        }

        // Bullet line: - or *
        if (t.startsWith('- ') || t.startsWith('* ')) {
          final body = t.substring(2).trim();
          return Padding(
            padding: const EdgeInsets.only(top: 3, left: 8),
            child: _richLine(body, baseFontSize, prefix: '•  ', prefixColor: const Color(0xFFDC2626)),
          );
        }

        // Numbered list: 1. or 1)
        final numMatch = RegExp(r'^(\d+[\.\)])\s*(.*)$').firstMatch(t);
        if (numMatch != null) {
          final numPrefix = numMatch.group(1)!;
          final body = numMatch.group(2)!;
          return Padding(
            padding: const EdgeInsets.only(top: 4, left: 8),
            child: _richLine(body, baseFontSize, prefix: '$numPrefix  ', prefixColor: const Color(0xFF1E293B)),
          );
        }

        // Regular paragraph or bold sub-heading
        return Padding(
          padding: const EdgeInsets.only(top: 4),
          child: _richLine(t, baseFontSize),
        );
      }).toList(),
    );
  }

  Widget _richLine(String raw, double fontSize, {String? prefix, Color? prefixColor}) {
    final spans = <TextSpan>[];

    if (prefix != null && prefix.isNotEmpty) {
      spans.add(
        TextSpan(
          text: prefix,
          style: TextStyle(
            fontFamily: 'serif',
            fontSize: fontSize,
            fontWeight: FontWeight.w800,
            color: prefixColor ?? const Color(0xFF1E293B),
          ),
        ),
      );
    }

    final regex = RegExp(r'(\*\*\*([^\*]+?)\*\*\*|\*\*([^\*]+?)\*\*|\*([^\*]+?)\*)');
    int lastEnd = 0;
    final base = TextStyle(
      fontFamily: 'serif',
      fontSize: fontSize,
      color: const Color(0xFF1E293B),
      height: 1.55,
      fontWeight: FontWeight.w500,
    );

    for (final match in regex.allMatches(raw)) {
      if (match.start > lastEnd) {
        final plain = raw.substring(lastEnd, match.start).replaceAll('*', '');
        if (plain.isNotEmpty) spans.add(TextSpan(text: plain));
      }
      final b3 = match.group(2), b2 = match.group(3), b1 = match.group(4);
      if (b3 != null && b3.isNotEmpty) {
        spans.add(TextSpan(text: b3, style: base.copyWith(fontWeight: FontWeight.w800, fontStyle: FontStyle.italic)));
      } else if (b2 != null && b2.isNotEmpty) {
        spans.add(TextSpan(text: b2, style: base.copyWith(fontWeight: FontWeight.w800, color: const Color(0xFF0F172A))));
      } else if (b1 != null && b1.isNotEmpty) {
        spans.add(TextSpan(text: b1, style: base.copyWith(fontStyle: FontStyle.italic, fontWeight: FontWeight.w600)));
      }
      lastEnd = match.end;
    }

    if (lastEnd < raw.length) {
      final tail = raw.substring(lastEnd).replaceAll('*', '');
      if (tail.isNotEmpty) spans.add(TextSpan(text: tail));
    }

    if (spans.isEmpty) return Text(raw.replaceAll('*', ''), style: base);
    return Text.rich(TextSpan(style: base, children: spans));
  }
}

class _PaperView extends StatefulWidget {
  final ModelPaper paper;
  const _PaperView({required this.paper});

  @override
  State<_PaperView> createState() => _PaperViewState();
}

class _PaperViewState extends State<_PaperView> {
  int? _openSectionIdx;
  int? _openQuestionIdx;

  void _toggleAnswer(int secIdx, int qIdx) {
    setState(() {
      if (_openSectionIdx == secIdx && _openQuestionIdx == qIdx) {
        _openSectionIdx = null;
        _openQuestionIdx = null;
      } else {
        _openSectionIdx = secIdx;
        _openQuestionIdx = qIdx;
      }
    });
  }

  void _collapseAll() {
    setState(() {
      _openSectionIdx = null;
      _openQuestionIdx = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 768;
    final paper = widget.paper;

    return SelectionArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 8 : 24,
        vertical: isMobile ? 12 : 24,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 840),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFCCCCCC), width: 1.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 18,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 46,
                  vertical: isMobile ? 22 : 40,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text(
                        paper.commissionName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'serif',
                          fontSize: isMobile ? 20 : 23,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Center(
                      child: Text(
                        paper.serviceName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'serif',
                          fontSize: isMobile ? 12 : 13.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          height: 1.35,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Center(
                      child: Text(
                        paper.examType,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'serif',
                          fontSize: isMobile ? 13 : 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Center(
                      child: Text(
                        paper.examDate,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'serif',
                          fontSize: isMobile ? 12 : 13.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          paper.timeDuration != null ? 'समय:- ${paper.timeDuration!}' : paper.timeString,
                          style: TextStyle(
                            fontFamily: 'serif',
                            fontSize: isMobile ? 13 : 14.5,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          paper.fullMarks != null ? 'पूर्णाङ्क:- ${paper.fullMarks}' : paper.fullMarksString,
                          style: TextStyle(
                            fontFamily: 'serif',
                            fontSize: isMobile ? 13 : 14.5,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        paper.paperNumber != null ? 'पत्र:- ${paper.paperNumber!}' : paper.paperTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'serif',
                          fontSize: isMobile ? 13.5 : 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Center(
                      child: Text(
                        paper.subject != null ? 'विषय:- ${paper.subject!}' : paper.subjectTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'serif',
                          fontSize: isMobile ? 13.5 : 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        paper.instructionsText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'serif',
                          fontSize: isMobile ? 11.5 : 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          decorationThickness: 1.3,
                          height: 1.45,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...paper.sections.asMap().entries.map((secEntry) {
                      final secIdx = secEntry.key;
                      final section = secEntry.value;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 18, bottom: 12),
                            child: Row(
                              children: [
                                const SizedBox(width: 70),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      section.title,
                                      style: TextStyle(
                                        fontFamily: 'serif',
                                        fontSize: isMobile ? 14 : 16,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.black,
                                        decoration: TextDecoration.underline,
                                        decorationThickness: 1.6,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 70,
                                  child: Text(
                                    '${section.totalMarks}-Marks',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontFamily: 'serif',
                                      fontSize: isMobile ? 12 : 13.5,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ...section.questions.asMap().entries.map((qEntry) {
                            final qIdx = qEntry.key;
                            final q = qEntry.value;
                            final isOpen = _openSectionIdx == secIdx && _openQuestionIdx == qIdx;

                            final bool isContinuation = qEntry.key > 0 &&
                                section.questions[qEntry.key - 1].number == q.number;

                            return _QuestionRow(
                              question: q,
                              showNumber: !isContinuation,
                              isAnswerOpen: isOpen,
                              isMobile: isMobile,
                              onToggleAnswer: () => _toggleAnswer(secIdx, qIdx),
                            );
                          }),
                        ],
                      );
                    }),
                    const SizedBox(height: 24),
                    Center(
                      child: Text(
                        '— समाप्त (The End) —',
                        style: TextStyle(
                          fontFamily: 'serif',
                          fontSize: isMobile ? 12 : 13,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF4B5563),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              if (_openSectionIdx != null)
                TextButton.icon(
                  onPressed: _collapseAll,
                  icon: const Icon(Icons.unfold_less, size: 16),
                  label: const Text('Collapse Open Answer (उत्तर बन्द गर्नुहोस्)'),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF4B5563),
                  ),
                ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      ),
    );
  }
}

class _QuestionRow extends StatelessWidget {
  final ModelQuestion question;
  final bool showNumber;
  final bool isAnswerOpen;
  final bool isMobile;
  final VoidCallback onToggleAnswer;

  const _QuestionRow({
    required this.question,
    required this.showNumber,
    required this.isAnswerOpen,
    required this.isMobile,
    required this.onToggleAnswer,
  });

  @override
  Widget build(BuildContext context) {
    final sub = question.subLabel;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: isMobile ? 20 : 26,
                child: Text(
                  showNumber ? '${question.number}.' : '',
                  style: TextStyle(
                    fontFamily: 'serif',
                    fontSize: isMobile ? 13.5 : 14.5,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
              ),
              if (sub != null && sub.isNotEmpty) ...[
                SizedBox(
                  width: isMobile ? 18 : 22,
                  child: Text(
                    sub,
                    style: TextStyle(
                      fontFamily: 'serif',
                      fontSize: isMobile ? 13.5 : 14.5,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      question.questionText,
                      style: TextStyle(
                        fontFamily: 'serif',
                        fontSize: isMobile ? 13.5 : 14.5,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        height: 1.45,
                      ),
                    ),
                    if (question.questionTextNepali != null) ...[
                      const SizedBox(height: 3),
                      Text(
                        question.questionTextNepali!,
                        style: TextStyle(
                          fontFamily: 'serif',
                          fontSize: isMobile ? 12.5 : 13.5,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF262626),
                          height: 1.4,
                        ),
                      ),
                    ],
                    if (question.options != null && question.options!.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Wrap(
                          spacing: 16,
                          runSpacing: 4,
                          children: question.options!.asMap().entries.map((entry) {
                            final letters = ['(A)', '(B)', '(C)', '(D)', '(E)'];
                            final label = entry.key < letters.length ? letters[entry.key] : '(${entry.key + 1})';
                            return SizedBox(
                              width: isMobile ? double.infinity : 320,
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontFamily: 'serif',
                                    fontSize: isMobile ? 12.0 : 13.0,
                                    color: const Color(0xFF1E293B),
                                    height: 1.35,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '$label ',
                                      style: const TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF0F172A)),
                                    ),
                                    TextSpan(text: entry.value),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                    const SizedBox(height: 5),
                    InkWell(
                      onTap: onToggleAnswer,
                      borderRadius: BorderRadius.circular(4),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isAnswerOpen ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              size: 13,
                              color: isAnswerOpen ? AppTheme.iconRedDark : const Color(0xFF1D4ED8),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              isAnswerOpen
                                  ? 'Hide Answer (बन्द गर्नुहोस्)'
                                  : 'Reveal Answer (उत्तर हेर्नुहोस्)',
                              style: TextStyle(
                                fontFamily: 'serif',
                                fontSize: isMobile ? 11.5 : 12,
                                fontWeight: FontWeight.w700,
                                color: isAnswerOpen ? AppTheme.iconRedDark : const Color(0xFF1D4ED8),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                question.marksBreakdown,
                style: TextStyle(
                  fontFamily: 'serif',
                  fontSize: isMobile ? 13.5 : 14.5,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          if (isAnswerOpen)
            Container(
              margin: EdgeInsets.only(
                top: 8,
                left: isMobile ? 16 : 48,
                right: 0,
                bottom: 8,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFFFAF9F6),
                border: Border(
                  left: BorderSide(color: Color(0xFFDC2626), width: 3.0),
                  top: BorderSide(color: Color(0xFFE2E8F0), width: 1.0),
                  bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1.0),
                  right: BorderSide(color: Color(0xFFE2E8F0), width: 1.0),
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
              ),
              padding: EdgeInsets.all(isMobile ? 12 : 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.edit_note, size: 18, color: Color(0xFFDC2626)),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                'नमूना उत्तर (Model Answer Script)',
                                style: TextStyle(
                                  fontFamily: 'serif',
                                  fontSize: isMobile ? 12.5 : 13.5,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF991B1B),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEE2E2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'अङ्क: ${question.marksBreakdown}',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF991B1B),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 16, color: Color(0xFFE2E8F0)),
                  _AnswerBody(text: question.answer),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
