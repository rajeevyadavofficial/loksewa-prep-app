// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import 'rbb_model_papers_data.dart';

// ─────────────────────────────────────────────────────────────────────────────
// MODEL QUESTION PAPERS — Grid View of Sets (Sets A through K)
// Each card features Paper 1 & Paper 2 buttons opening the authentic Lok Sewa paper.
// ─────────────────────────────────────────────────────────────────────────────

class _SetInfo {
  final int index;
  final String letter;
  final String nepaliLetter;
  final ModelPaper paper1;
  final ModelPaper paper2;

  const _SetInfo({
    required this.index,
    required this.letter,
    required this.nepaliLetter,
    required this.paper1,
    required this.paper2,
  });
}

class ModelQuestionsTab extends StatefulWidget {
  final VoidCallback onGoToExams;
  const ModelQuestionsTab({super.key, required this.onGoToExams});

  @override
  State<ModelQuestionsTab> createState() => _ModelQuestionsTabState();
}

class _ModelQuestionsTabState extends State<ModelQuestionsTab> {
  int? _selectedSetIndex; // null = Grid View (all sets)
  int _selectedPaperIndex = 0; // 0 for Paper 1, 1 for Paper 2
  String _searchQuery = '';

  late final List<_SetInfo> _allSets;

  @override
  void initState() {
    super.initState();
    const nepaliLetters = ['क', 'ख', 'ग', 'घ', 'ङ', 'च', 'छ', 'ज', 'झ', 'ञ', 'ट'];
    final list = <_SetInfo>[];
    for (int i = 0; i < 11; i++) {
      if (i * 2 + 1 < rbbModelPapers.length) {
        list.add(_SetInfo(
          index: i,
          letter: String.fromCharCode(65 + i),
          nepaliLetter: i < nepaliLetters.length ? nepaliLetters[i] : '${i + 1}',
          paper1: rbbModelPapers[i * 2],
          paper2: rbbModelPapers[i * 2 + 1],
        ));
      }
    }
    _allSets = list;
  }

  void _openPaper(int setIndex, int paperIndex) {
    setState(() {
      _selectedSetIndex = setIndex;
      _selectedPaperIndex = paperIndex;
    });
  }

  void _backToSets() {
    setState(() {
      _selectedSetIndex = null;
    });
  }

  void _switchPaper(int paperIndex) {
    setState(() {
      _selectedPaperIndex = paperIndex;
    });
  }

  void _switchSet(int setIndex) {
    setState(() {
      _selectedSetIndex = setIndex;
    });
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
    if (_selectedSetIndex == null) {
      return _buildGridView(context);
    } else {
      return _buildPaperView(context);
    }
  }

  // ───────────────────────────────────────────────────────────────────────────
  // GRID VIEW (Sets A through K)
  // ───────────────────────────────────────────────────────────────────────────
  Widget _buildGridView(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 768;

    final filteredSets = _searchQuery.trim().isEmpty
        ? _allSets
        : _allSets.where((s) {
            final q = _searchQuery.toLowerCase().trim();
            return s.letter.toLowerCase().contains(q) ||
                s.nepaliLetter.contains(q) ||
                'set ${s.letter.toLowerCase()}'.contains(q) ||
                'सेट ${s.nepaliLetter}'.contains(q);
          }).toList();

    return Container(
      color: const Color(0xFFF8FAFC),
      child: CustomScrollView(
        slivers: [
          // Header Banner
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 32,
                vertical: isMobile ? 18 : 26,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1)),
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF991B1B), Color(0xFFDC2626)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFDC2626).withOpacity(0.25),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(Icons.menu_book_rounded, color: Colors.white, size: 24),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'राष्ट्रिय वाणिज्य बैंक (RBB) IT Level 5 — ११ पूर्ण नमूना सेटहरू',
                                  style: TextStyle(
                                    fontSize: isMobile ? 15.5 : 20,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xFF0F172A),
                                    letterSpacing: -0.2,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Senior Assistant (IT) Official Syllabus Based • २२ प्रश्नपत्रहरू (Paper 1 & Paper 2) • ८१४ अद्वितीय प्रश्नहरू • उत्तरसहित (Model Answers)',
                                  style: TextStyle(
                                    fontSize: isMobile ? 11.5 : 13,
                                    color: const Color(0xFF64748B),
                                    fontWeight: FontWeight.w500,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Spec tags row
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _buildHeaderBadge(
                            icon: Icons.layers_outlined,
                            label: '11 Full Sets (Sets A – K)',
                            color: const Color(0xFFDC2626),
                            bgColor: const Color(0xFFFEF2F2),
                          ),
                          _buildHeaderBadge(
                            icon: Icons.timer_outlined,
                            label: '200 Marks / 4.5 Hours per Set',
                            color: const Color(0xFF0284C7),
                            bgColor: const Color(0xFFF0F9FF),
                          ),
                          _buildHeaderBadge(
                            icon: Icons.check_circle_outline,
                            label: 'Strictly Official Syllabus',
                            color: const Color(0xFF16A34A),
                            bgColor: const Color(0xFFF0FDF4),
                          ),
                          _buildHeaderBadge(
                            icon: Icons.auto_awesome,
                            label: 'Detailed Model Answers',
                            color: const Color(0xFF9333EA),
                            bgColor: const Color(0xFFFAF5FF),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Search / Filter Row
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 16 : 32,
                    vertical: 18,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Select a Set (सेट छान्नुहोस्):',
                        style: TextStyle(
                          fontSize: isMobile ? 13.5 : 15,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: isMobile ? 150 : 220,
                        height: 38,
                        child: TextField(
                          onChanged: (val) => setState(() => _searchQuery = val),
                          decoration: InputDecoration(
                            hintText: 'Search Set (e.g. Set A)...',
                            hintStyle: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                            prefixIcon: const Icon(Icons.search, size: 16, color: Color(0xFF64748B)),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xFFDC2626), width: 1.5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Sets Grid
          SliverPadding(
            padding: EdgeInsets.only(
              left: isMobile ? 16 : 32,
              right: isMobile ? 16 : 32,
              bottom: 40,
            ),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth;
                      int crossAxisCount = 3;
                      if (width < 720) {
                        crossAxisCount = 1;
                      } else if (width < 1050) {
                        crossAxisCount = 2;
                      }

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 18,
                          crossAxisSpacing: 18,
                          mainAxisExtent: 260,
                        ),
                        itemCount: filteredSets.length,
                        itemBuilder: (context, idx) {
                          final set = filteredSets[idx];
                          return _SetCard(
                            set: set,
                            onOpenPaper1: () => _openPaper(set.index, 0),
                            onOpenPaper2: () => _openPaper(set.index, 1),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderBadge({
    required IconData icon,
    required String label,
    required Color color,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────────────────────────────────────────────────────────────
  // PAPER VIEW (With Top Set Bar & Paper 1/2 Switcher)
  // ───────────────────────────────────────────────────────────────────────────
  Widget _buildPaperView(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 768;
    final set = _allSets[_selectedSetIndex!];
    final activePaper = _selectedPaperIndex == 0 ? set.paper1 : set.paper2;

    return Column(
      children: [
        // Navigation Toolbar
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  // Back Button to Grid
                  OutlinedButton.icon(
                    onPressed: _backToSets,
                    icon: const Icon(Icons.arrow_back, size: 16),
                    label: Text(isMobile ? 'Sets' : 'All Sets (सबै सेटहरू)'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF0F172A),
                      side: const BorderSide(color: Color(0xFFCBD5E1)),
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 10 : 14,
                        vertical: isMobile ? 6 : 10,
                      ),
                      textStyle: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Set Selector Dropdown
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF2F2),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFFFECACA)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: set.index,
                        icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF991B1B)),
                        isDense: true,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF991B1B),
                        ),
                        onChanged: (newIdx) {
                          if (newIdx != null) _switchSet(newIdx);
                        },
                        items: _allSets.map((s) {
                          return DropdownMenuItem<int>(
                            value: s.index,
                            child: Text('Set ${s.letter} (सेट ${s.nepaliLetter})'),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  // Prev / Next quick navigators
                  if (!isMobile) ...[
                    const SizedBox(width: 6),
                    IconButton(
                      tooltip: 'Previous Set',
                      onPressed: set.index > 0 ? () => _switchSet(set.index - 1) : null,
                      icon: const Icon(Icons.chevron_left, size: 20),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                    ),
                    IconButton(
                      tooltip: 'Next Set',
                      onPressed: set.index < _allSets.length - 1 ? () => _switchSet(set.index + 1) : null,
                      icon: const Icon(Icons.chevron_right, size: 20),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                    ),
                  ],

                  const Spacer(),

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

              // Paper 1 & Paper 2 Switcher Tabs
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(4),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildPaperTabButton(
                        isSelected: _selectedPaperIndex == 0,
                        icon: Icons.article_outlined,
                        title: isMobile ? 'Paper 1 (प्रथम पत्र)' : 'Paper 1 (प्रथम पत्र: बैंकिङ्ग, लेखा, IT MCQs)',
                        marks: '100 Marks',
                        onTap: () => _switchPaper(0),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: _buildPaperTabButton(
                        isSelected: _selectedPaperIndex == 1,
                        icon: Icons.terminal_rounded,
                        title: isMobile ? 'Paper 2 (द्वितीय पत्र)' : 'Paper 2 (द्वितीय पत्र: IT Technical Subjective)',
                        marks: '100 Marks',
                        onTap: () => _switchPaper(1),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Paper View container on realistic neutral desk background
        Expanded(
          child: Container(
            color: const Color(0xFFE5E7EB), // Neutral desk surface
            child: _PaperView(
              key: ValueKey('paper_${_selectedSetIndex}_$_selectedPaperIndex'),
              paper: activePaper,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaperTabButton({
    required bool isSelected,
    required IconData icon,
    required String title,
    required String marks,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? AppTheme.iconRed : const Color(0xFF64748B),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                  color: isSelected ? const Color(0xFF0F172A) : const Color(0xFF64748B),
                ),
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFFEE2E2) : const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                marks,
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? const Color(0xFF991B1B) : const Color(0xFF64748B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SET CARD COMPONENT
// ─────────────────────────────────────────────────────────────────────────────
class _SetCard extends StatelessWidget {
  final _SetInfo set;
  final VoidCallback onOpenPaper1;
  final VoidCallback onOpenPaper2;

  const _SetCard({
    required this.set,
    required this.onOpenPaper1,
    required this.onOpenPaper2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Card Top Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
              children: [
                // Set Badge Icon
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF881337), Color(0xFFDC2626)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFDC2626).withOpacity(0.25),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    set.letter,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Set ${set.letter}',
                            style: const TextStyle(
                              fontSize: 16.5,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '(सेट ${set.nepaliLetter})',
                            style: const TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'RBB IT Level 5 • Full Model Set',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
                // 200 Marks Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF2F2),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0xFFFECACA)),
                  ),
                  child: const Text(
                    '200 Marks',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF991B1B),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Paper Descriptions summary
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPaperSummaryLine(
                    icon: Icons.article_outlined,
                    iconColor: const Color(0xFF0284C7),
                    title: 'Paper 1:',
                    desc: 'बैंकिङ्ग, व्यवस्थापन (50M) + 50 IT MCQs (50M)',
                  ),
                  const SizedBox(height: 8),
                  _buildPaperSummaryLine(
                    icon: Icons.terminal_rounded,
                    iconColor: const Color(0xFF16A34A),
                    title: 'Paper 2:',
                    desc: 'कम्प्युटर आर्किटेक्चर, नेटवर्किङ, OS, DBMS (100M)',
                  ),
                ],
              ),
            ),
          ),

          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Paper 1 & Paper 2 Buttons Row
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Paper 1 Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: onOpenPaper1,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFEF2F2),
                      foregroundColor: const Color(0xFFDC2626),
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      side: const BorderSide(color: Color(0xFFFECACA), width: 1.2),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.description, size: 15, color: Color(0xFFDC2626)),
                        SizedBox(width: 6),
                        Text(
                          'Paper 1',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Paper 2 Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: onOpenPaper2,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF0FDF4),
                      foregroundColor: const Color(0xFF15803D),
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      side: const BorderSide(color: Color(0xFFBBF7D0), width: 1.2),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.terminal_rounded, size: 15, color: Color(0xFF15803D)),
                        SizedBox(width: 6),
                        Text(
                          'Paper 2',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaperSummaryLine({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String desc,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 14, color: iconColor),
        const SizedBox(width: 6),
        Text(
          title,
          style: const TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            desc,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Color(0xFF475569),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PAPER VIEW & MARKDOWN MODEL ANSWER FORMATTING
// ─────────────────────────────────────────────────────────────────────────────

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
  const _PaperView({super.key, required this.paper});

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
