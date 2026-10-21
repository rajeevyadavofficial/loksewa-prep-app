import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

// ─────────────────────────────────────────────────────────────────────────────
// MODEL QUESTION PAPERS — RBB Senior Assistant (IT) Level 5
// Format strictly matches official Lok Sewa Aayog exam paper format
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
    _tabController = TabController(length: _modelPapers.length, vsync: this);
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

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 768;

    return Column(
      children: [
        // Header bar
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 14 : 28,
            vertical: isMobile ? 10 : 14,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.iconRedLight,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.iconRed.withOpacity(0.3)),
                    ),
                    child: const Icon(Icons.article_outlined, color: AppTheme.iconRed, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Model Question Papers',
                        style: TextStyle(
                          fontSize: isMobile ? 17 : 20,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.textPrimary,
                          letterSpacing: -0.4,
                        ),
                      ),
                      Text(
                        'RBB Senior Assistant (IT) — Level 5 | Lok Sewa Format',
                        style: TextStyle(
                          fontSize: isMobile ? 11 : 12.5,
                          color: AppTheme.textMuted,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // Paper selector tabs
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F4F5),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(4),
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: AppTheme.iconRed.withOpacity(0.25)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  labelColor: AppTheme.iconRedDark,
                  unselectedLabelColor: AppTheme.textMuted,
                  labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                  unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  tabs: _modelPapers.asMap().entries.map((e) {
                    return Tab(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              e.value.icon,
                              size: 15,
                              color: _currentPaper == e.key ? AppTheme.iconRed : AppTheme.textMuted,
                            ),
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
        const Divider(height: 1, color: AppTheme.divider),
        // Paper content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: _modelPapers.map((paper) => _PaperView(paper: paper)).toList(),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// DATA MODEL
// ─────────────────────────────────────────────────────────────────────────────

class ModelPaper {
  final String tabLabel;
  final String paperNumber;     // e.g. "Paper I"
  final String subject;         // Nepali subject title
  final String subjectEng;
  final String setNumber;       // "Set A", "Set B", etc.
  final int fullMarks;
  final int passMarks;
  final String timeDuration;
  final IconData icon;
  final List<ModelSection> sections;

  const ModelPaper({
    required this.tabLabel,
    required this.paperNumber,
    required this.subject,
    required this.subjectEng,
    required this.setNumber,
    required this.fullMarks,
    required this.passMarks,
    required this.timeDuration,
    required this.icon,
    required this.sections,
  });
}

class ModelSection {
  final String title;          // "समूह 'क' (Group A)"
  final String subtitle;       // "Banking & Organizational Management"
  final int totalMarks;
  final List<ModelQuestion> questions;

  const ModelSection({
    required this.title,
    required this.subtitle,
    required this.totalMarks,
    required this.questions,
  });
}

class ModelQuestion {
  final int number;
  final String questionText;
  final String? questionTextNepali;
  final int marks;
  final String marksBreakdown;   // e.g. "4+6=10" or "5"
  final String answer;           // Full model answer
  final bool isPremium;

  const ModelQuestion({
    required this.number,
    required this.questionText,
    this.questionTextNepali,
    required this.marks,
    required this.marksBreakdown,
    required this.answer,
    this.isPremium = false,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// PAPER VIEW — renders a single model paper with official Lok Sewa format
// ─────────────────────────────────────────────────────────────────────────────

class _PaperView extends StatefulWidget {
  final ModelPaper paper;
  const _PaperView({required this.paper});

  @override
  State<_PaperView> createState() => _PaperViewState();
}

class _PaperViewState extends State<_PaperView> {
  // Track which (sectionIndex, questionIndex) is currently open
  int? _openSectionIdx;
  int? _openQuestionIdx;

  void _toggleAnswer(int secIdx, int qIdx) {
    setState(() {
      if (_openSectionIdx == secIdx && _openQuestionIdx == qIdx) {
        // Collapse if same question clicked
        _openSectionIdx = null;
        _openQuestionIdx = null;
      } else {
        _openSectionIdx = secIdx;
        _openQuestionIdx = qIdx;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 768;
    final paper = widget.paper;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 32,
        vertical: isMobile ? 14 : 24,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── OFFICIAL QUESTION PAPER CARD ──
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFF2D2D2D), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ── OFFICIAL HEADER ──
                    _buildOfficialHeader(paper, isMobile),

                    // ── INSTRUCTIONS ──
                    _buildInstructions(paper, isMobile),

                    // ── SECTIONS & QUESTIONS ──
                    ...paper.sections.asMap().entries.map((secEntry) {
                      final secIdx = secEntry.key;
                      final section = secEntry.value;
                      return _buildSection(
                        section: section,
                        secIdx: secIdx,
                        isMobile: isMobile,
                      );
                    }),

                    // ── FOOTER ──
                    _buildFooter(paper, isMobile),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── TIP BOX ──
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppTheme.iconRedLight,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.iconRed.withOpacity(0.3)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.tips_and_updates_outlined, color: AppTheme.iconRed, size: 18),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Tip: Attempt all questions without looking at the answers first. Then click "Reveal Answer" to compare your response with the model answer.',
                        style: TextStyle(
                          fontSize: isMobile ? 12.5 : 13,
                          color: AppTheme.iconRedDark,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOfficialHeader(ModelPaper paper, bool isMobile) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF2D2D2D), width: 1.5)),
      ),
      child: Column(
        children: [
          // Top row: Nepal Govt + logo area
          Container(
            color: const Color(0xFFFAFAFA),
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 12 : 24,
              vertical: isMobile ? 10 : 14,
            ),
            child: Column(
              children: [
                // Organization name
                Text(
                  'नेपाल सरकार',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 14 : 16,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1A1A1A),
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  'Government of Nepal',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 10 : 11.5,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textMuted,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'लोक सेवा आयोग',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 16 : 19,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.iconRedDark,
                    letterSpacing: 1.0,
                  ),
                ),
                Text(
                  'Public Service Commission (PSC)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 10 : 11.5,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textMuted,
                  ),
                ),
                const SizedBox(height: 8),
                // Thin red divider
                Container(height: 2, color: AppTheme.iconRed),
                const SizedBox(height: 8),
                // Exam title
                Text(
                  'खुला तथा समावेशी प्रतियोगितात्मक लिखित परीक्षा',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 12 : 13.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
                Text(
                  'Open & Inclusive Competitive Written Examination',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 10 : 11,
                    color: AppTheme.textMuted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'राष्ट्रिय बाणिज्य बैंक लिमिटेड — सिनियर असिस्टेन्ट (IT) — तह ५',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 12 : 13,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.iconRedDark,
                  ),
                ),
                Text(
                  'Rastriya Banijya Bank Ltd. — Senior Assistant (IT) — Level 5',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 10 : 11,
                    color: AppTheme.textMuted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Meta bar: Paper, Subject, Marks, Time, Set
          Container(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 24, vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Color(0xFFD4D4D8)),
                bottom: BorderSide(color: Color(0xFFD4D4D8)),
              ),
            ),
            child: isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _metaRow('पत्र / Paper', paper.paperNumber),
                      const SizedBox(height: 4),
                      _metaRow('विषय / Subject', '${paper.subject} / ${paper.subjectEng}'),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(child: _metaRow('पूर्णाङ्क / Full Marks', '${paper.fullMarks}')),
                          Expanded(child: _metaRow('उत्तीर्णाङ्क / Pass', '${paper.passMarks}')),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(child: _metaRow('समय / Time', paper.timeDuration)),
                          Expanded(child: _metaRow('सेट / Set', paper.setNumber)),
                        ],
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(flex: 2, child: _metaRow('पत्र / Paper', paper.paperNumber)),
                      Expanded(flex: 4, child: _metaRow('विषय / Subject', '${paper.subject} / ${paper.subjectEng}')),
                      Expanded(flex: 2, child: _metaRow('पूर्णाङ्क / Full Marks', '${paper.fullMarks}')),
                      Expanded(flex: 2, child: _metaRow('उत्तीर्णाङ्क / Pass', '${paper.passMarks}')),
                      Expanded(flex: 2, child: _metaRow('समय / Time', paper.timeDuration)),
                      Expanded(flex: 1, child: _metaRow('Set', paper.setNumber)),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _metaRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: AppTheme.textMuted, fontWeight: FontWeight.w500)),
        Text(value, style: const TextStyle(fontSize: 12.5, color: AppTheme.textPrimary, fontWeight: FontWeight.w700)),
      ],
    );
  }

  Widget _buildInstructions(ModelPaper paper, bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 14 : 24, vertical: 10),
      color: const Color(0xFFFEFCE8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'द्रष्टव्य (Instructions):',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12.5, color: Color(0xFF78350F)),
          ),
          const SizedBox(height: 4),
          _instrLine('सबै प्रश्नहरूका उत्तर दिनु अनिवार्य छ।  (All questions are compulsory.)'),
          _instrLine('उत्तरपुस्तिकाको समूह "क" को उत्तर "क" समूह लेख्ने उत्तरपुस्तिकामा र "ख" समूहको उत्तर "ख" समूह लेख्ने उत्तरपुस्तिकामा छुट्टाछुट्टै लेख्नुपर्नेछ।'),
          _instrLine('दायाँ छेउका अङ्कहरूले प्रश्नको पूर्णाङ्क जनाउँछन्।  (Figures on the right margin indicate full marks.)'),
          _instrLine('उत्तर सकेसम्म आफ्नै शब्दमा लेख्नुपर्नेछ।  (Answers must be written in one\'s own words as far as practicable.)'),
        ],
      ),
    );
  }

  Widget _instrLine(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('•  ', style: TextStyle(fontSize: 11, color: Color(0xFF92400E), fontWeight: FontWeight.w700)),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 11, color: Color(0xFF78350F), height: 1.45)),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required ModelSection section,
    required int secIdx,
    required bool isMobile,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Section header banner
        Container(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 14 : 24, vertical: 10),
          decoration: BoxDecoration(
            color: AppTheme.iconRed.withOpacity(0.07),
            border: const Border(
              top: BorderSide(color: Color(0xFF2D2D2D), width: 1.0),
              bottom: BorderSide(color: Color(0xFFD4D4D8), width: 0.8),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      section.title,
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 15.5,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.iconRedDark,
                        letterSpacing: 0.3,
                      ),
                    ),
                    Text(
                      section.subtitle,
                      style: TextStyle(
                        fontSize: isMobile ? 11 : 12,
                        color: AppTheme.textMuted,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.iconRedDark,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '${section.totalMarks} Marks',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12),
                ),
              ),
            ],
          ),
        ),

        // Questions
        ...section.questions.asMap().entries.map((qEntry) {
          final qIdx = qEntry.key;
          final q = qEntry.value;
          final isOpen = _openSectionIdx == secIdx && _openQuestionIdx == qIdx;

          return _QuestionCard(
            question: q,
            isAnswerOpen: isOpen,
            isMobile: isMobile,
            onToggleAnswer: () => _toggleAnswer(secIdx, qIdx),
          );
        }),
      ],
    );
  }

  Widget _buildFooter(ModelPaper paper, bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 14 : 24, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFFFAFAFA),
        border: Border(top: BorderSide(color: Color(0xFF2D2D2D), width: 1.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '— समाप्त / End of ${paper.paperNumber} (${paper.setNumber}) —',
            style: const TextStyle(fontSize: 12, color: AppTheme.textMuted, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.iconRed.withOpacity(0.4)),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'LoksewaHero — ${paper.setNumber}',
              style: const TextStyle(fontSize: 11, color: AppTheme.iconRedDark, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SINGLE QUESTION CARD with reveal answer accordion
// ─────────────────────────────────────────────────────────────────────────────

class _QuestionCard extends StatelessWidget {
  final ModelQuestion question;
  final bool isAnswerOpen;
  final bool isMobile;
  final VoidCallback onToggleAnswer;

  const _QuestionCard({
    required this.question,
    required this.isAnswerOpen,
    required this.isMobile,
    required this.onToggleAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE4E4E7), width: 0.8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Question row
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 14 : 24,
              vertical: isMobile ? 12 : 14,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Question number badge
                Container(
                  width: 28,
                  height: 28,
                  margin: const EdgeInsets.only(top: 1, right: 12),
                  decoration: BoxDecoration(
                    color: AppTheme.iconRed,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      '${question.number}',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 13),
                    ),
                  ),
                ),
                // Question text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question.questionText,
                        style: TextStyle(
                          fontSize: isMobile ? 13.5 : 14.5,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                          height: 1.55,
                          letterSpacing: -0.1,
                        ),
                      ),
                      if (question.questionTextNepali != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          question.questionTextNepali!,
                          style: TextStyle(
                            fontSize: isMobile ? 12.5 : 13.5,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.textMuted,
                            height: 1.5,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                // Marks badge
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppTheme.iconRed.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                      ),
                      child: Text(
                        '[${question.marksBreakdown}]',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.iconRedDark,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${question.marks} marks',
                      style: const TextStyle(fontSize: 10, color: AppTheme.textMuted),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Reveal Answer button
          Padding(
            padding: EdgeInsets.only(
              left: isMobile ? 54 : 64,
              right: isMobile ? 14 : 24,
              bottom: isAnswerOpen ? 0 : 12,
            ),
            child: InkWell(
              onTap: onToggleAnswer,
              borderRadius: BorderRadius.circular(7),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  color: isAnswerOpen ? AppTheme.iconRedDark : AppTheme.iconRedLight,
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(
                    color: isAnswerOpen ? AppTheme.iconRedDark : AppTheme.iconRed.withOpacity(0.4),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isAnswerOpen ? Icons.keyboard_arrow_up_rounded : Icons.visibility_outlined,
                      size: 15,
                      color: isAnswerOpen ? Colors.white : AppTheme.iconRed,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      isAnswerOpen ? 'Hide Answer' : 'Reveal Answer',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: isAnswerOpen ? Colors.white : AppTheme.iconRed,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Answer panel (animated)
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 280),
            crossFadeState: isAnswerOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            firstChild: const SizedBox(height: 12, width: double.infinity),
            secondChild: _buildAnswerPanel(isMobile),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerPanel(bool isMobile) {
    if (!isAnswerOpen) return const SizedBox.shrink();

    return Container(
      margin: EdgeInsets.only(
        left: isMobile ? 14 : 24,
        right: isMobile ? 14 : 24,
        top: 8,
        bottom: 14,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF86EFAC), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Answer header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFDCFCE7),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              border: Border(bottom: BorderSide(color: const Color(0xFF86EFAC).withOpacity(0.8))),
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle_rounded, color: Color(0xFF16A34A), size: 16),
                const SizedBox(width: 8),
                const Text(
                  'Model Answer',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF166534),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFF16A34A),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '[${question.marksBreakdown}]',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
          // Answer body
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 16, vertical: 12),
            child: _AnswerBody(text: question.answer, isMobile: isMobile),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Answer body renderer — handles bullet, heading, numbered lists
// ─────────────────────────────────────────────────────────────────────────────

class _AnswerBody extends StatelessWidget {
  final String text;
  final bool isMobile;

  const _AnswerBody({required this.text, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final baseFontSize = isMobile ? 13.0 : 13.5;
    final lines = text.split('\n').where((l) => l.trim().isNotEmpty).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines.map((line) {
        final t = line.trim();

        // Heading: starts with # or ends with : and is short
        if (t.startsWith('#') || (t.endsWith(':') && t.length < 80 && !t.startsWith('•') && !t.startsWith('-'))) {
          final clean = t.replaceFirst(RegExp(r'^#+\s*'), '');
          return Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 2),
            child: Text(
              clean,
              style: TextStyle(
                fontSize: baseFontSize,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF166534),
                decoration: TextDecoration.underline,
                decorationColor: const Color(0xFF16A34A).withOpacity(0.5),
              ),
            ),
          );
        }

        // Bullet
        if (t.startsWith('•') || t.startsWith('-') || t.startsWith('*')) {
          final content = t.replaceFirst(RegExp(r'^[•\-\*]\s*'), '');
          return Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('•  ', style: TextStyle(color: Color(0xFF16A34A), fontWeight: FontWeight.w800, fontSize: 13)),
                Expanded(
                  child: _richLine(content, baseFontSize),
                ),
              ],
            ),
          );
        }

        // Numbered list
        if (RegExp(r'^\d+[.)]\s').hasMatch(t)) {
          return Padding(
            padding: const EdgeInsets.only(top: 4),
            child: _richLine(t, baseFontSize),
          );
        }

        // Regular paragraph
        return Padding(
          padding: const EdgeInsets.only(top: 4),
          child: _richLine(t, baseFontSize),
        );
      }).toList(),
    );
  }

  Widget _richLine(String raw, double fontSize) {
    final spans = <TextSpan>[];
    final regex = RegExp(r'(\*\*\*([^*]+?)\*\*\*|\*\*([^*]+?)\*\*|\*([^*]+?)\*)');
    int lastEnd = 0;
    final base = TextStyle(fontSize: fontSize, color: const Color(0xFF14532D), height: 1.55, fontWeight: FontWeight.w500);

    for (final match in regex.allMatches(raw)) {
      if (match.start > lastEnd) {
        final plain = raw.substring(lastEnd, match.start).replaceAll('*', '');
        if (plain.isNotEmpty) spans.add(TextSpan(text: plain));
      }
      final b3 = match.group(2), b2 = match.group(3), b1 = match.group(4);
      if (b3 != null && b3.isNotEmpty) {
        spans.add(TextSpan(text: b3, style: base.copyWith(fontWeight: FontWeight.w800, fontStyle: FontStyle.italic)));
      } else if (b2 != null && b2.isNotEmpty) {
        spans.add(TextSpan(text: b2, style: base.copyWith(fontWeight: FontWeight.w800, color: const Color(0xFF166534))));
      } else if (b1 != null && b1.isNotEmpty) {
        spans.add(TextSpan(text: b1, style: base.copyWith(fontStyle: FontStyle.italic, fontWeight: FontWeight.w600)));
      }
      lastEnd = match.end;
    }

    if (lastEnd < raw.length) {
      final tail = raw.substring(lastEnd).replaceAll('*', '');
      if (tail.isNotEmpty) spans.add(TextSpan(text: tail));
    }

    if (spans.isEmpty) return SelectableText(raw.replaceAll('*', ''), style: base);
    return SelectableText.rich(TextSpan(style: base, children: spans));
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// MODEL PAPER DATA — RBB Senior Assistant IT Level 5
// Strict Lok Sewa official format:
//  Paper I  — Banking, Accounting & Management (100 Marks)
//    Group A — Banking & Organizational Management (50 Marks)
//    Group B — Information Technology (50 Marks)
//  Paper II — Information Technology & Management (100 Marks)
//    Group A — Computer Networks, OS, DBMS, Web (50 Marks)
//    Group B — Cybersecurity, IT Policies, NRB Guidelines (50 Marks)
// ─────────────────────────────────────────────────────────────────────────────

const List<ModelPaper> _modelPapers = [
  // ══════════════════════════════════════════════════════════════════════
  //  PAPER I — SET A
  // ══════════════════════════════════════════════════════════════════════
  ModelPaper(
    tabLabel: 'Paper I  —  Set A',
    paperNumber: 'प्रथम पत्र (Paper I)',
    subject: 'बैंकिङ, लेखा तथा व्यवस्थापन',
    subjectEng: 'Banking, Accounting & Management',
    setNumber: 'Set A',
    fullMarks: 100,
    passMarks: 40,
    timeDuration: '३ घण्टा (3 Hours)',
    icon: Icons.account_balance_outlined,
    sections: [
      ModelSection(
        title: "समूह 'क'  (Group A)",
        subtitle: 'Banking & Organizational Management — 50 Marks',
        totalMarks: 50,
        questions: [
          ModelQuestion(
            number: 1,
            questionText: 'What is the role of Nepal Rastra Bank (NRB) as a central bank of Nepal? Explain its monetary policy tools and how they control inflation and promote financial stability.',
            questionTextNepali: 'नेपाल राष्ट्र बैंकको केन्द्रीय बैंकको रूपमा भूमिका के हो? यसका मौद्रिक नीतिका उपकरणहरू र तिनले मुद्रास्फीति नियन्त्रण गरी वित्तीय स्थिरता कसरी प्रवर्द्धन गर्छन् भनी स्पष्ट पार्नुहोस्।',
            marks: 10,
            marksBreakdown: '5+5=10',
            answer: '''**1. Role of Nepal Rastra Bank (NRB) as Central Bank:**

Nepal Rastra Bank, established under **Nepal Rastra Bank Act, 2058 (2002)**, is Nepal's apex monetary authority and operates as the regulatory and supervisory body for all banks and financial institutions.

**Key Roles:**
- **Monetary Authority:** Formulates and implements monetary policy to maintain price stability and manage money supply.
- **Regulatory Body:** Licenses, regulates, and supervises all BFIs under BAFIA 2073.
- **Government's Banker:** Manages government accounts, public debt, and foreign exchange reserves.
- **Lender of Last Resort:** Provides emergency liquidity to solvent banks facing temporary shortfalls.
- **Clearing House:** Facilitates interbank settlement and operates the RTGS (Real Time Gross Settlement) system.
- **Foreign Exchange Management:** Controls and monitors foreign exchange reserves and transactions.

**2. Monetary Policy Tools to Control Inflation and Financial Stability:**

*A. Quantitative Instruments:*
- **Cash Reserve Ratio (CRR):** Minimum percentage (currently ~4%) of total deposits BFIs must hold with NRB. Increasing CRR reduces money in circulation.
- **Bank Rate / Repo Rate:** Interest rate at which NRB lends to commercial banks. Higher rate → costlier borrowing → reduced money supply → inflation control.
- **Open Market Operations (OMO):** NRB buys/sells government securities to inject or absorb liquidity from the banking system.
- **Credit-to-Deposit (CD) Ratio:** Limits excessive lending relative to deposits, currently capped at 90%.

*B. Qualitative Instruments:*
- **Moral Suasion:** NRB advises BFIs on lending practices, discouraging excessive credit flows.
- **Selective Credit Control:** Directs credit toward priority sectors (agriculture, SMEs) and away from speculative sectors.
- **Margin Requirements:** Sets minimum margin for loans against securities.

**Conclusion:** Through the coordinated use of these tools, NRB maintains **price stability**, **financial system integrity**, and promotes **sustainable economic growth** in Nepal — core objectives under the NRB Act 2058.''',
          ),
          ModelQuestion(
            number: 2,
            questionText: 'Define Capital Adequacy Ratio (CAR) under Basel III norms. Why is it critical for the stability of commercial banks in Nepal? What is the current CAR requirement set by NRB?',
            questionTextNepali: 'बेसल III मापदण्ड अन्तर्गत पूँजी पर्याप्तता अनुपात (CAR) परिभाषित गर्नुहोस्। यो नेपालका वाणिज्य बैंकहरूको स्थिरताका लागि किन महत्वपूर्ण छ? NRB ले तोकेको हालको CAR आवश्यकता के हो?',
            marks: 10,
            marksBreakdown: '4+6=10',
            answer: '''**1. Definition — Capital Adequacy Ratio (CAR) under Basel III:**

CAR is the ratio of a bank's **Tier 1 and Tier 2 capital** to its **Risk-Weighted Assets (RWA)**:

**CAR = (Tier 1 Capital + Tier 2 Capital) / Risk-Weighted Assets × 100%**

- **Tier 1 Capital (Core Capital):** Paid-up share capital, statutory reserves, retained earnings, and other disclosed reserves — represents the highest quality capital.
- **Tier 2 Capital (Supplementary Capital):** General loan loss provisions (up to 1.25% of RWA), revaluation reserves, subordinated debt.
- **Risk-Weighted Assets:** Each asset class is assigned a risk weight (e.g., Cash = 0%, Government bonds = 0%, Corporate loans = 100%, retail mortgages = 50%).

**2. Critical Importance for Nepalese Commercial Banks:**

- **Absorbs Financial Losses:** Ensures banks can absorb unexpected loan defaults and market losses without becoming insolvent, protecting depositors.
- **Depositor and Creditor Confidence:** Adequate capital signals financial health, maintaining public trust in the banking system.
- **Regulatory Compliance:** Non-compliance leads to supervisory actions including restricted dividend payment, limitation on branch expansion, and potential license cancellation.
- **Prevents Bank Runs:** Well-capitalized banks can withstand sudden large withdrawal demands.
- **Macroprudential Stability:** Prevents systemic risk — if one major bank fails due to undercapitalization, the contagion effect can destabilize Nepal's entire financial system.
- **International Standards:** NRB's CAR framework aligned with **Basel III** improves Nepal's credibility with international correspondent banks and foreign investors.

**3. Current NRB CAR Requirements:**
- **Minimum CAR:** **11%** for commercial banks (Class A), exceeding the Basel III minimum of 10.5%.
- **Minimum Core Capital (Tier 1):** **8.5%** of RWA.
- **Counter-Cyclical Capital Buffer:** An additional **0% to 2.5%** may be imposed during periods of excess credit growth.
- **Minimum Paid-Up Capital:** NRB mandates Rs. 8 Billion for Class A commercial banks.

**Conclusion:** CAR is the cornerstone of prudential banking regulation. By maintaining strong capital buffers, Nepali commercial banks ensure they remain resilient during economic downturns, NRB monetary tightening cycles, and systemic shocks.''',
          ),
          ModelQuestion(
            number: 3,
            questionText: 'What are the key provisions of the Bank and Financial Institutions Act (BAFIA) 2073? Explain the four-tier classification of financial institutions in Nepal and their mandated functions.',
            marks: 10,
            marksBreakdown: '4+6=10',
            answer: '''**1. Key Provisions of BAFIA 2073:**

The **Bank and Financial Institutions Act (BAFIA) 2073** replaced the earlier BAFIA 2063 and forms the primary regulatory framework for all banking and financial institutions in Nepal. Key provisions include:

- **Licensing Regime:** Categorizes BFIs into 4 classes (A, B, C, D) with specific minimum capital requirements for each.
- **Governance Standards:** Mandates fit and proper criteria for directors, CEOs, and key management personnel; limits cross-holdings and connected lending.
- **Prudential Norms:** CAR, CRR, SLR, CD ratio, single-borrower exposure limit enforced under this Act.
- **Consumer Protection:** Prohibits unfair banking practices; mandates transparent pricing of loans and deposits.
- **Merger and Acquisition:** Governs voluntary M&A and NRB-directed consolidation of weak BFIs.
- **Corrective Action:** NRB empowered to issue Prompt Corrective Action (PCA), appoint inspectors, or cancel licenses for non-compliant BFIs.
- **Anti-Money Laundering:** BFIs must comply with AML/CFT provisions aligned with FATF recommendations.

**2. Four-Tier Classification of Financial Institutions:**

| Class | Category | Min. Capital | Core Functions |
|---|---|---|---|
| **Class A** | Commercial Banks (वाणिज्य बैंक) | Rs. 8 Billion | Full commercial banking; foreign exchange; L/C; wholesale & retail credit; underwriting |
| **Class B** | Development Banks (विकास बैंक) | Rs. 2.5 Billion | Development financing; limited forex; medium-term credit; no international LC |
| **Class C** | Finance Companies (वित्त कम्पनी) | Rs. 800 Million | Consumer lending; hire purchase; leasing; deposits; no forex or LC |
| **Class D** | Microfinance (लघुवित्त) | Rs. 100 Million | Micro-credit for low-income households; group lending; no deposits from public |

**Conclusion:** BAFIA 2073 provides a comprehensive legal framework that promotes financial stability, depositor protection, and the orderly development of Nepal's financial sector under NRB supervision.''',
          ),
          ModelQuestion(
            number: 4,
            questionText: 'Describe the process and significance of Know Your Customer (KYC) and Anti-Money Laundering (AML) compliance in Nepalese banking. What penalties does the Banking Offence and Punishment Act 2064 prescribe for AML violations?',
            marks: 10,
            marksBreakdown: '5+5=10',
            answer: '''**1. KYC Process in Nepal:**

**Know Your Customer (KYC)** is the process by which banks verify the identity, address, and nature of business of every customer before establishing a banking relationship, and on an ongoing basis.

**KYC Process Steps:**
- **Customer Identification:** Collect government-issued ID (Citizenship, Passport, Voter ID), photograph, and address proof.
- **Customer Due Diligence (CDD):** Assess the nature of customer's business, expected transaction patterns, and source of funds.
- **Enhanced Due Diligence (EDD):** Applied to Politically Exposed Persons (PEPs), high-risk customers, and non-resident customers — requires senior management approval.
- **Simplified Due Diligence (SDD):** Permitted for low-risk customers (small deposit accounts, government entities).
- **Ongoing Monitoring:** Periodic review and updating of KYC records; real-time transaction monitoring for suspicious patterns.
- **Beneficial Ownership:** Identify and verify ultimate beneficial owners (UBO) for corporate accounts (>25% ownership threshold).

**2. AML Compliance Framework:**

- **Suspicious Transaction Report (STR):** Filed to the **Financial Intelligence Unit (FIU)** of NRB for any transaction suspected of money laundering or terrorism financing.
- **Cash Transaction Report (CTR):** Mandatory reporting to FIU for all cash transactions above **Rs. 10 Lakhs** (or Rs. 5 Lakhs for high-risk customers).
- **FATF Alignment:** Nepal's AML/CFT framework aligned with 40 FATF Recommendations; Nepal exited FATF grey list in 2023.

**3. Penalties under Banking Offence and Punishment Act 2064:**

- **Money Laundering:** Imprisonment of **1 to 8 years** and fine up to **the amount of laundered funds** or Rs. 10 Million, whichever is higher.
- **Institutional Penalties:** BFI found non-compliant with AML provisions may face fines up to Rs. 10 Million per violation, suspension of operations, or license cancellation.
- **Director/CEO Liability:** Personal criminal liability including imprisonment for directors and CEOs who knowingly facilitate money laundering.
- **Asset Freezing:** Suspicious assets and funds may be frozen and forfeited to the government.

**Conclusion:** Robust KYC/AML compliance protects Nepal's banking system from financial crime, preserves correspondent banking relationships, and supports international integration of Nepal's financial sector.''',
          ),
          ModelQuestion(
            number: 5,
            questionText: 'What is meant by Non-Performing Loan (NPL) in banking? Explain the loan classification system and provisioning requirements prescribed by NRB. What challenges does high NPL pose to the banking sector?',
            marks: 10,
            marksBreakdown: '4+3+3=10',
            answer: '''**1. Non-Performing Loan (NPL):**

A **Non-Performing Loan (NPL)** is a loan where the borrower has failed to make scheduled principal or interest payments for **90 or more consecutive days** (as per NRB standard), indicating that full repayment is in doubt.

**2. NRB Loan Classification & Provisioning System:**

| Loan Class | NRB Category | Days Overdue | Provisioning Required |
|---|---|---|---|
| **Pass (सामान्य)** | Good | 0–90 days, current | 1% on performing loans |
| **Restructured/Rescheduled** | Watch List | Renegotiated terms | 5% |
| **Substandard (कमजोर)** | NPL begins | 91–180 days | 25% |
| **Doubtful (संशयास्पद)** | NPL | 181–360 days | 50% |
| **Loss (नोक्सान)** | NPL | 360+ days / fully uncollectible | 100% |

**How Provisioning Works:**
Banks must set aside a **Loan Loss Provision (LLP)** as a reserve against expected losses from defaulted loans. This reduces reported profit but protects against insolvency. NRB mandates provisioning based on the classification above.

**3. Challenges Posed by High NPL:**

- **Reduced Profitability:** High provisioning requirements directly erode bank profits and reduce dividend-paying capacity.
- **Capital Erosion:** Unrecovered NPLs consume Tier 1 capital, threatening CAR compliance and potentially requiring fresh capital injection.
- **Credit Contraction:** Banks with high NPL ratios become risk-averse, reducing new lending to productive sectors — hampering economic growth.
- **Liquidity Risk:** If NPL-affected banks face simultaneous deposit withdrawals, liquidity stress can emerge.
- **Systemic Stability Risk:** If multiple major banks carry high NPLs simultaneously, a financial contagion risk emerges for Nepal's banking system.
- **Reputational Damage:** Publicly disclosed high NPL ratios damage public confidence and may trigger bank runs.

**Current Situation:** Nepal's banking sector NPL ratio stood at approximately **3.5–4.5%** in 2081 BS, elevated post-COVID and due to real estate sector stress — a key concern for NRB and banking regulators.

**Conclusion:** Effective credit risk management, robust loan monitoring, and timely provisioning are essential tools to manage NPL risk and maintain the health of Nepal's banking system.''',
          ),
        ],
      ),
      ModelSection(
        title: "समूह 'ख'  (Group B)",
        subtitle: 'Information Technology Fundamentals — 50 Marks',
        totalMarks: 50,
        questions: [
          ModelQuestion(
            number: 6,
            questionText: 'What is a Database Management System (DBMS)? Compare RDBMS and NoSQL databases with examples. When would a bank choose NoSQL over RDBMS for its data infrastructure?',
            marks: 10,
            marksBreakdown: '3+4+3=10',
            answer: '''**1. Database Management System (DBMS):**

A **DBMS** is software that creates, manages, queries, and secures structured collections of data (databases). It provides an abstraction layer between physical data storage and application programs.

**Core DBMS Functions:**
- **Data Definition (DDL):** CREATE, ALTER, DROP tables/schemas.
- **Data Manipulation (DML):** SELECT, INSERT, UPDATE, DELETE operations.
- **Transaction Control:** COMMIT, ROLLBACK ensuring ACID properties.
- **Concurrency Control:** Manages simultaneous multi-user access via locking protocols.
- **Security:** User authentication, role-based access control, encryption.

**2. RDBMS vs. NoSQL Comparison:**

| Dimension | **RDBMS** (Relational) | **NoSQL** (Non-Relational) |
|---|---|---|
| **Data Model** | Tables with rows and columns, predefined schema | Flexible: Document, Key-Value, Column-Family, Graph |
| **Schema** | Rigid, schema-on-write | Dynamic, schema-on-read |
| **Query Language** | Standardized SQL | Varies: MongoDB Query Language, CQL, etc. |
| **ACID Compliance** | Full ACID across transactions | Often eventual consistency (BASE model) |
| **Scalability** | Vertical scaling (more powerful server) | Horizontal scaling (distributed nodes) |
| **Best For** | Structured transactional data | Unstructured, high-volume, real-time data |
| **Examples** | Oracle, PostgreSQL, MySQL, MS SQL Server | MongoDB, Cassandra, Redis, DynamoDB |

**3. When Would a Bank Choose NoSQL?**

Banks traditionally rely on **RDBMS** (Oracle, MS SQL) for core banking (deposits, loans, ledgers) due to ACID guarantees. However, NoSQL is preferred for:

- **Customer 360 Profiles (MongoDB):** Storing unstructured customer interaction data — social media activity, digital footprints, flexible attributes that don't fit rigid schemas.
- **Real-Time Fraud Detection (Redis, Cassandra):** Key-value stores can process **millions of transactions per second** with sub-millisecond latency for real-time fraud scoring.
- **Mobile Banking Session Management (Redis):** Fast in-memory cache for user session tokens and OTP validation.
- **Log Analytics (Elasticsearch):** Storing and querying billions of audit log events across distributed systems.
- **ATM Network Telemetry (InfluxDB):** Time-series NoSQL for monitoring ATM machine health, uptime, and transaction throughput.

**Conclusion:** Modern banks adopt a **polyglot persistence** strategy — RDBMS for core transactional systems requiring strict consistency, and NoSQL for high-volume, real-time, and flexible use cases.''',
          ),
          ModelQuestion(
            number: 7,
            questionText: 'Explain the OSI Reference Model. Describe the function of each of the seven layers with a practical banking example for any two layers. Which layers are most critical for network security?',
            marks: 10,
            marksBreakdown: '5+3+2=10',
            answer: '''**1. OSI Reference Model — Overview:**

The **Open Systems Interconnection (OSI) Model** is a conceptual framework developed by ISO that standardizes network communication into **seven distinct, sequential layers**. Each layer communicates with the layer above and below it through defined interfaces (Service Access Points).

**2. The Seven Layers and Their Functions:**

| Layer | Name | Key Function | PDU (Data Unit) |
|---|---|---|---|
| **7** | **Application** | User interface for network services (HTTP, FTP, SMTP, DNS, HTTPS) | Data/Message |
| **6** | **Presentation** | Data translation, compression, and **encryption/decryption** (SSL/TLS) | Data |
| **5** | **Session** | Establishes, manages, and terminates communication sessions; handles checkpointing | Data |
| **4** | **Transport** | End-to-end reliable delivery; segmentation; **TCP** (reliable) vs **UDP** (fast) | Segment/Datagram |
| **3** | **Network** | Logical addressing (**IP addressing**), routing between networks; **Routers** | Packet |
| **2** | **Data Link** | Physical addressing (**MAC addresses**); framing; error detection (CRC); **Switches** | Frame |
| **1** | **Physical** | Actual bit transmission over physical media (cables, fiber, wireless) | Bits |

**3. Banking Examples:**

*Layer 7 (Application) — Internet Banking Portal:*
When a customer accesses RBB's internet banking via `https://rbb.com.np`, the **HTTP/HTTPS protocol** at the Application layer handles the request. The browser formats the GET/POST request that the web server processes to display account balance data.

*Layer 4 (Transport) — Fund Transfer Reliability:*
When a customer initiates an RTGS fund transfer, **TCP at the Transport layer** guarantees that every data segment (account numbers, transfer amount, beneficiary details) arrives at the receiving bank's server **in the correct order, without loss**, using sequence numbers and acknowledgements. Any lost segment is automatically retransmitted.

**4. Most Critical Layers for Network Security:**

- **Layer 7 (Application):** Most attacks target the application layer — SQL injection, XSS, CSRF, API exploitation. **Web Application Firewalls (WAF)** protect here.
- **Layer 6 (Presentation):** **TLS/SSL encryption** at this layer protects banking data in transit from eavesdropping and man-in-the-middle attacks.
- **Layer 4 (Transport):** Firewalls filter traffic by port numbers; **DDoS attacks** typically exploit TCP SYN flooding at this layer.
- **Layer 3 (Network):** **IP spoofing** and routing attacks occur here; **IPSec VPNs** provide Layer 3 security.

**Conclusion:** The OSI model provides a systematic framework for diagnosing and securing network communications. For banking, **Layers 3, 4, 6, and 7** receive the most security attention due to the high volume of sensitive financial transactions transmitted.''',
          ),
          ModelQuestion(
            number: 8,
            questionText: 'Define Cryptography. Explain the difference between Symmetric and Asymmetric encryption with examples. How does Public Key Infrastructure (PKI) secure banking transactions in Nepal?',
            marks: 10,
            marksBreakdown: '2+5+3=10',
            answer: '''**1. Cryptography — Definition:**

**Cryptography** is the science of securing information by transforming readable plaintext into unreadable ciphertext using mathematical algorithms and cryptographic keys, ensuring **confidentiality, integrity, authentication, and non-repudiation** of data.

**2. Symmetric vs. Asymmetric Encryption:**

*Symmetric Encryption:*
- **Same key** used for both encryption and decryption.
- **Fast and efficient** — suitable for bulk data encryption.
- **Key Distribution Problem:** Securely sharing the key between parties is a major challenge.
- **Algorithms:** AES-128/256, DES (deprecated), 3DES, ChaCha20.
- **Banking Example:** AES-256 is used to encrypt data stored in bank databases (at-rest encryption of customer records, card numbers).

*Asymmetric Encryption (Public Key Cryptography):*
- Uses a **key pair**: a mathematically linked **Public Key** (shared freely) and **Private Key** (kept secret).
- Data encrypted with the **public key** can ONLY be decrypted with the corresponding **private key**, and vice versa.
- **Slower** than symmetric — used for key exchange and digital signatures, not bulk data.
- **Algorithms:** RSA-2048/4096, ECC (Elliptic Curve), DSA.
- **Banking Example:** When a customer connects to `https://rbb.com.np`, the bank's RSA **public key certificate** is used to encrypt the session key, which is then used for AES symmetric encryption of all subsequent transaction data.

| Feature | Symmetric | Asymmetric |
|---|---|---|
| Keys | 1 shared key | 2 keys (public + private pair) |
| Speed | Fast (bulk data) | Slow (key exchange only) |
| Key Distribution | Difficult | Easy (public key shared openly) |
| Use Case | Data-at-rest encryption, bulk transfer | SSL/TLS handshake, digital signatures |
| Example Algorithms | AES-256, ChaCha20 | RSA-4096, ECC P-256 |

**3. PKI and Banking Transactions in Nepal:**

**Public Key Infrastructure (PKI)** is the comprehensive framework of policies, procedures, hardware, software, and digital certificates that manage public keys and enables trust in digital transactions.

*PKI Components:*
- **Certificate Authority (CA):** Issues and signs digital certificates. In Nepal, **NTA (Nepal Telecommunications Authority)** operates as the Root CA under the Electronic Transaction Act 2063.
- **Digital Certificate (X.509):** Binds a public key to an entity's identity, signed by a trusted CA.
- **Certificate Revocation List (CRL) / OCSP:** Mechanism to revoke compromised certificates.

*How PKI Secures RBB Banking Transactions:*
1. RBB's web server presents its **SSL/TLS certificate** (signed by a trusted CA) to the customer's browser.
2. The browser verifies the certificate chain up to a trusted Root CA — establishing **authentication** (this is genuinely RBB's server).
3. An **asymmetric key exchange** (TLS 1.3 with ECDHE) establishes a shared symmetric session key.
4. All subsequent transaction data (account numbers, transfer amounts, OTPs) is encrypted with **AES-256** — ensuring **confidentiality** and **integrity**.
5. **Digital Signatures** on transaction confirmations ensure **non-repudiation** — RBB can prove the transaction was authorized by the customer.

**Conclusion:** PKI is the foundational security infrastructure underlying every secure banking interaction in Nepal's digital financial ecosystem, from internet banking and mobile apps to card transactions and interbank settlements.''',
          ),
          ModelQuestion(
            number: 9,
            questionText: 'What is System Development Life Cycle (SDLC)? Compare the Waterfall and Agile methodologies. Which approach is more suitable for developing a Core Banking System (CBS) and why?',
            marks: 10,
            marksBreakdown: '3+4+3=10',
            answer: '''**1. System Development Life Cycle (SDLC):**

**SDLC** is a structured process for planning, creating, testing, deploying, and maintaining information systems. It provides a framework to ensure high-quality, cost-efficient software development.

**SDLC Phases:**
1. **Requirements Analysis:** Gather and document functional and non-functional requirements.
2. **System Design:** Architecture, database schema, UI design, technology stack selection.
3. **Implementation (Coding):** Actual source code development by programmers.
4. **Testing:** Unit, integration, system, user acceptance testing (UAT).
5. **Deployment:** Release to production environment; training and documentation.
6. **Maintenance:** Bug fixes, performance optimization, enhancement.

**2. Waterfall vs. Agile Methodology:**

| Dimension | **Waterfall** | **Agile** |
|---|---|---|
| **Structure** | Sequential, linear — each phase complete before next begins | Iterative, incremental — short sprints (1–4 weeks) |
| **Flexibility** | Very rigid — changes extremely difficult post-requirements phase | Highly flexible — requirements can change each sprint |
| **Documentation** | Comprehensive upfront documentation | Minimal upfront; working software prioritized |
| **Customer Involvement** | Mainly at requirements and acceptance phases | Continuous collaboration throughout |
| **Risk** | High risk — issues discovered late in testing cycle | Low risk — continuous testing and feedback |
| **Best For** | Well-defined, stable, regulatory-driven projects | Evolving requirements, innovation, digital products |
| **Examples** | Military systems, compliance systems, CBS | Mobile banking apps, fintech APIs, dashboards |

**3. Which is Better for Core Banking System (CBS)?**

A **Core Banking System (CBS)** handles the most critical banking functions: deposits, withdrawals, loan management, GL accounting, and interbank settlements. For CBS development:

**Waterfall is MORE Suitable for CBS because:**

- **Regulatory Compliance:** CBS must comply with NRB directives, BAFIA 2073, and audit requirements — requiring exhaustive documentation that Waterfall naturally produces.
- **Stability of Core Requirements:** Basic banking functions (deposit interest calculation, double-entry accounting, SWIFT messaging) are well-defined and do not change rapidly — ideal for Waterfall's fixed requirements phase.
- **Zero-Tolerance for Failure:** Financial transactions cannot be partially done; the "failing fast" principle of Agile is inappropriate when accounting errors can lead to regulatory penalties and reputational disaster.
- **Integration Complexity:** CBS integrates with NRB's RTGS, SWIFT, card switches, and CRB systems — requiring rigorous upfront architectural design.

**However, a Hybrid Approach is Optimal:**
- **Waterfall for Core Engine:** Deposit/loan processing core, GL accounting, regulatory reporting.
- **Agile for Customer-Facing Modules:** Mobile banking UI, chatbots, dashboard analytics — where user feedback and rapid iteration add value.

**Conclusion:** The choice depends on the module's stability, regulatory requirements, and risk tolerance. For the financial core of a CBS, Waterfall's disciplined approach prevails; Agile suits peripheral, customer-experience focused development.''',
          ),
          ModelQuestion(
            number: 10,
            questionText: 'What is Cloud Computing? Explain the three service models (IaaS, PaaS, SaaS) with banking examples. What are the key risks and regulatory considerations for Nepalese banks adopting cloud infrastructure?',
            marks: 10,
            marksBreakdown: '2+4+4=10',
            answer: '''**1. Cloud Computing — Definition:**

**Cloud Computing** is the on-demand delivery of computing resources (servers, storage, databases, networking, software, analytics) over the internet from a provider's remote data centers, typically priced on a **pay-as-you-go** model. Eliminates upfront capital expenditure on physical infrastructure.

**2. Three Service Models with Banking Examples:**

*IaaS — Infrastructure as a Service:*
- **What it provides:** Virtualized computing infrastructure — virtual machines, storage volumes, networking, load balancers. The bank manages the OS, middleware, and applications.
- **Banking Example:** RBB could host its **Disaster Recovery site** on AWS EC2 instances. Instead of maintaining a physical DR data center in another city, RBB provisions virtual servers that mirror production systems, activated only during disasters.
- **Providers:** AWS EC2, Microsoft Azure VMs, Google Compute Engine.

*PaaS — Platform as a Service:*
- **What it provides:** A managed development and deployment platform. Bank develops its applications without managing underlying infrastructure, OS, or runtime.
- **Banking Example:** A bank's development team builds a **loan origination API** deployed on Azure App Service (PaaS). The platform automatically handles scaling, patching, and load balancing — team focuses purely on business logic coding.
- **Providers:** Azure App Service, Google App Engine, Heroku, AWS Elastic Beanstalk.

*SaaS — Software as a Service:*
- **What it provides:** Complete ready-to-use software applications accessible via browser. No installation or maintenance required by the bank.
- **Banking Example:** RBB uses **Microsoft 365 (formerly Office 365)** for internal email, document collaboration, and video conferencing — a SaaS solution. Also, banks use SaaS **CRM platforms** (Salesforce) for customer relationship management.
- **Providers:** Microsoft 365, Salesforce CRM, SAP Concur, Google Workspace.

**3. Key Risks and Regulatory Considerations for Nepalese Banks:**

*Security and Data Privacy Risks:*
- **Data Sovereignty:** Customer financial data stored outside Nepal may violate privacy obligations. NRB guidelines require sensitive data to remain within Nepal's jurisdiction.
- **Multi-Tenancy Risk:** Shared infrastructure with other cloud customers introduces risk of data leakage between tenants.
- **Vendor Lock-in:** Dependence on a single cloud provider creates switching costs and business continuity risk if the provider discontinues services.

*Regulatory Considerations (NRB Guidelines):*
- **NRB IT Guidelines 2079:** Require banks to conduct **Technology Risk Assessment** before cloud adoption and obtain NRB's prior approval for material IT outsourcing.
- **Outsourcing Framework:** Cloud is classified as IT outsourcing; banks must maintain a **right-to-audit** clause in cloud contracts.
- **Data Localization:** Core banking data (customer accounts, transaction history) must be stored on servers physically located within Nepal.
- **Business Continuity:** Cloud infrastructure must meet defined RTO (Recovery Time Objective) and RPO (Recovery Point Objective) standards set by NRB.
- **Third-Party Risk Management:** Banks must conduct annual due diligence on cloud providers' financial stability, security certifications (ISO 27001, SOC 2), and physical security.

**Conclusion:** Cloud computing offers Nepalese banks significant cost, scalability, and innovation benefits. However, adoption must be carefully governed within NRB's regulatory framework, prioritizing data sovereignty, security, and business continuity.''',
          ),
        ],
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════════════════
  //  PAPER II — SET A
  // ══════════════════════════════════════════════════════════════════════
  ModelPaper(
    tabLabel: 'Paper II  —  Set A',
    paperNumber: 'द्वितीय पत्र (Paper II)',
    subject: 'सूचना प्रविधि तथा व्यवस्थापन',
    subjectEng: 'Information Technology & Management',
    setNumber: 'Set A',
    fullMarks: 100,
    passMarks: 40,
    timeDuration: '३ घण्टा (3 Hours)',
    icon: Icons.computer_outlined,
    sections: [
      ModelSection(
        title: "समूह 'क'  (Group A)",
        subtitle: 'Computer Networks, OS, DBMS & Web Technology — 50 Marks',
        totalMarks: 50,
        questions: [
          ModelQuestion(
            number: 1,
            questionText: 'Explain the concept of Deadlock in operating systems. Describe the four necessary conditions for a deadlock to occur. What are the strategies for deadlock prevention, avoidance, and detection?',
            marks: 10,
            marksBreakdown: '2+4+4=10',
            answer: '''**1. Deadlock — Definition:**

A **deadlock** is a state in which two or more processes are permanently blocked, each waiting for a resource held by another process in the same waiting set — creating a circular dependency where none can proceed.

*Classic Example:* Process P1 holds Resource R1 and waits for R2; Process P2 holds R2 and waits for R1. Both wait indefinitely — this is a deadlock.

**2. Four Necessary Conditions (Coffman Conditions):**

ALL four conditions must hold simultaneously for a deadlock to occur:

1. **Mutual Exclusion:** At least one resource must be held in a non-shareable mode — only one process can use it at a time (e.g., a printer, a write-locked database row).

2. **Hold and Wait:** A process currently holding at least one resource is waiting to acquire additional resources held by other processes. It does not release held resources while waiting.

3. **No Preemption:** Resources cannot be forcibly taken from a process; a resource can only be released voluntarily by the holding process after it completes its task.

4. **Circular Wait:** A set {P0, P1, ..., Pn} of processes must exist such that P0 waits for a resource held by P1, P1 waits for one held by P2, ..., and Pn waits for one held by P0.

**3. Deadlock Strategies:**

*A. Deadlock Prevention (eliminate at least one condition):*
- **Eliminate Mutual Exclusion:** Use shareable resources (read-only files); not always possible for write operations.
- **Eliminate Hold and Wait:** Require processes to request ALL resources at once before starting (resource allocation graph protocol); reduces resource utilization.
- **Allow Preemption:** If a process requests a resource that is unavailable, forcibly take (preempt) all its currently held resources and add them to the wait list.
- **Eliminate Circular Wait:** Impose a **total ordering** on all resource types and require processes to request resources only in increasing order — guarantees no circular wait.

*B. Deadlock Avoidance (Banker's Algorithm):*
- Maintain knowledge of maximum resource needs of each process.
- Before granting a resource, simulate whether the resulting state is "safe" — i.e., there exists an execution sequence where all processes can complete.
- If the resulting state is unsafe, deny the request temporarily.
- **Safe State:** A sequence ⟨P1, P2, ..., Pn⟩ exists where each Pi's needs can be satisfied by available resources plus resources held by all Pj (j < i).

*C. Deadlock Detection and Recovery:*
- **Detection:** Periodically run a **Resource Allocation Graph (RAG)** algorithm or **Wait-For Graph** cycle detection. A cycle in the RAG implies deadlock with single-instance resources.
- **Recovery Options:**
  - **Process Termination:** Abort one or more deadlocked processes (select by priority, resources held, or progress made).
  - **Resource Preemption:** Force-preempt resources from selected processes, rollback to a safe checkpoint, and restart.

**Conclusion:** The choice of strategy depends on the operating environment. **Prevention** is simple but inefficient; **Avoidance** (Banker's) is safer but requires advance knowledge of resource needs; **Detection** allows maximum resource utilization but requires recovery mechanisms.''',
          ),
          ModelQuestion(
            number: 2,
            questionText: 'What is SQL? Write SQL queries for the following: (a) Create a table named "Accounts" with columns AccNo, CustomerName, Balance, and BranchCode. (b) Insert two records. (c) Retrieve all accounts where Balance > 100000. (d) Update the balance of a specific account. (e) Delete an account record.',
            marks: 10,
            marksBreakdown: '2+8=10',
            answer: '''**1. SQL — Structured Query Language:**

**SQL (Structured Query Language)** is the standard declarative language for defining, manipulating, querying, and controlling data in Relational Database Management Systems (RDBMS). SQL is divided into:
- **DDL (Data Definition Language):** CREATE, ALTER, DROP, TRUNCATE.
- **DML (Data Manipulation Language):** SELECT, INSERT, UPDATE, DELETE.
- **DCL (Data Control Language):** GRANT, REVOKE.
- **TCL (Transaction Control Language):** COMMIT, ROLLBACK, SAVEPOINT.

**2. SQL Queries for Banking Accounts:**

*(a) CREATE TABLE — Accounts:*
```sql
CREATE TABLE Accounts (
    AccNo       VARCHAR(20)     PRIMARY KEY,
    CustomerName VARCHAR(100)   NOT NULL,
    Balance     DECIMAL(15, 2)  DEFAULT 0.00,
    BranchCode  CHAR(6)         NOT NULL,
    CreatedAt   TIMESTAMP       DEFAULT CURRENT_TIMESTAMP
);
```

*(b) INSERT Two Records:*
```sql
INSERT INTO Accounts (AccNo, CustomerName, Balance, BranchCode)
VALUES ('ACC001', 'Ram Bahadur Thapa', 250000.00, 'RBB001');

INSERT INTO Accounts (AccNo, CustomerName, Balance, BranchCode)
VALUES ('ACC002', 'Sita Kumari Rana', 75000.50, 'RBB002');
```

*(c) SELECT — All Accounts with Balance > 100,000:*
```sql
SELECT AccNo, CustomerName, Balance, BranchCode
FROM   Accounts
WHERE  Balance > 100000
ORDER  BY Balance DESC;
```

*(d) UPDATE — Modify Specific Account Balance:*
```sql
-- Add Rs. 50,000 to Ram Bahadur's account
UPDATE Accounts
SET    Balance = Balance + 50000.00
WHERE  AccNo = 'ACC001';
```

*(e) DELETE — Remove an Account Record:*
```sql
-- Always use a WHERE clause to avoid deleting all records!
DELETE FROM Accounts
WHERE  AccNo = 'ACC002';
```

**Best Practice Note for Banking Systems:**
In production banking databases, records should typically be **soft-deleted** (marking a `IsDeleted = TRUE` flag) rather than hard-deleted, to preserve audit trails for regulatory compliance. A physical DELETE should only occur after the statutory retention period has expired.''',
          ),
          ModelQuestion(
            number: 3,
            questionText: 'Explain the concept of Network Topology. Compare Bus, Star, Ring, and Mesh topologies. Which topology is best suited for a bank branch network and why?',
            marks: 10,
            marksBreakdown: '2+5+3=10',
            answer: '''**1. Network Topology — Definition:**

**Network topology** defines the physical or logical arrangement of nodes (computers, devices) and communication links (cables, wireless connections) in a network. It determines how data flows between devices, the network's fault tolerance, scalability, and cost.

**2. Comparison of Key Topologies:**

| Feature | Bus | Star | Ring | Mesh |
|---|---|---|---|---|
| **Structure** | All devices share a single backbone cable | All devices connect to a central hub/switch | Devices connected in a closed ring | Every device connected to every other device |
| **Central Device** | None | Hub / Switch | None (or logical controller) | None |
| **Fault Tolerance** | Low — backbone failure = entire network down | Medium — hub/switch failure = network down | Low — single node failure can disrupt ring | High — multiple paths; single failure doesn't disrupt |
| **Scalability** | Low — adding devices degrades performance | High — easy to add/remove devices from switch | Low — inserting a device disrupts the ring | Low — exponential cabling cost with each addition |
| **Performance** | Degrades with traffic (collisions) | Excellent — dedicated segments via switch | Predictable (token passing) | Excellent — dedicated paths per connection |
| **Cost** | Low (minimal cabling) | Moderate (switch cost, per-device cable) | Moderate | Very High (N×(N-1)/2 connections) |
| **Installation** | Simple | Moderate | Moderate | Complex |
| **Use Case** | Old LANs (legacy), small setups | Modern LANs, office networks | Industrial networks, legacy IBM token ring | Critical infrastructure, data centers, WAN backbone |

**3. Best Topology for a Bank Branch Network:**

**Star Topology using Managed Ethernet Switches** is the optimal choice for RBB branch networks, with the following justification:

- **Centralized Management:** A managed switch provides the IT team with centralized monitoring, VLAN segmentation, QoS configuration, and port-level security — critical for banking compliance.
- **Fault Isolation:** A failure in one workstation's cable or NIC only affects that single device; other teller stations, ATM connections, and servers remain unaffected — ensuring **business continuity** during working hours.
- **Security:** Each port on a managed switch can be secured with **Port Security** (MAC address binding), **802.1X authentication**, and separate VLANs for teller systems, management networks, and ATMs — preventing unauthorized device connections.
- **Scalability:** Adding a new teller terminal only requires plugging into an available switch port — no network interruption.
- **Performance:** Modern Gigabit switches provide **dedicated bandwidth** per device with no collision domain issues.
- **Redundancy:** A Star topology can be enhanced with **dual uplinks** from the branch switch to the central bank's MPLS WAN cloud — providing redundant paths.

**For the WAN connection (branch to Head Office):** A **Partial Mesh** or **MPLS (Multiprotocol Label Switching) VPN** topology is used between branches and HO for guaranteed bandwidth, prioritization of Core Banking System (CBS) traffic, and redundancy.

**Conclusion:** Star topology provides the ideal combination of manageability, fault isolation, security, and scalability for a bank's branch LAN, while MPLS Mesh provides the WAN backbone between branches and Head Office.''',
          ),
          ModelQuestion(
            number: 4,
            questionText: 'What is normalization in DBMS? Explain the First (1NF), Second (2NF), and Third (3NF) Normal Forms with examples relevant to a banking customer database. What problems does normalization solve?',
            marks: 10,
            marksBreakdown: '2+6+2=10',
            answer: '''**1. Normalization — Definition:**

**Normalization** is the systematic process of organizing a relational database schema to minimize **data redundancy** (duplication) and eliminate **data anomalies** (insertion, update, and deletion problems) by decomposing tables into smaller, well-structured relations while preserving data integrity.

**Problems Solved by Normalization:**
- **Insertion Anomaly:** Cannot add a new loan record without creating a customer record first (if stored in the same table).
- **Update Anomaly:** A customer's address stored in 50 loan records — changing it requires updating all 50 rows; inconsistency if some are missed.
- **Deletion Anomaly:** Deleting a customer's only loan record accidentally deletes all customer information.

**2. Normal Forms with Banking Examples:**

*First Normal Form (1NF):*
**Rule:** Every column must contain **atomic** (indivisible) values; no repeating groups; a primary key must exist.

*Violation Example — Un-normalized Customer Table:*
| CustID | Name | Phone Numbers | Accounts |
|---|---|---|---|
| C001 | Ram Thapa | 9841001, 9851002 | ACC001, ACC002 |

*After 1NF:*
| CustID | Name | Phone | AccNo |
|---|---|---|---|
| C001 | Ram Thapa | 9841001 | ACC001 |
| C001 | Ram Thapa | 9851002 | ACC002 |

Each cell now has one atomic value; primary key = (CustID, Phone, AccNo).

*Second Normal Form (2NF):*
**Rule:** Must be in 1NF AND every non-prime attribute must be **fully functionally dependent** on the ENTIRE composite primary key (no partial dependencies).

*Violation in 1NF table:* `Name` depends only on `CustID`, not on the full key (CustID, Phone, AccNo) — partial dependency!

*After 2NF (decompose into separate tables):*
- **Customer Table:** `CustID (PK)`, `Name`
- **CustomerPhone:** `CustID (FK)`, `Phone`
- **Account Table:** `AccNo (PK)`, `CustID (FK)`, `Balance`

*Third Normal Form (3NF):*
**Rule:** Must be in 2NF AND no **transitive dependencies** — non-key attributes must not depend on other non-key attributes.

*Violation Example:* In a Loan table:
`LoanID → BranchCode → BranchCity` — BranchCity transitively depends on LoanID through BranchCode.

*After 3NF:*
- **Loan Table:** `LoanID (PK)`, `LoanAmount`, `BranchCode (FK)`
- **Branch Table:** `BranchCode (PK)`, `BranchName`, `BranchCity`

**3. Summary of Benefits:**

- Eliminates redundant storage of customer/branch/product data.
- Ensures data consistency — one place to update customer address.
- Supports referential integrity through foreign keys.
- Simplifies database maintenance and audit compliance.

**Note:** For banking data warehouses and reporting, controlled **denormalization** (reverting to redundant structures) is intentionally applied to optimize complex query performance.''',
          ),
          ModelQuestion(
            number: 5,
            questionText: 'Explain the concept of Responsive Web Design (RWD). What is the difference between HTML and HTML5? List five new features introduced in HTML5 that are particularly useful for building modern banking applications.',
            marks: 10,
            marksBreakdown: '4+2+4=10',
            answer: '''**1. Responsive Web Design (RWD):**

**Responsive Web Design** is an approach to web design and development that creates interfaces that **automatically adapt their layout, content, and styling** to provide an optimal viewing and interaction experience across all device sizes — from large desktop monitors to tablets and smartphones.

**Core Principles of RWD:**

- **Fluid Grid Layout:** Use percentage-based widths (not fixed pixel widths) so content containers proportionally resize with the viewport.
- **Flexible Images:** `max-width: 100%` CSS ensures images scale down within their containing element and never overflow.
- **Media Queries (CSS3):** Apply different CSS rules based on device characteristics:
  ```css
  @media (max-width: 768px) {
    .sidebar { display: none; }
    .main-content { width: 100%; }
  }
  ```
- **Viewport Meta Tag:** `<meta name="viewport" content="width=device-width, initial-scale=1.0">` — tells mobile browsers to render at actual device width.
- **Flexbox and CSS Grid:** Modern CSS layout systems that natively support responsive column arrangements.

**Why RWD Matters for Banking:**
- Over **60% of internet banking access** in Nepal occurs on mobile devices.
- A single codebase serves all devices — reduces development and maintenance cost.
- Google's mobile-first indexing rewards responsive designs with better search rankings.

**2. HTML vs. HTML5 — Key Differences:**

| Aspect | HTML (4.01) | HTML5 |
|---|---|---|
| Released | 1997 | 2014 (W3C Standard) |
| Multimedia | Required Flash/Silverlight plugins | Native audio/video support |
| Storage | Cookies only | LocalStorage, SessionStorage, IndexedDB |
| Offline | No offline support | App Cache / Service Workers |
| Semantics | Generic `<div>` and `<span>` | Semantic tags: `<header>`, `<nav>`, `<article>`, `<section>` |
| Form Validation | Manual JavaScript | Built-in HTML5 form validation attributes |

**3. Five HTML5 Features Useful for Banking Applications:**

1. **`<form>` Input Types and Validation:** New input types `type="number"`, `type="date"`, `type="email"`, `type="tel"` with built-in validation (`required`, `min`, `max`, `pattern`) — reduces JavaScript for loan application form validation.

2. **Web Storage (localStorage / sessionStorage):** Store user session tokens, draft form data, and UI preferences client-side without cookies — faster and more secure. `sessionStorage` clears on tab close, appropriate for banking session data.

3. **Canvas API (`<canvas>`):** Renders 2D graphics dynamically — used for interactive account balance charts, loan repayment schedule visualizations, and analytics dashboards in internet banking portals.

4. **Geolocation API:** `navigator.geolocation.getCurrentPosition()` — enables bank's mobile web app to detect nearest ATM/branch location and show on a map.

5. **WebSockets (`<websocket>`):** Enables full-duplex, real-time bi-directional communication between client and server — essential for live transaction notifications, stock/forex rate feeds, and instant balance updates in banking dashboards without repeated polling.

**Conclusion:** HTML5's native multimedia, storage, and real-time communication capabilities have transformed banking web applications from static information pages to rich, interactive financial management platforms.''',
          ),
        ],
      ),
      ModelSection(
        title: "समूह 'ख'  (Group B)",
        subtitle: 'Cybersecurity, IT Policies & NRB Guidelines — 50 Marks',
        totalMarks: 50,
        questions: [
          ModelQuestion(
            number: 6,
            questionText: 'What is Cybersecurity? Explain the CIA Triad. Describe five major cybersecurity threats faced by Nepalese banks and the countermeasures for each threat.',
            marks: 10,
            marksBreakdown: '3+7=10',
            answer: '''**1. Cybersecurity — Definition:**

**Cybersecurity** is the practice of protecting computer systems, networks, programs, and data from digital attacks, unauthorized access, damage, and theft. It encompasses technologies, processes, and human practices that ensure the security of digital assets.

**2. The CIA Triad:**

The **CIA Triad** is the foundational model of information security, representing three core objectives:

- **Confidentiality (गोपनीयता):** Ensuring information is accessible only to authorized individuals. Methods: encryption (AES-256, TLS), access controls, data masking. *Banking Example:* Customer account details and PIN numbers must be accessible only by the account holder and authorized bank staff.

- **Integrity (अखण्डता):** Ensuring data is accurate, complete, and unaltered by unauthorized parties. Methods: digital signatures, checksums, hash functions (SHA-256), version control. *Banking Example:* A fund transfer record must not be altered after authorization — integrity hashing detects tampering.

- **Availability (उपलब्धता):** Ensuring systems and data are accessible when needed by authorized users. Methods: redundant infrastructure, load balancing, DDoS protection, backup systems. *Banking Example:* Internet banking and ATM networks must maintain 99.9%+ uptime — unavailability directly causes financial and reputational loss.

**3. Five Major Cybersecurity Threats to Nepalese Banks:**

| Threat | Description | Countermeasures |
|---|---|---|
| **1. Phishing / Spear Phishing** | Fraudulent emails/SMS impersonating NRB, RBB, or government agencies to trick employees into revealing credentials or approving fraudulent transfers (e.g., CEO fraud / BEC attacks) | Employee security awareness training; Email filtering (DMARC/DKIM/SPF); Multi-factor authentication; Transaction approval processes requiring dual authorization |
| **2. Ransomware** | Malicious software that encrypts bank's CBS or critical data, demanding cryptocurrency ransom for decryption key (e.g., WannaCry, LockBit). Disrupts banking operations entirely | Offline immutable backups (3-2-1 backup rule); Network segmentation; Endpoint Detection & Response (EDR); Regular patch management; NRB-mandated BCP/DR testing |
| **3. ATM/Card Skimming** | Physical devices secretly attached to ATM card readers that capture magnetic stripe data and PIN — used to clone cards for unauthorized withdrawals | EMV chip card migration; Anti-skimming devices on ATMs; ATM tamper detection sensors; Regular ATM physical inspection; Real-time card transaction monitoring with geo-velocity alerts |
| **4. DDoS (Distributed Denial of Service)** | Flooding internet banking servers with millions of simultaneous requests from botnets — overwhelming servers and making banking services unavailable to customers | Content Delivery Network (CDN) with DDoS scrubbing; Rate limiting; Anycast routing; Cloud-based DDoS protection (Cloudflare, AWS Shield); ISP-level traffic filtering |
| **5. Insider Threats** | Malicious or negligent bank employees deliberately leaking customer data, manipulating transactions, or enabling external attacks — often the most damaging because insiders have legitimate system access | Role-based access control (RBAC) — least privilege principle; Privileged Access Management (PAM) for admin accounts; User Behavior Analytics (UBA); Segregation of duties in financial approvals; Regular access review; Comprehensive audit logging |

**Conclusion:** Nepalese banks face an increasingly sophisticated cyberthreat landscape. A layered defense-in-depth strategy, combining technical controls, organizational processes, and human security awareness, is essential to protect critical banking infrastructure and customer trust.''',
          ),
          ModelQuestion(
            number: 7,
            questionText: 'What is the Electronic Transaction Act (ETA) 2063 of Nepal? Explain its key provisions related to digital signatures, electronic contracts, and cyber offenses. What penalties does it prescribe for computer-related crimes?',
            marks: 10,
            marksBreakdown: '3+4+3=10',
            answer: '''**1. Electronic Transaction Act (ETA) 2063 — Overview:**

The **Electronic Transaction Act (ETA) 2063** (enacted in 2006) is Nepal's primary legislation governing **e-commerce, digital signatures, electronic contracts**, and **cyber crimes**. It provides the legal framework that makes electronic transactions legally valid and enforceable in Nepal — foundational for internet banking, digital payments, and e-governance.

**Primary Objectives:**
- Grant legal recognition to electronic documents and digital signatures.
- Establish a regulatory framework for Certifying Authorities (CAs) to issue digital certificates.
- Define cybercrime offenses and prescribe penalties.
- Facilitate and promote e-commerce and e-governance in Nepal.

**Regulatory Body:** **Nepal Telecommunications Authority (NTA)** acts as the Controller of Certifying Authorities under ETA 2063.

**2. Key Provisions:**

*A. Digital Signatures (Section 7–15):*
- A **digital signature** affixed to an electronic record has the same legal effect as a handwritten signature on a paper document.
- **Certifying Authorities (CA):** Licensed by the NTA/Controller; may issue **Digital Signature Certificates** (X.509 standard) to individuals and organizations.
- **Certificate Validity:** A digital signature is only valid if the certificate was issued by a licensed CA, was not expired, and was not revoked at time of signing.
- **Asymmetric Cryptography:** ETA mandates use of public-key infrastructure (PKI) for digital signatures — the signer uses their private key; verification uses the corresponding public key in the certificate.
- **Banking Application:** RBB's internet banking transactions can be digitally signed, creating a legally non-repudiable authorization trail.

*B. Electronic Contracts (Section 3–6):*
- Electronic contracts formed through **offer and acceptance** in electronic form are legally valid and enforceable.
- An electronic record satisfies any legal requirement for **"writing"** (Section 4).
- A digital signature satisfies any requirement for a **"signature"** (Section 7).
- **Timing:** An electronic offer is deemed accepted when the acceptance message enters the offeror's information system and becomes retrievable.
- **Banking Application:** Online loan applications, account opening via internet banking, and e-banking terms and conditions accepted digitally are legally binding contracts under ETA 2063.

*C. Cyber Offenses (Section 44–52):*
ETA 2063 defines and criminalizes specific computer-related offenses:

| Offense | Description |
|---|---|
| Unauthorized Access | Accessing another's computer system without permission |
| Data Theft | Copying, deleting, or destroying electronic data without authorization |
| Computer Fraud | Using a computer to commit financial fraud |
| Electronic Vandalism | Damaging or destroying data or programs |
| Virus/Malware Distribution | Introducing destructive programs into computer systems |
| Publishing Obscene Materials | Online distribution of obscene content |

**3. Penalties under ETA 2063:**

- **Unauthorized Access:** Imprisonment up to **5 years** and/or fine up to **Rs. 50,000**.
- **Data Theft/Damage:** Imprisonment up to **5 years** and/or fine up to **Rs. 50,000**.
- **Computer Fraud (financial):** Imprisonment up to **5 years** and/or fine up to **Rs. 200,000**, and compensation equivalent to the defrauded amount.
- **Corporate Liability:** If the offense is committed by an organization, the responsible officer (CEO/Director) bears personal criminal liability.
- **Aggravated Offenses:** If committed with intent to harm state security or undermine the banking system, penalties are enhanced.

**Limitations of ETA 2063:**
The Act is over 18 years old and does not comprehensively cover emerging cyber threats like ransomware, cryptocurrency fraud, advanced persistent threats (APTs), and social engineering. Nepal is developing a **Cybercrime Act** to address these gaps.

**Conclusion:** ETA 2063 is the cornerstone of Nepal's digital economy legal framework, enabling legally valid banking transactions, contracts, and digital signatures while prescribing deterrent penalties for cybercrime.''',
          ),
          ModelQuestion(
            number: 8,
            questionText: 'Explain Nepal\'s ICT Policy 2072 (2015). What are its major objectives and strategic pillars? How does this policy support digital financial inclusion and the development of Nepal\'s banking IT infrastructure?',
            marks: 10,
            marksBreakdown: '3+4+3=10',
            answer: '''**1. Nepal ICT Policy 2072 (2015) — Overview:**

Nepal's **ICT Policy 2072** (approved by the Government of Nepal in 2015) is the comprehensive national policy framework guiding the development, promotion, and regulation of Information and Communications Technology across all sectors of the Nepali economy and governance.

**Vision:** *"Prosperous Nepal through Knowledge Economy"* — transform Nepal into a knowledge-based economy by leveraging ICT for economic growth, governance improvement, and social development.

**2. Major Objectives and Strategic Pillars:**

*Five Core Objectives:*
1. **National Connectivity:** Ensure high-speed broadband internet connectivity to all 75 districts and municipalities through fiber optic infrastructure and expanded mobile networks.
2. **Digital Governance (e-Government):** Transform government service delivery to citizens through online portals, reducing corruption and improving efficiency.
3. **ICT Industry Development:** Create an export-oriented ICT/BPO/ITeS industry, generating employment and foreign currency earnings.
4. **Digital Literacy:** Achieve 100% digital literacy among the working-age population; ICT education integrated into school curriculum from Grade 1.
5. **Legal and Regulatory Modernization:** Update Nepal's legal framework (Cybercrime Act, Data Protection Act, Privacy Law) to align with international best practices.

*Strategic Pillars:*
- **Infrastructure:** Nationwide backbone fiber network; submarine cable connectivity (Nepal Telecom); affordable bandwidth.
- **Human Capital:** ICT curriculum reform; training IT professionals aligned with industry demand.
- **e-Services:** NID (National Identity System), digital land records, e-health, e-agriculture, e-judiciary.
- **Cybersecurity:** National CERT (Computer Emergency Response Team) establishment; national cybersecurity strategy.
- **Digital Financial Services:** Promote mobile banking, payment gateways, and interoperable digital payment infrastructure.

**3. How ICT Policy 2072 Supports Digital Financial Inclusion and Banking IT:**

*Digital Financial Inclusion:*
- **Mobile Banking Expansion:** Policy mandates Mobile Network Operators to extend 4G/LTE coverage to rural areas — enabling farmers and low-income households to access banking services via mobile phones without physical branch visits.
- **Interoperable Payment System:** ICT Policy 2072 supported the development of **NepalClear** and **ConnectIPS** — NRB-operated interoperable payment platforms enabling fund transfers across all Nepali banks from a single interface.
- **Branchless Banking:** Policy provides the regulatory framework for agent banking and mobile wallet services (eSewa, Khalti) — financial access without requiring a formal bank branch.
- **Digital Identity:** NID integration with bank KYC processes enables instant digital account opening and e-KYC verification.

*Banking IT Infrastructure Development:*
- **National Broadband Policy:** Reliable, affordable connectivity allows banks to operate real-time online Core Banking Systems (CBS) across all branches and ATMs.
- **Data Center Incentives:** Policy provides tax incentives for establishing national-standard data centers in Nepal — enabling banks to host CBS data within Nepal (data sovereignty compliance).
- **IT Talent Pipeline:** ICT curriculum reforms produce more qualified IT professionals available for banking sector recruitment.
- **Cybersecurity Framework:** The national cybersecurity framework under ICT Policy 2072 complements NRB's own IT Guidelines to create a comprehensive protection architecture for Nepal's financial sector.

**Key Achievements Linked to ICT Policy 2072:**
- ConnectIPS and NepalClear operational for interbank transfers.
- Expansion of mobile banking subscribers to over 15 million.
- Rollout of NID cards (National Identity Cards) as digital identity anchors.
- Establishment of Nepal's national CERT under NTA.

**Conclusion:** Nepal's ICT Policy 2072 provides the enabling environment — infrastructure, legal framework, and human capital — that makes digital financial inclusion and sophisticated banking IT infrastructure possible, driving Nepal's transition to a digital economy.''',
          ),
          ModelQuestion(
            number: 9,
            questionText: 'Explain NRB\'s IT Guidelines for Banks and Financial Institutions. What are the key requirements in the areas of: (a) IT Governance, (b) Information Security, and (c) Business Continuity? How do these guidelines align with global standards?',
            marks: 10,
            marksBreakdown: '2+5+3=10',
            answer: '''**1. NRB IT Guidelines — Overview:**

The **Nepal Rastra Bank (NRB) IT Guidelines for Banks and Financial Institutions** (most recently updated as IT Guidelines 2079) establish mandatory minimum standards for IT governance, information security, operational resilience, and technology risk management across all BFIs licensed under BAFIA 2073.

**Scope:** Applicable to all Class A, B, C, and D BFIs operating in Nepal.

**2. Key Requirements:**

*(a) IT Governance Requirements:*
- **IT Strategy:** BFIs must maintain a board-approved **IT Strategy** aligned with the bank's overall business strategy, reviewed at minimum every 3 years.
- **IT Steering Committee:** Mandatory board-level IT Steering Committee responsible for overseeing major IT initiatives, risk appetite, and technology investments.
- **CIO Appointment:** BFIs above a specified asset threshold must appoint a qualified **Chief Information Officer (CIO)** or IT Director reporting to senior management.
- **IT Risk Management:** Dedicated IT risk management function integrated with the bank's overall Enterprise Risk Management (ERM) framework.
- **IT Audit:** Mandatory **annual IT audit** by qualified IT auditors (internal or external) covering all major systems, controls, and compliance.
- **Technology Budget:** BFIs must allocate an appropriate budget for IT operations, security, and development — reviewed by the board annually.

*(b) Information Security Requirements:*
- **Information Security Policy (ISP):** Board-approved, reviewed annually, covering classification, access control, encryption, incident response, and third-party security.
- **Access Control:** Mandatory **role-based access control (RBAC)** — least privilege principle; separation of duties for financial transaction approvals; privileged account management.
- **Encryption:** All sensitive customer data at rest and in transit must be encrypted using industry-standard algorithms (AES-256 for storage; TLS 1.2+ for transmission).
- **Patch Management:** Critical security patches must be applied within **30 days** of release for internet-facing systems.
- **Penetration Testing:** Mandatory **annual external penetration testing** of internet banking, CBS interfaces, and network perimeter; results reported to board and NRB on request.
- **Vulnerability Assessment:** Quarterly internal vulnerability assessments of all critical systems.
- **Anti-Malware:** Real-time anti-malware protection on all endpoints; centrally managed and updated.
- **Security Incident Response:** A documented **Cyber Incident Response Plan (CIRP)**; mandatory NRB notification within **2 hours** for major cybersecurity incidents; detailed incident report within 72 hours.
- **Multi-Factor Authentication (MFA):** Mandatory for internet banking, core banking administrative access, and privileged user accounts.

*(c) Business Continuity Requirements:*
- **Business Continuity Plan (BCP):** Documented, board-approved BCP covering all critical banking processes.
- **Disaster Recovery Plan (DRP):** Separate technical DRP for all critical IT systems.
- **RTO and RPO Standards:**
  - **Core Banking System:** RTO ≤ 4 hours; RPO ≤ 1 hour.
  - **Payment Systems (RTGS, Interbank):** RTO ≤ 2 hours; RPO ≤ 15 minutes.
  - **Internet/Mobile Banking:** RTO ≤ 4 hours; RPO ≤ 2 hours.
- **Backup Data Center (DR Site):** Mandatory geographically separate DR site (minimum 50km from primary) with real-time or near-real-time data replication.
- **BCP/DRP Testing:** Full live failover test at DR site **at least annually**; results documented and reported to board.
- **IT Outsourcing:** Prior NRB approval required for material IT outsourcing; right-to-audit clause mandatory in all outsourcing contracts.

**3. Alignment with Global Standards:**

- **ISO 27001 (Information Security Management System):** NRB IT Guidelines requirements for ISP, risk assessment, access control, and incident management align with ISO 27001 framework — large banks in Nepal are encouraged to obtain ISO 27001 certification.
- **COBIT (Control Objectives for IT):** IT governance requirements (IT Steering Committee, IT audit, IT strategy) mirror COBIT 2019 governance framework.
- **Basel Committee on Banking Supervision (BCBS):** NRB's operational resilience standards (BCP, DR, cyber risk governance) align with BCBS's "Principles for Operational Resilience" (2021) guidelines.
- **NIST Cybersecurity Framework:** Information security requirements (Identify, Protect, Detect, Respond, Recover) follow the NIST CSF structure.
- **PCI DSS:** Card payment security requirements aligned with PCI DSS standards for protecting cardholder data.

**Conclusion:** NRB IT Guidelines provide a comprehensive, internationally-aligned regulatory framework that ensures Nepal's BFIs maintain minimum standards of IT governance, cybersecurity, and operational resilience — protecting customer deposits and the stability of Nepal's financial system.''',
          ),
          ModelQuestion(
            number: 10,
            questionText: 'What is a Firewall? Explain the differences between Packet Filtering, Stateful Inspection, and Application-Layer (Proxy) Firewalls. Design a network security architecture for a bank using DMZ and multiple firewall layers.',
            marks: 10,
            marksBreakdown: '2+4+4=10',
            answer: '''**1. Firewall — Definition:**

A **firewall** is a network security device (hardware, software, or both) that monitors and controls incoming and outgoing network traffic based on predefined **security rules**, establishing a barrier between trusted internal networks and untrusted external networks (e.g., the internet).

**2. Types of Firewalls:**

*(a) Packet Filtering Firewall (Layer 3/4):*
- Inspects each network packet individually in isolation — examines header information only (Source IP, Destination IP, Source Port, Destination Port, Protocol).
- Allows or denies packets based on static **Access Control Lists (ACLs)**.
- **Advantages:** Very fast; low resource consumption; transparent to applications.
- **Limitations:** Cannot detect sophisticated attacks that span multiple packets; no context (doesn't track TCP connection state); vulnerable to IP spoofing.
- **Banking Use:** Perimeter routers as first-line defense to block known malicious IP ranges.

*(b) Stateful Inspection Firewall (Layer 4):*
- Maintains a **state table** of all active network connections.
- Tracks the state of each TCP connection (SYN, SYN-ACK, established, FIN) — only allows packets that are part of an established, legitimate connection.
- Can detect TCP SYN flood attacks, port scanning, and session hijacking attempts.
- **Advantages:** Much more secure than packet filtering; still relatively fast.
- **Limitations:** Cannot inspect application-layer content (HTTP payload, SQL commands in API calls).
- **Banking Use:** Main enterprise firewall protecting the internal banking network.

*(c) Application-Layer Proxy Firewall (Layer 7 / WAF):*
- Operates at the application layer — fully understands and inspects the content of application protocols (HTTP, HTTPS, FTP, SMTP, DNS).
- Acts as an intermediary (proxy): client connects to the firewall, firewall creates a new connection to the server — no direct connection between internet user and bank server.
- **Web Application Firewall (WAF):** Specialized application firewall that inspects HTTP/HTTPS to block OWASP Top 10 attacks: SQL injection, Cross-Site Scripting (XSS), CSRF, API abuse.
- **Advantages:** Deepest inspection; detects sophisticated application-layer attacks.
- **Limitations:** Higher latency; computationally intensive; complex configuration.
- **Banking Use:** In front of internet banking web servers, APIs, and mobile banking backends.

**3. Bank Network Security Architecture with DMZ:**

```
INTERNET
    |
    | [DDoS Scrubbing / CDN Layer]
    |
[EXTERNAL FIREWALL / WAF]
(Block: known malicious IPs, DDoS, OWASP attacks)
    |
    |─────── DMZ (De-Militarized Zone) ───────|
    |    - Internet Banking Web Servers          |
    |    - API Gateway / Load Balancer           |
    |    - Reverse Proxy (NGINX)                |
    |    - Mail Gateway / AntiSpam              |
    |    - DNS Server (External-facing)         |
    |─────────────────────────────────────────|
    |
[INTERNAL FIREWALL]
(Block: direct internet → core banking; strict rules)
    |
    |─────── INTERNAL SECURE NETWORK ─────────|
    |    - Core Banking System (CBS) Servers    |
    |    - Database Servers (Oracle, SQL)       |
    |    - SWIFT / RTGS Gateway                |
    |    - Branch MPLS VPN Termination         |
    |    - Internal Active Directory / LDAP     |
    |    - SIEM (Security Information & Event   |
    |      Management) — centralized log        |
    |─────────────────────────────────────────|
    |
[MANAGEMENT NETWORK — Separate VLAN]
    - Privileged Admin Access (PAM) servers
    - IT Security Operations Center (SOC)
    - Backup and DR replication servers
    - Out-of-band management console access
```

**Key Security Design Principles:**

- **DMZ (De-Militarized Zone):** Internet-facing servers (web, API) are placed in a separate DMZ network — they can communicate with internet clients AND make limited requests to backend CBS through the internal firewall. They can NEVER directly access the core database. Even if a DMZ server is compromised, the attacker cannot directly reach CBS.
- **Dual Firewall Architecture:** External firewall (WAF) filters internet traffic before DMZ; internal firewall provides second layer protecting core banking from DMZ.
- **Network Segmentation (VLANs):** CBS, Payment, Management, Branch, and DMZ networks are on separate VLANs with strict inter-VLAN routing rules.
- **IDS/IPS:** Intrusion Detection/Prevention System monitors all internal network segments for anomalous behavior.

**Conclusion:** A properly designed multi-layer firewall architecture with DMZ is the cornerstone of banking network security — ensuring that even if outer defense layers are breached, the core banking system remains protected by multiple independent security boundaries.''',
          ),
        ],
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════════════════
  //  PAPER I — SET B
  // ══════════════════════════════════════════════════════════════════════
  ModelPaper(
    tabLabel: 'Paper I  —  Set B',
    paperNumber: 'प्रथम पत्र (Paper I)',
    subject: 'बैंकिङ, लेखा तथा व्यवस्थापन',
    subjectEng: 'Banking, Accounting & Management',
    setNumber: 'Set B',
    fullMarks: 100,
    passMarks: 40,
    timeDuration: '३ घण्टा (3 Hours)',
    icon: Icons.account_balance,
    sections: [
      ModelSection(
        title: "समूह 'क'  (Group A)",
        subtitle: 'Banking & Organizational Management — 50 Marks',
        totalMarks: 50,
        questions: [
          ModelQuestion(
            number: 1,
            questionText: 'What is the Credit-to-Deposit (CD) Ratio? Why does NRB regulate it and what is the current limit? Discuss the implications of an excessively high or low CD ratio for a commercial bank.',
            marks: 10,
            marksBreakdown: '3+4+3=10',
            answer: '''**1. Credit-to-Deposit (CD) Ratio — Definition:**

The **Credit-to-Deposit (CD) Ratio** is the ratio of a bank's **total loans and advances (credit)** to its **total customer deposits**, expressed as a percentage:

**CD Ratio = Total Loans & Advances / Total Deposits × 100%**

It measures how much of the money deposited by customers is being lent out as loans — a key indicator of a bank's lending aggressiveness relative to its funding base.

**2. NRB Regulation and Current Limit:**

**Why NRB Regulates CD Ratio:**
- **Liquidity Management:** Ensures banks retain sufficient liquidity to meet day-to-day withdrawal demands from depositors.
- **Systemic Risk Prevention:** Excessively high CD ratios across the banking system create systemic liquidity risk — if depositors demand money simultaneously, overlent banks cannot repay.
- **Credit Growth Management:** During economic booms, banks may over-lend relative to deposits, contributing to asset bubbles (real estate, shares) and inflationary pressure.
- **Macroprudential Supervision:** CD ratio regulation is a macroprudential tool alongside CRR and SLR.

**Current NRB CD Ratio Limit:**
- **Maximum CD Ratio: 90%** for commercial banks (Class A BFIs).
- This means banks can lend a maximum of Rs. 90 for every Rs. 100 in deposits.
- Calculation includes BFI-issued debentures as part of the deposit base.

**3. Implications of Excessively High vs. Low CD Ratio:**

*High CD Ratio (above 90%):*
- **Liquidity Stress:** Limited cash cushion for sudden deposit withdrawals — heightens vulnerability to bank runs.
- **Interest Rate Pressure:** Banks compete aggressively for deposits to meet CD ratio — pushes up deposit interest rates, increasing cost of funds and reducing lending margins (NIM compression).
- **Regulatory Penalty:** NRB imposes fines and restrictions on credit expansion for banks breaching the 90% limit.
- **Credit Quality Risk:** Pressure to deploy more credit may lead to lower credit standards, higher NPL risk.

*Low CD Ratio (e.g., below 60–65%):*
- **Under-Deployment of Resources:** Idle deposits earn nothing — reduces bank profitability and return on assets.
- **Missed Growth Opportunity:** Bank is not supporting economic growth sufficiently through credit intermediation.
- **Excess Liquidity Problem:** Creates pressure to invest in government securities at lower returns.
- **Shareholder Discontent:** Low lending activity leads to lower interest income and reduced dividends.

**Optimal Range:** NRB guidance suggests an **80–88% CD ratio** represents a healthy balance — sufficient credit deployment for profitability while maintaining adequate liquidity buffers.

**Conclusion:** The CD ratio is a critical regulatory tool that balances profitability with safety. RBB and other Nepali banks carefully monitor and manage their CD ratio daily to ensure regulatory compliance while optimizing credit growth.''',
          ),
          ModelQuestion(
            number: 2,
            questionText: 'Explain the Treasury function in a commercial bank. What is Asset-Liability Management (ALM)? Describe the key risks managed by the ALM Committee (ALCO) and the tools used to manage interest rate risk.',
            marks: 10,
            marksBreakdown: '3+4+3=10',
            answer: '''**1. Treasury Function in a Commercial Bank:**

The **Treasury Department** is the central financial management unit of a bank responsible for:

- **Liquidity Management:** Ensuring the bank always has sufficient liquid assets (cash, government securities) to meet day-to-day operational needs and unexpected large outflows.
- **Investment Management:** Managing the bank's investment portfolio — government treasury bills, bonds, NRB instruments — to generate returns on surplus funds while maintaining liquidity.
- **Funding Operations:** Managing wholesale funding (interbank borrowing, repo, debenture issuance) when deposits are insufficient.
- **Foreign Exchange (Forex) Management:** Managing the bank's open foreign currency positions, executing forex transactions for corporate clients, and complying with NRB forex regulations.
- **Interest Rate Management:** Managing the bank's sensitivity to interest rate changes across its loan and deposit portfolios.
- **Regulatory Compliance:** Maintaining CRR (cash with NRB) and SLR (statutory liquidity ratio in government securities) as mandated by NRB.

**2. Asset-Liability Management (ALM):**

**ALM** is the practice of strategically managing the bank's balance sheet — its assets (loans, investments) and liabilities (deposits, borrowings) — to optimize profitability while managing risks arising from mismatches in timing (maturity), interest rate sensitivity, and currency between assets and liabilities.

**Key ALCO (Asset-Liability Committee) Members:** CEO, CFO, Treasurer, CRO, Head of Retail Banking — meets monthly/weekly.

**3. Key Risks Managed by ALCO:**

*(a) Interest Rate Risk:*
- **Re-pricing Risk:** Different rates at which assets and liabilities reprice when interest rates change. If a bank has more floating-rate liabilities (deposits repricing in 3 months) than floating-rate assets, a rate rise increases funding costs faster than asset income — squeezes Net Interest Margin (NIM).
- **Yield Curve Risk:** Risk from non-parallel shifts in the yield curve.
- **Basis Risk:** Risk from different reference rates (e.g., assets linked to base rate, liabilities to NEPSE rate).

*(b) Liquidity Risk:*
- **Funding Liquidity Risk:** Risk of being unable to meet cash obligations as they fall due.
- **Market Liquidity Risk:** Risk of being unable to sell assets at fair value due to market disruption.

*(c) Currency Risk:*
- Net open currency position — exposure to USD/INR/EUR fluctuations affecting the value of forex assets/liabilities.

**4. Tools to Manage Interest Rate Risk:**

- **Gap Analysis:** Measures the difference (gap) between interest rate sensitive assets (ISA) and interest rate sensitive liabilities (ISL) repricing within specific time buckets (0–30 days, 30–90 days, 90–180 days, etc.). A positive gap = assets exceed liabilities (benefits from rate rise); negative gap = opposite.

- **Duration Analysis:** Measures the weighted average time to receive all cash flows from a financial instrument — longer duration = higher sensitivity to interest rate changes. **Modified Duration** quantifies the price change for a 1% change in interest rates.

- **Net Interest Income (NII) Simulation:** Models the impact of various interest rate scenarios (parallel shift, twist, steepening) on the bank's annual NII — stress testing income sensitivity.

- **Interest Rate Swaps:** Contract to swap fixed-rate payments for floating-rate payments (or vice versa) — used to transform the effective repricing profile of assets or liabilities without changing the underlying balance sheet.

- **Internal Transfer Pricing:** Funds Transfer Pricing (FTP) system where Treasury charges business units for funding their assets and credits them for deposits raised — properly allocates interest rate risk to Treasury.

**Conclusion:** Effective ALM is essential for RBB to maintain stable profitability across interest rate cycles, manage liquidity safely, and optimize its balance sheet composition within NRB's regulatory framework.''',
          ),
          ModelQuestion(
            number: 3,
            questionText: 'Define Letter of Credit (LC). Explain the types of LC used in trade finance. Describe the key parties involved and the process flow of a Documentary Letter of Credit transaction.',
            marks: 10,
            marksBreakdown: '2+4+4=10',
            answer: '''**1. Letter of Credit (LC) — Definition:**

A **Letter of Credit (LC)** is a formal, legally binding payment instrument issued by a bank (**issuing bank**) on behalf of a buyer (**applicant/importer**), guaranteeing payment to the seller (**beneficiary/exporter**) provided the seller presents documents strictly complying with the terms and conditions specified in the LC.

LCs facilitate international trade by substituting the creditworthiness of a bank for that of the buyer — eliminating the risk that the seller won't be paid and the buyer won't receive goods. Governed by **UCP 600 (ICC Uniform Customs and Practice for Documentary Credits)**.

**2. Types of Letters of Credit:**

- **Revocable LC:** Can be amended or cancelled by the issuing bank without notice to the beneficiary — rarely used due to high risk to seller.
- **Irrevocable LC:** Cannot be modified or cancelled without agreement of all parties — most common in international trade.
- **Confirmed LC:** A second bank (confirming bank, usually in the exporter's country) adds its own payment guarantee — reduces exporter's risk further (used with risky issuing banks/countries).
- **Sight LC:** Payment made immediately upon presentation of complying documents — exporter gets paid right away.
- **Usance (Deferred Payment) LC:** Payment made at a future date (e.g., 30/60/90 days after shipment) — provides buyer with credit period.
- **Red Clause LC:** Allows the issuing bank to advance funds to the beneficiary before shipment — seller gets advance for production costs.
- **Green Clause LC:** Like Red Clause but also allows storage/warehousing of goods at buyer's risk before shipment.
- **Standby LC:** Functions like a bank guarantee — payment triggered only if the applicant fails to fulfill their contractual obligation (used as performance/financial guarantee).
- **Revolving LC:** Automatically reinstates its value after each utilization — used for recurring purchases from the same supplier.

**3. Key Parties in an LC Transaction:**

- **Applicant (Buyer/Importer):** Requests the bank to issue the LC; bears obligation to reimburse the bank upon payment.
- **Issuing Bank (RBB):** Issues the LC on behalf of the applicant; primary payment obligor.
- **Beneficiary (Seller/Exporter):** Receives payment upon presenting complying documents.
- **Advising Bank:** Bank in the exporter's country that forwards the LC to the beneficiary and verifies its apparent authenticity.
- **Confirming Bank (Optional):** Adds its own guarantee to the LC, paying the beneficiary directly if the issuing bank fails.
- **Negotiating Bank:** Bank that purchases (negotiates) the beneficiary's documents and provides immediate payment, then seeks reimbursement from the issuing bank.

**4. Process Flow of a Documentary LC:**

1. **Application:** Nepalese importer (buyer) approaches RBB with a purchase agreement and applies for an LC.
2. **Issuance:** RBB evaluates the importer's creditworthiness, creates the LC, and transmits it via **SWIFT (MT700 message)** to the advising bank in the exporter's country.
3. **Notification:** Advising bank checks the LC's authenticity (SWIFT key verification) and notifies the exporter of the LC terms.
4. **Shipment:** Exporter ships the goods and collects required documents (Bill of Lading, Commercial Invoice, Packing List, Certificate of Origin, Insurance Certificate).
5. **Document Presentation:** Exporter submits all documents to the advising/negotiating bank within the document presentation period (typically 21 days from shipment).
6. **Document Examination:** Advising/negotiating bank examines documents for strict compliance with LC terms (UCP 600 gives banks 5 banking days to examine).
7. **Payment:** If documents comply, the bank pays the exporter (sight LC: immediately; usance LC: on the due date).
8. **Reimbursement:** Advising/negotiating bank forwards documents to RBB and seeks reimbursement via SWIFT (MT 742 or direct debit of vostro account).
9. **Document Release:** RBB forwards documents to the importer (buyer) against payment or acceptance of a bill of exchange.
10. **Customs Clearance:** Importer uses the Bill of Lading and other documents to clear goods at Nepal customs.

**Conclusion:** LC is the cornerstone of international trade finance, providing security to both importers and exporters. RBB's trade finance department manages significant LC volumes for Nepali importers, generating fee income while facilitating Nepal's international trade.''',
          ),
          ModelQuestion(
            number: 4,
            questionText: 'Explain the concept of Basel III Capital Framework. How does it differ from Basel II? What are the three pillars of Basel III and how has NRB implemented these requirements for Nepalese banks?',
            marks: 10,
            marksBreakdown: '3+3+4=10',
            answer: '''**1. Basel III Capital Framework:**

**Basel III** is the third generation of the Basel Accords — an international regulatory framework developed by the **Basel Committee on Banking Supervision (BCBS)** in response to the 2007–2008 Global Financial Crisis. It strengthens bank capital requirements, introduces new liquidity standards, and addresses systemic risk.

**2. Basel III vs. Basel II — Key Differences:**

| Aspect | Basel II (2004) | Basel III (2010, phased in 2010–2019) |
|---|---|---|
| **Capital Quality** | Broad definition of capital allowed | Stricter definition; emphasis on Common Equity Tier 1 (CET1) — highest quality capital |
| **Minimum CET1** | Not specified separately | 4.5% of RWA minimum |
| **Capital Buffers** | No capital conservation buffer | Capital Conservation Buffer (CCB): 2.5%; Counter-Cyclical Buffer: 0–2.5% |
| **Leverage Ratio** | No leverage ratio | Minimum 3% Leverage Ratio (prevents excessive on/off-balance-sheet leverage) |
| **Liquidity Standards** | No specific liquidity ratios | LCR (Liquidity Coverage Ratio) and NSFR (Net Stable Funding Ratio) |
| **Systemic Risk** | Limited systemic risk considerations | GSIB/DSIB surcharge for systemically important banks |
| **Overall CAR** | 8% minimum | 10.5% minimum (8% + 2.5% conservation buffer) |

**3. Three Pillars of Basel III:**

*Pillar 1 — Minimum Capital Requirements:*
Quantitative minimum capital banks must hold:
- **CET1 (Common Equity Tier 1):** ≥ 4.5% of RWA — highest quality (paid-up capital, retained earnings, statutory reserves).
- **Total Tier 1 Capital:** ≥ 6% of RWA (CET1 + Additional Tier 1 — qualifying hybrid instruments).
- **Total Capital (Tier 1 + Tier 2):** ≥ 8% of RWA.
- **Capital Conservation Buffer (CCB):** Additional 2.5% CET1 — banks restricting dividends, buybacks if CCB is breached.
- **Counter-Cyclical Capital Buffer (CCyB):** 0–2.5% CET1, imposed by regulators during credit booms to build buffers.
- **Leverage Ratio:** Tier 1 Capital / Total Exposure (on+off balance sheet) ≥ 3%.
- **Liquidity Ratios:** LCR ≥ 100% (30-day liquidity stress); NSFR ≥ 100% (1-year stable funding).

*Pillar 2 — Supervisory Review Process (SREP):*
- Regulators assess whether banks hold sufficient capital above Pillar 1 minimums given their specific risk profiles (concentration risk, operational risk, strategic risk, IRRBB).
- Banks must conduct **Internal Capital Adequacy Assessment Process (ICAAP)** — own stress testing and capital planning.
- Supervisors may impose additional **Pillar 2 capital requirements** above Pillar 1 minimums if deemed necessary.

*Pillar 3 — Market Discipline (Disclosure):*
- Banks must publicly disclose detailed information about their capital composition, risk exposures, and risk management practices — enabling market participants (shareholders, creditors) to assess bank risk and incentivizing prudent management.
- Disclosures cover: CAR breakdown, RWA by risk type, securitization exposures, remuneration policies.

**4. NRB Implementation of Basel III for Nepalese Banks:**

- **CAR:** NRB mandates **11% minimum CAR** for Class A BFIs — above Basel III's 10.5% — reflecting Nepal's risk environment.
- **Core Capital (Tier 1):** NRB minimum of **8.5% of RWA** (Basel III requires 6%).
- **Capital Conservation Buffer:** NRB has implemented the 2.5% CCB requirement.
- **Leverage Ratio:** NRB monitors leverage through the CD ratio and capital adequacy requirements.
- **Liquidity:** NRB monitors bank liquidity through CRR (4%) and SLR requirements.
- **ICAAP:** NRB requires all Class A banks to maintain an ICAAP document and submit annually.
- **Disclosure:** NRB requires quarterly publication of financial statements and annual **Basel III Disclosure Reports** by all commercial banks.

**Conclusion:** NRB's Basel III implementation, with CAR requirements above international minimums, reflects Nepal's developmental banking context and aims to ensure that Nepalese commercial banks maintain strong capital buffers to absorb economic shocks and protect depositors.''',
          ),
          ModelQuestion(
            number: 5,
            questionText: 'What is Financial Intelligence Unit (FIU) of Nepal? Explain its role in combating money laundering and terrorism financing. What information must banks report to FIU and under what circumstances?',
            marks: 10,
            marksBreakdown: '3+4+3=10',
            answer: '''**1. Financial Intelligence Unit (FIU) — Nepal:**

The **Financial Intelligence Unit (FIU) Nepal** is an independent governmental agency established under the **Asset (Money) Laundering Prevention Act 2064** and subsequently the **Prevention of Money Laundering Act 2079**. It operates under the Nepal Rastra Bank and serves as Nepal's national center for:

- Receiving, analyzing, and disseminating financial intelligence related to money laundering (ML) and terrorism financing (TF).
- Acting as Nepal's central point of contact for international FIU networks (Egmont Group).

**Mandate:** *"To receive, analyze, and disseminate financial intelligence to competent authorities for the prevention, detection, investigation and prosecution of money laundering and terrorist financing offenses."*

**FIU Nepal is a member of the Egmont Group** — a network of 165 FIUs worldwide that facilitates sharing of financial intelligence across borders.

**2. FIU's Role in Combating ML/TF:**

*Collection Function:*
- Receives **Suspicious Transaction Reports (STRs)** from all reporting entities (banks, insurance companies, remittance companies, casinos, real estate agents, lawyers).
- Receives **Cash Transaction Reports (CTRs)** for large cash transactions above threshold.
- Receives **Cross-Border Currency Reports (CBCRs)** from Nepal Customs for cross-border cash movements.

*Analysis Function:*
- Conducts **strategic analysis** to identify ML/TF trends, patterns, and emerging threats in Nepal's financial system.
- Conducts **operational analysis** on specific STRs/CTRs using financial databases, police records, tax records, and information from foreign FIUs.
- Maintains a comprehensive financial intelligence database.

*Dissemination Function:*
- Shares actionable financial intelligence with **Nepal Police**, **Central Investigation Bureau (CIB)**, **Department of Revenue Investigation**, **Attorney General's Office**, and other competent authorities for investigation and prosecution.
- Exchanges information with foreign FIUs on international ML/TF cases (Egmont network).

*Supervisory Function:*
- Supervises compliance of non-bank reporting entities (casinos, lawyers, accountants) with AML/CFT obligations.
- Issues guidelines and conducts training for reporting entities.

**3. Mandatory Bank Reporting to FIU:**

*A. Suspicious Transaction Report (STR):*
Banks must file an STR with FIU within **3 working days** of identifying a suspicious transaction — one that gives reasonable grounds to suspect it involves proceeds of crime or is related to terrorism financing.

**Circumstances triggering STR filing:**
- Unusually large cash deposits/withdrawals inconsistent with customer's known business.
- Structuring (breaking large transactions into smaller ones to avoid CTR threshold — "smurfing").
- Multiple customers transferring funds to the same beneficiary abroad without clear economic justification.
- Requests to maintain anonymity about account ownership or beneficial owners.
- Transactions involving high-risk jurisdictions (FATF blacklist/greylist countries).
- Customer activity inconsistent with their KYC profile, stated income, or business nature.
- Rapid movement of funds through an account (round-tripping) without economic substance.
- Customer provides false or inconsistent information during KYC.
- Foreign politically exposed persons (PEPs) conducting unusual transactions.

*B. Cash Transaction Report (CTR):*
Banks must automatically file CTRs within **3 working days** for:
- Any single cash transaction (deposit, withdrawal, exchange) exceeding **Rs. 10,00,000** (Rs. 10 Lakhs).
- Multiple related cash transactions in a single day that collectively exceed Rs. 10 Lakhs.
- High-risk customer transactions above Rs. 5 Lakhs (as per enhanced due diligence requirements).

*C. Cross-Border Fund Transfer Reports:*
Banks must report international fund transfers above NRB-specified thresholds to FIU.

*D. Non-Compliance Consequences:*
Failure to file STRs/CTRs: Banks face fines up to Rs. 5 Lakhs per violation; repeat violations can lead to license suspension; individual responsible officers face personal criminal liability under Prevention of Money Laundering Act 2079.

**Conclusion:** The FIU is Nepal's financial watchdog against ML/TF. Commercial banks like RBB play a critical frontline role through rigorous KYC, transaction monitoring systems, and timely STR/CTR filing — the quality of banks' reporting directly determines the effectiveness of Nepal's AML/CFT enforcement system.''',
          ),
        ],
      ),
      ModelSection(
        title: "समूह 'ख'  (Group B)",
        subtitle: 'Information Technology — 50 Marks',
        totalMarks: 50,
        questions: [
          ModelQuestion(
            number: 6,
            questionText: 'What is an Operating System? Compare Windows Server and Linux (Ubuntu Server) for banking server deployments. What are the advantages of Linux for hosting a Core Banking System?',
            marks: 10,
            marksBreakdown: '2+5+3=10',
            answer: '''**1. Operating System (OS) — Definition:**

An **Operating System** is system software that manages hardware resources (CPU, memory, storage, I/O devices) and provides a platform for application programs to run. It acts as an intermediary between users/applications and physical hardware.

**Core OS Functions:**
- **Process Management:** CPU scheduling (Round Robin, Priority, FCFS); process creation/termination.
- **Memory Management:** Virtual memory, paging, segmentation; memory allocation/deallocation.
- **File System Management:** File storage, access control, directory structure (NTFS, ext4).
- **I/O Device Management:** Driver interface, interrupt handling, buffering/caching.
- **Security and Access Control:** User authentication, permissions, audit logging.
- **Networking:** TCP/IP stack, network interface management.

**2. Windows Server vs. Linux Server for Banking:**

| Dimension | Windows Server 2022 | Linux (Ubuntu/RHEL/CentOS) |
|---|---|---|
| **Licensing Cost** | Expensive (per-core licensing) | Free (Ubuntu); low cost RHEL support subscription |
| **Performance** | Good; higher resource overhead from GUI | Excellent; lightweight server installations; higher throughput |
| **Stability/Uptime** | Requires periodic restarts for patches | Can patch without reboots (kpatch); years of uninterrupted uptime |
| **Security** | Regular critical patches needed; larger attack surface | Fewer malware threats; granular permission model; open-source audit trail |
| **Database Compatibility** | Full compatibility with MS SQL Server | Excellent for Oracle DB, PostgreSQL, MySQL; CBS solutions prefer Linux |
| **Scripting/Automation** | PowerShell | Bash/Python/Ansible — richer automation ecosystem |
| **Web/App Server** | IIS (Internet Information Services) | Apache, NGINX, Tomcat — widely used for banking APIs |
| **Support** | Microsoft official support | Red Hat (RHEL), Canonical (Ubuntu), community |
| **GUI** | GUI-based administration | CLI-based (can add GUI); requires higher admin skill |
| **Market Share (Banking)** | Used for Active Directory, MS Office servers | Dominant for CBS, database, and web servers |

**3. Advantages of Linux for Core Banking System (CBS) Hosting:**

- **Superior Performance:** Linux servers under high transaction load (thousands of concurrent banking transactions) typically outperform Windows Server by 15–30% in throughput benchmarks — critical for peak-hour CBS performance.
- **Cost Efficiency:** Eliminating Windows Server per-core licensing costs for 40+ server CBS cluster can save tens of millions of rupees annually for large banks — cost redirected to security infrastructure.
- **Oracle Database Compatibility:** Oracle Database (the most common CBS database engine) runs natively and is heavily optimized for Linux — Oracle performance advisories frequently recommend RHEL/Oracle Linux over Windows.
- **High Availability:** Linux supports advanced HA clustering technologies (Pacemaker, Corosync, DRBD) for active-passive/active-active CBS clusters with automatic failover — ensuring NRB-mandated CBS RTO requirements.
- **Security:** The Linux privilege separation model (root vs. application user), SELinux/AppArmor mandatory access controls, and smaller attack surface reduce CBS compromise risk. Financial-grade Linux distributions receive rapid security patches.
- **Containerization (Docker/Kubernetes):** Linux natively supports container orchestration — modern banks deploy CBS microservices in Docker containers on Kubernetes clusters on Linux, enabling rapid scaling and deployment.
- **Long-Term Support:** Ubuntu Server LTS (5-year support), RHEL (10-year), Oracle Linux (10-year) provide long-term stability without forced upgrades during critical banking periods.

**Conclusion:** While Windows Server has legitimate use for specific banking applications (Active Directory, Office 365 integration, end-user workstations), Linux is the dominant and preferred platform for CBS servers, database hosting, and API infrastructure in commercial banking worldwide — and increasingly in Nepali banking as well.''',
          ),
          ModelQuestion(
            number: 7,
            questionText: 'Explain the concept of Digital Signature and PKI (Public Key Infrastructure). How does a digital signature work step-by-step? What is the legal validity of digital signatures in Nepal under ETA 2063?',
            marks: 10,
            marksBreakdown: '2+5+3=10',
            answer: '''**1. Digital Signature — Concept:**

A **digital signature** is a cryptographic mechanism that provides a mathematical proof that:
1. A specific document or message was **created/approved by a particular entity** (Authentication).
2. The content has **not been altered** after signing (Integrity).
3. The signer **cannot deny** having signed the document (Non-Repudiation).

It is the electronic equivalent of a handwritten signature but is far more secure — impossible to forge without the signer's private key.

**2. How a Digital Signature Works — Step-by-Step:**

*Signing Process (Sender's Side):*

**Step 1 — Document Hashing:**
The sender (e.g., a bank officer authorizing a payment) runs the document/transaction data through a **cryptographic hash function** (SHA-256 or SHA-3), producing a fixed-length unique **Message Digest** (hash value). Even a single character change in the document produces a completely different hash.

**Step 2 — Hash Encryption (Signing):**
The message digest is **encrypted using the sender's Private Key** (RSA-4096 or ECC P-256). This encrypted digest IS the digital signature. Only the holder of the private key can create this specific encrypted hash.

**Step 3 — Transmission:**
The sender transmits: [Original Document] + [Digital Signature] + [Digital Certificate containing Public Key].

*Verification Process (Receiver's Side):*

**Step 4 — Hash Decryption:**
The receiver **decrypts the digital signature** using the sender's **Public Key** (obtained from the digital certificate). This recovers the original message digest that the sender computed.

**Step 5 — Independent Hashing:**
The receiver independently runs the received document through the **same hash function (SHA-256)**, computing a fresh digest of the received document.

**Step 6 — Comparison:**
The receiver **compares the two digests**:
- **If identical:** The signature is valid — the document was definitely signed by the private key holder and has not been altered in transit. ✓
- **If different:** Either the document was tampered with, or the signature is forged. ✗

**Step 7 — Certificate Verification:**
The receiver verifies the signer's digital certificate:
- Is it issued by a trusted Certifying Authority?
- Is it within its validity period?
- Has it been revoked (check CRL or OCSP)?

**PKI Components:**
- **CA (Certificate Authority):** Issues, signs, and revokes X.509 digital certificates. Root CA → Intermediate CA → End-Entity Certificate chain.
- **RA (Registration Authority):** Verifies applicant identity before CA issues certificate.
- **CRL (Certificate Revocation List):** Published list of revoked certificates.
- **OCSP (Online Certificate Status Protocol):** Real-time online check of certificate validity.

**3. Legal Validity of Digital Signatures in Nepal:**

Under **Electronic Transaction Act (ETA) 2063:**

- **Section 7:** A digital signature affixed to an electronic record has the same legal effect as a handwritten signature.
- **Section 4:** An electronic record satisfies any legal requirement for "writing."
- **Section 15:** A digital signature certificate issued by a **licensed Certifying Authority** is legally valid.
- **Certifying Authorities:** Licensed by the Controller of Certifying Authorities under the NTA (Nepal Telecommunications Authority). NTA operates Nepal's **Root CA** for the national PKI.
- **Admissibility:** Digitally signed electronic documents are admissible as evidence in Nepali courts under the Evidence Act, provided the digital signature was created by a licensed CA's certificate.
- **Government Use:** Nepal government digitally signs official documents, NID data, tax filings, and e-procurement tenders using ETA 2063-compliant digital signatures.

**Banking Application:**
- RBB's loan documents signed electronically by customers via PKI-based digital signatures are legally binding contracts.
- SWIFT financial messages are authenticated using PKI-based digital signatures.
- NRB regulatory reports submitted electronically must be digitally signed by authorized bank officials.

**Conclusion:** Digital signatures provide the legal foundation for Nepal's digital financial system — enabling secure, legally valid electronic banking transactions and contracts without requiring physical presence or paper documents.''',
          ),
          ModelQuestion(
            number: 8,
            questionText: 'What is IT Audit? Explain the key areas examined in an IT audit of a commercial bank. What are IS Audit Standards (ISACA CISA) and how do they guide IT audit processes in banking?',
            marks: 10,
            marksBreakdown: '2+4+4=10',
            answer: '''**1. IT Audit — Definition:**

An **IT Audit** (or Information Systems Audit) is a systematic examination and evaluation of an organization's IT infrastructure, policies, operations, and controls to:
- Assess the adequacy and effectiveness of IT controls.
- Verify that IT systems are operating as intended and producing reliable information.
- Ensure compliance with applicable laws, regulations, and standards.
- Identify IT risks and vulnerabilities requiring remediation.

**Who Conducts IT Audit in Banks:**
- **Internal IT Audit Team:** Reports to the Audit Committee of the Board; conducts continuous/periodic audits.
- **External IT Auditors:** Independent firms engaged annually; provide objective assessment to regulators and shareholders.
- **Regulatory Audit:** NRB IT inspectors conduct periodic on-site IT examinations of BFIs.

**2. Key Areas Examined in a Bank IT Audit:**

*(a) IT Governance:*
- Does the bank have a board-approved IT Strategy aligned with business strategy?
- Is an IT Steering Committee functioning and meeting regularly?
- Is IT risk integrated into the bank's ERM framework?
- Does the bank have a qualified CIO with appropriate authority?

*(b) Access Control and Identity Management:*
- Are access rights granted based on job function (least privilege, need-to-know)?
- Are superuser/privileged accounts logged, monitored, and reviewed quarterly?
- Are terminated employee accounts disabled within 24 hours?
- Is MFA enforced for critical systems (CBS, internet banking admin)?
- Are access reviews conducted periodically (quarterly/annually)?

*(c) Core Banking System (CBS) Controls:*
- Is there segregation of duties for transaction initiation vs. authorization?
- Are all CBS transactions logged with complete audit trail (who, what, when, from where)?
- Are maker-checker controls enforced for sensitive transactions (fund transfers, limit modifications)?
- Is CBS change management controlled (no unauthorized code changes)?

*(d) Data Integrity and Database Security:*
- Is customer financial data encrypted at rest (AES-256)?
- Are database administrative activities logged and monitored?
- Is database access restricted — application accesses only required tables, never direct user access to production databases?

*(e) Network Security:*
- Are firewalls, IDS/IPS properly configured with current rule sets?
- Is penetration testing conducted annually with findings tracked to resolution?
- Is there a DMZ isolating internet-facing systems from internal banking network?

*(f) Business Continuity and Disaster Recovery:*
- Is there a documented BCP/DRP?
- Was the DR failover test conducted and did systems meet NRB's RTO/RPO requirements?
- Are backups encrypted, off-site, and tested for restorability?

*(g) Software Change Management:*
- Are production system changes tested in UAT environment before deployment?
- Is change management board (CAB) approval documented for all major changes?
- Is emergency change process controlled and logged?

*(h) Vendor and Third-Party Risk:*
- Are all IT vendors assessed for security compliance?
- Do contracts include right-to-audit, SLA, and data security obligations?
- Is CBS vendor's code independently reviewed?

**3. ISACA CISA Standards and Their Guidance:**

**ISACA (Information Systems Audit and Control Association)** is the global professional body for IT auditors. **CISA (Certified Information Systems Auditor)** is the gold standard certification for IT audit professionals.

*Key ISACA Standards Relevant to Banking:*

- **IS Audit Standards 1001–1401:** Define independence, professional competence, planning, evidence gathering, reporting, and follow-up requirements for IS auditors.
- **COBIT 2019 (Control Objectives for IT):** ISACA's comprehensive IT governance and management framework — defines 40 governance and management objectives. NRB IT Guidelines align with COBIT concepts.
- **Risk IT Framework:** Defines how IT risks should be identified, assessed, and managed in alignment with enterprise risk management.
- **Val IT:** Framework for measuring the business value of IT investments.

*How CISA/ISACA Standards Guide Banking IT Audits:*

1. **Risk-Based Audit Planning:** ISACA standards require IT auditors to base their audit scope on a risk assessment — focusing more resources on high-risk areas (CBS, internet banking, data centers).
2. **Evidence Standards:** Define minimum evidence quality required for audit conclusions — automated system logs, control test results, and management representations all have defined weight.
3. **Independence:** CISA standards require IT auditors to be independent of the systems they audit — no audit of systems the auditor helped design or operate.
4. **Reporting:** Define what must be reported to management and the board — material control deficiencies must be escalated promptly.
5. **Continuous Audit Approach:** Modern ISACA guidance promotes continuous monitoring using automated tools (SIEM, data analytics) rather than annual point-in-time audits.

**Conclusion:** IT Audit is a critical governance and risk management function for Nepali commercial banks — providing the Board, NRB, and external stakeholders with assurance that the bank's IT systems are secure, reliable, and compliant. ISACA/CISA standards provide the internationally recognized methodology for conducting rigorous, credible IT audits.''',
          ),
          ModelQuestion(
            number: 9,
            questionText: 'What is software testing? Explain the different types of testing (unit, integration, system, UAT) and testing methodologies (black-box, white-box). Why is rigorous testing critical before deploying Core Banking System upgrades?',
            marks: 10,
            marksBreakdown: '2+5+3=10',
            answer: '''**1. Software Testing — Definition:**

**Software testing** is the systematic process of evaluating a software application by executing it under controlled conditions to detect defects (bugs, errors, vulnerabilities), verify it meets specified requirements, and validate it satisfies user needs before production deployment.

**2. Types of Testing:**

*(a) Unit Testing:*
- Tests the smallest testable components (individual functions, classes, methods) in isolation.
- Conducted by **developers** during coding.
- **Banking Example:** Testing the `calculateInterest(principal, rate, days)` function in CBS for different input values including edge cases (zero balance, negative rate, leap year dates).
- Tools: JUnit (Java), pytest (Python), NUnit (.NET).
- **Automation:** Typically 70–80% automated in modern development.

*(b) Integration Testing:*
- Tests the **interaction and data flow between integrated modules** — ensuring combined components work correctly together.
- **Banking Example:** Testing that the loan origination module correctly creates a GL ledger entry in the accounting module when a loan is disbursed; testing that the interest calculation module correctly feeds the statement generation module.
- Types: Top-down, Bottom-up, Big-Bang integration.

*(c) System Testing:*
- Tests the **complete, integrated CBS** as a whole against the full functional and non-functional requirements specification.
- Tests end-to-end workflows: customer account opening → transaction processing → statement generation → regulatory reporting.
- Includes:
  - **Functional Testing:** Does the system do what it's supposed to do?
  - **Performance Testing:** Can the CBS handle 10,000 concurrent transactions? Response time < 2 seconds?
  - **Security Testing:** Can an unauthorized user access another customer's data?
  - **Regression Testing:** Has the new CBS version broken any previously working functionality?
  - **Compatibility Testing:** Does the CBS work correctly with all browsers, mobile apps, and ATM switches?

*(d) User Acceptance Testing (UAT):*
- Conducted by **actual bank users** (tellers, branch managers, operations staff) in a near-production environment.
- Validates that the CBS meets business requirements and real-world banking workflows — not just technical specifications.
- **Banking Example:** Actual RBB tellers test whether end-of-day batch processing, account dormancy processing, and NRB report generation work correctly in the new CBS version.
- Formal sign-off by business owners required before production deployment.

**Testing Methodologies:**

| Aspect | **Black-Box Testing** | **White-Box Testing** |
|---|---|---|
| Knowledge of Code | Tester has NO knowledge of internal code | Tester has FULL access to source code |
| Focus | External behavior — inputs vs. outputs | Internal logic, code paths, branches, loops |
| Who Conducts | QA team, end users | Developers |
| Techniques | Equivalence partitioning, boundary value analysis | Statement coverage, branch coverage, path coverage |
| Banking Use | Functional testing, UAT, security penetration testing | Unit testing, code review, vulnerability scanning |

**3. Why Rigorous Testing is Critical for CBS Upgrades:**

- **Zero Tolerance for Financial Errors:** A bug causing wrong interest calculation on savings accounts could create thousands of incorrect customer balances — leading to regulatory fines, customer compensation, and reputational damage.
- **Regulatory Compliance Risk:** CBS upgrades must comply with updated NRB reporting formats, new CAR calculations, and AML rule changes. Untested changes may produce incorrect regulatory reports.
- **Data Integrity:** CBS upgrades involve database schema migrations — insufficient testing can corrupt years of customer transaction history.
- **System Availability:** NRB mandates CBS availability of 99.5%+ — a failed production deployment causing CBS downtime violates regulatory requirements and business continuity obligations.
- **Integration Complexity:** CBS integrates with SWIFT, RTGS, ATM switch, mobile banking, internet banking, credit bureau, and NRB systems — untested upgrade can disrupt all dependent systems simultaneously.
- **Financial Crime Risk:** Security vulnerabilities in untested CBS code can be exploited by attackers to manipulate transactions or steal funds.

**NRB Requirement:** NRB IT Guidelines mandate that all major CBS changes undergo formal **UAT with documented test plans and sign-offs** before production deployment; emergency changes require post-deployment testing and incident reporting.

**Conclusion:** In banking, software defects are not merely inconvenient — they can cause direct financial losses, regulatory violations, and systemic risk. The investment in rigorous multi-stage testing for CBS upgrades is always justified by the severity of potential consequences of production defects.''',
          ),
          ModelQuestion(
            number: 10,
            questionText: 'Explain the concept of Data Warehouse and Business Intelligence (BI) in banking. How does NRB use supervisory data reporting? Describe the key analytical reports that commercial banks generate for internal management and regulatory submission.',
            marks: 10,
            marksBreakdown: '4+3+3=10',
            answer: '''**1. Data Warehouse and Business Intelligence (BI) in Banking:**

*Data Warehouse:*
A **Data Warehouse (DWH)** is a large, centralized repository that collects, integrates, and stores structured data from multiple operational sources (CBS, loan management systems, card systems, HR, finance) — organized for analysis and reporting rather than day-to-day transaction processing.

**Key Characteristics (W.H. Inmon's definition):**
- **Subject-Oriented:** Organized around business subjects (Customers, Accounts, Loans, Transactions) not operational processes.
- **Integrated:** Data from multiple source systems is cleansed, standardized, and transformed (ETL: Extract, Transform, Load) into a consistent format.
- **Non-Volatile:** Historical data is preserved — data is appended not deleted. Enables trend analysis over years.
- **Time-Variant:** Every data record includes a time dimension — enables historical comparison.

**Architecture:**
Source Systems (CBS, Card, Loans) → **ETL Pipeline** → Staging Area → **Data Warehouse (Star Schema / Snowflake Schema)** → **Data Marts** (Credit Risk, Treasury, Retail Banking) → BI Reporting Tools (Power BI, Tableau, Oracle Analytics).

*Business Intelligence (BI):*
**BI** encompasses the technologies, tools, and methodologies used to analyze banking data and transform it into actionable insights for management decision-making.

**BI Components in Banking:**
- **Dashboards:** Real-time operational metrics — total deposits, daily transactions, branch performance.
- **OLAP (Online Analytical Processing):** Multi-dimensional analysis — NPL trend by branch, by product, by borrower sector.
- **Ad-hoc Reporting:** Business users create custom reports without IT help (self-service BI).
- **Predictive Analytics:** Machine learning models predict credit default probability, customer churn, fraud patterns.
- **Data Mining:** Discovery of patterns — customer segmentation, cross-selling opportunities.

**2. NRB Supervisory Data Reporting:**

NRB uses a sophisticated supervisory data collection and analysis framework to monitor the health of the banking system:

- **BNOS (Bank Notification and Online System):** NRB's online portal where all BFIs submit regulatory returns electronically.
- **Consolidated Supervisory Database:** NRB aggregates data across all BFIs for macro-prudential analysis — system-wide credit growth, NPL trends, sector concentration.
- **Off-Site Surveillance:** NRB analysts monitor weekly/monthly data submissions to detect early warning signs of deteriorating bank health (rising NPL, declining CAR, liquidity stress indicators).
- **FIIN (Financial Intelligence Information Network):** NRB's supervisory analytics platform for monitoring systemic financial stability indicators.

**3. Key Analytical Reports in Banking:**

*For Internal Management (generated from DWH/BI):*
- **Daily Liquidity Report:** Cash position, CRR compliance, SLR compliance, overnight borrowing requirement.
- **Asset Quality Report:** NPL ratio by loan category, provision adequacy, watch-list accounts, early warning signals.
- **NIM (Net Interest Margin) Analysis:** Yield on loans vs. cost of deposits by product, branch, and segment.
- **Branch Performance Dashboard:** Deposits mobilized, loans disbursed, fee income, NPL, customer count — compared to targets.
- **Customer Profitability Analysis:** Revenue minus cost per customer segment — guides cross-selling strategy.

*For NRB Regulatory Submission:*
- **BFI-8 (Weekly Return):** Deposit and advance position; CRR and SLR compliance.
- **Off-Site Supervision Report (OSR):** Monthly comprehensive financial statement including CAR, NPL, large borrower exposures, sector concentration.
- **CD Ratio Report:** Monthly loan-to-deposit ratio compliance.
- **Large Credit Exposure Report:** Quarterly disclosure of single borrower and group exposures above NRB threshold.
- **Interest Rate Report:** Monthly deposit and lending rates by product category.
- **Capital Adequacy Return:** Quarterly detailed CAR calculation (Tier 1, Tier 2, RWA by risk category).
- **FIU Reports:** Quarterly STR/CTR statistics submitted to FIU Nepal.

**Conclusion:** The Data Warehouse and BI ecosystem is the analytical backbone of modern banking — enabling RBB's management to make data-driven decisions on lending strategy, liquidity management, and risk control, while providing NRB with the supervisory data needed to maintain the stability of Nepal's financial system.''',
          ),
        ],
      ),
    ],
  ),
];
