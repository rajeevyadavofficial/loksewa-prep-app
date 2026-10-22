// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/models.dart';
import '../../data/repositories/providers.dart';

// ─────────────────────────────────────────────────────────────────────────────
// STUDY NOTES TAB — Authentic Black & White Lok Sewa Textbook Reader
// Complete Table of Contents (विषय-सूची) & Detailed Chapter-wise Study Materials
// ─────────────────────────────────────────────────────────────────────────────

class StudyNotesTab extends StatefulWidget {
  final VoidCallback onGoToExams;
  const StudyNotesTab({super.key, required this.onGoToExams});

  @override
  State<StudyNotesTab> createState() => _StudyNotesTabState();
}

class _StudyNotesTabState extends State<StudyNotesTab> {
  final TextEditingController _searchController = TextEditingController();
  double _contentFontSize = 15.0;
  bool _showTocSidebar = true;
  String _activePaperTab = 'paper1'; // 'paper1' or 'paper2'

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final prov = context.read<StudyNotesProvider>();
      if (prov.activeNote == null && prov.allNotes.isNotEmpty) {
        // Automatically open the first chapter of Paper 1
        final first = prov.allNotes.firstWhere(
          (n) => n.paper == 'paper1',
          orElse: () => prov.allNotes.first,
        );
        prov.setActiveNote(first);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _printChapter() {
    if (kIsWeb) {
      try {
        html.window.print();
      } catch (_) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    final notesProv = context.watch<StudyNotesProvider>();
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 840;

    // Filter notes for the Table of Contents based on paper tab and search
    final paperNotes = notesProv.allNotes.where((n) {
      if (n.paper != _activePaperTab) return false;
      if (_searchController.text.trim().isNotEmpty) {
        final q = _searchController.text.toLowerCase().trim();
        final combined = '${n.title} ${n.titleNepali} ${n.topic} ${n.chapterTitle} ${n.summary} ${n.content}'.toLowerCase();
        return combined.contains(q);
      }
      return true;
    }).toList();

    // Group notes by Unit Number for the Table of Contents
    final Map<int, List<StudyNote>> groupedByUnit = {};
    for (final note in paperNotes) {
      groupedByUnit.putIfAbsent(note.unitNumber, () => []).add(note);
    }

    final activeNote = notesProv.activeNote ?? (paperNotes.isNotEmpty ? paperNotes.first : null);

    return Container(
      color: const Color(0xFFF3F4F6), // Neutral book desk surface
      child: Column(
        children: [
          // ─── BOOK HEADER BAR (Pure Black & White) ──────────────────────
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 12 : 24,
              vertical: isMobile ? 8 : 12,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.black, width: 1.2)),
            ),
            child: Row(
              children: [
                // Toggle TOC Button
                OutlinedButton.icon(
                  onPressed: () {
                    if (isMobile) {
                      _openMobileTocDrawer(context, notesProv, groupedByUnit);
                    } else {
                      setState(() => _showTocSidebar = !_showTocSidebar);
                    }
                  },
                  icon: Icon(
                    _showTocSidebar && !isMobile ? Icons.menu_open : Icons.list_alt,
                    size: 16,
                    color: Colors.black,
                  ),
                  label: Text(
                    isMobile
                        ? 'विषय-सूची'
                        : (_showTocSidebar ? 'विषय-सूची लुकाउनुहोस्' : 'विषय-सूची (Table of Contents)'),
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black, width: 1.0),
                    padding: EdgeInsets.symmetric(horizontal: isMobile ? 10 : 14, vertical: 8),
                  ),
                ),

                const SizedBox(width: 14),

                // Textbook Title Banner
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'राष्ट्रिय वाणिज्य बैंक लिमिटेड — वरिष्ठ सहायक (सूचना प्रविधि) तह ५',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: isMobile ? 13 : 15.5,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          letterSpacing: -0.2,
                        ),
                      ),
                      Text(
                        'पाठ्यक्रममा आधारित सम्पूर्ण अध्ययन सामग्री (Textbook Study Guide)',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: isMobile ? 10.5 : 12,
                          color: const Color(0xFF4B5563),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                // Text Size Controls
                IconButton(
                  tooltip: 'अक्षर सानो बनाउनुहोस् (A-)',
                  icon: const Icon(Icons.text_decrease, size: 18, color: Colors.black),
                  onPressed: _contentFontSize > 12.5
                      ? () => setState(() => _contentFontSize -= 1.0)
                      : null,
                ),
                IconButton(
                  tooltip: 'अक्षर ठूलो बनाउनुहोस् (A+)',
                  icon: const Icon(Icons.text_increase, size: 18, color: Colors.black),
                  onPressed: _contentFontSize < 22.0
                      ? () => setState(() => _contentFontSize += 1.0)
                      : null,
                ),

                if (kIsWeb) ...[
                  const SizedBox(width: 4),
                  OutlinedButton.icon(
                    onPressed: _printChapter,
                    icon: const Icon(Icons.print_outlined, size: 16, color: Colors.black),
                    label: Text(isMobile ? 'Print' : 'प्रिन्ट गर्नुहोस् (Print)'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      side: const BorderSide(color: Colors.black, width: 1.0),
                      padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 12, vertical: 8),
                      textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ],
            ),
          ),

          // ─── BOOK SPLIT WORKSPACE: TOC (Left) + CHAPTER PAGE (Right) ─────
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Table of Contents Sidebar (Desktop)
                if (_showTocSidebar && !isMobile)
                  Container(
                    width: 320,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(right: BorderSide(color: Color(0xFFD1D5DB), width: 1.0)),
                    ),
                    child: _buildTocWidget(context, notesProv, groupedByUnit, isDrawer: false),
                  ),

                // Main Reading Page Area
                Expanded(
                  child: activeNote == null
                      ? const Center(
                          child: Text(
                            'कृपया विषय-सूचीबाट कुनै अध्याय छान्नुहोस्।',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        )
                      : _buildBookPage(context, notesProv, activeNote),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────────────────────────────────────────────────────────────
  // TABLE OF CONTENTS (विषय-सूची)
  // ───────────────────────────────────────────────────────────────────────────
  Widget _buildTocWidget(
    BuildContext context,
    StudyNotesProvider prov,
    Map<int, List<StudyNote>> groupedByUnit, {
    required bool isDrawer,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // TOC Top Section Header
        Container(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
          decoration: const BoxDecoration(
            color: Color(0xFFF9FAFB),
            border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'विषय-सूची (Table of Contents)',
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 10),

              // Paper 1 / Paper 2 Switcher Tabs
              Row(
                children: [
                  Expanded(
                    child: _buildPaperTabPill(
                      label: 'प्रथम पत्र\n(बैंकिङ्ग)',
                      isSelected: _activePaperTab == 'paper1',
                      onTap: () {
                        setState(() => _activePaperTab = 'paper1');
                        final first = prov.allNotes.firstWhere(
                          (n) => n.paper == 'paper1',
                          orElse: () => prov.allNotes.first,
                        );
                        prov.setActiveNote(first);
                      },
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: _buildPaperTabPill(
                      label: 'द्वितीय पत्र\n(सूचना प्रविधि)',
                      isSelected: _activePaperTab == 'paper2',
                      onTap: () {
                        setState(() => _activePaperTab = 'paper2');
                        final first = prov.allNotes.firstWhere(
                          (n) => n.paper == 'paper2',
                          orElse: () => prov.allNotes.first,
                        );
                        prov.setActiveNote(first);
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Search in Book Field
              SizedBox(
                height: 36,
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Search in topics...',
                    hintStyle: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                    prefixIcon: const Icon(Icons.search, size: 15, color: Colors.black87),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 14),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {});
                            },
                          )
                        : null,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Color(0xFF9CA3AF)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Color(0xFF9CA3AF)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Colors.black, width: 1.5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // List of Units & Chapters
        Expanded(
          child: groupedByUnit.isEmpty
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'कुनै पाठ फेला परेन।',
                      style: TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: groupedByUnit.keys.length,
                  itemBuilder: (context, idx) {
                    final unitNum = groupedByUnit.keys.elementAt(idx);
                    final unitNotes = groupedByUnit[unitNum]!;
                    final unitTitle = unitNotes.first.unitTitle;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Unit Header Accordion Bar
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          color: const Color(0xFFF3F4F6),
                          child: Text(
                            unitTitle,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),
                          ),
                        ),

                        // List of Topics in this Unit
                        ...unitNotes.map((note) {
                          final isSelected = prov.activeNote?.id == note.id;

                          return InkWell(
                            onTap: () {
                              prov.setActiveNote(note);
                              if (isDrawer) Navigator.of(context).pop();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.black : Colors.transparent,
                                border: const Border(
                                  bottom: BorderSide(color: Color(0xFFF3F4F6), width: 1.0),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isSelected ? '▶ ' : '• ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900,
                                      color: isSelected ? Colors.white : Colors.black87,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          note.chapterTitle,
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w700,
                                            color: isSelected ? const Color(0xFFD1D5DB) : const Color(0xFF4B5563),
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          note.title,
                                          style: TextStyle(
                                            fontSize: 12.5,
                                            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                                            color: isSelected ? Colors.white : Colors.black,
                                            height: 1.3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildPaperTabPill({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.black, width: 1.2),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: isSelected ? Colors.white : Colors.black,
            height: 1.2,
          ),
        ),
      ),
    );
  }

  void _openMobileTocDrawer(
    BuildContext context,
    StudyNotesProvider prov,
    Map<int, List<StudyNote>> groupedByUnit,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.85,
          child: _buildTocWidget(context, prov, groupedByUnit, isDrawer: true),
        );
      },
    );
  }

  // ───────────────────────────────────────────────────────────────────────────
  // TEXTBOOK PAGE (Right Reading Area — Full Black & White)
  // ───────────────────────────────────────────────────────────────────────────
  Widget _buildBookPage(BuildContext context, StudyNotesProvider prov, StudyNote note) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 840;

    final currentNotesList = prov.allNotes.where((n) => n.paper == note.paper).toList();
    final currentIndex = currentNotesList.indexWhere((n) => n.id == note.id);
    final hasPrev = currentIndex > 0;
    final hasNext = currentIndex >= 0 && currentIndex < currentNotesList.length - 1;

    return SelectionArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 8 : 24,
          vertical: isMobile ? 12 : 24,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 860),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 46,
                vertical: isMobile ? 24 : 44,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFFCBD5E1), width: 1.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Book Running Head
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        note.paper == 'paper1'
                            ? 'प्रथम पत्र — बैंकिङ्ग तथा व्यवस्थापन'
                            : 'द्वितीय पत्र — सूचना प्रविधि तथा व्यवस्थापन',
                        style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF4B5563),
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        'एकाइ ${note.unitNumber}',
                        style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.black, thickness: 1.2, height: 16),

                  const SizedBox(height: 10),

                  // Chapter & Topic Tag
                  Text(
                    '${note.unitTitle} • ${note.chapterTitle}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF374151),
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Main Heading (English)
                  Text(
                    note.title,
                    style: TextStyle(
                      fontFamily: 'serif',
                      fontSize: isMobile ? 20 : 25,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                      height: 1.25,
                    ),
                  ),

                  // Nepali Title
                  if (note.titleNepali.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      note.titleNepali,
                      style: TextStyle(
                        fontFamily: 'serif',
                        fontSize: isMobile ? 15 : 18,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF1F2937),
                        height: 1.35,
                      ),
                    ),
                  ],

                  const SizedBox(height: 18),

                  // Quick Overview Callout Box (Black and White Book Box)
                  if (note.summary.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF9FAFB),
                        border: Border(
                          left: BorderSide(color: Colors.black, width: 3.5),
                          top: BorderSide(color: Color(0xFFE5E7EB), width: 1.0),
                          bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1.0),
                          right: BorderSide(color: Color(0xFFE5E7EB), width: 1.0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'विषय प्रवेश तथा सार-संक्षेप (Chapter Overview):',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            note.summary,
                            style: TextStyle(
                              fontFamily: 'serif',
                              fontSize: _contentFontSize - 1.5,
                              height: 1.5,
                              color: const Color(0xFF1F2937),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 24),
                  const Divider(color: Color(0xFFE5E7EB), thickness: 1.0),
                  const SizedBox(height: 12),

                  // Main Detailed Content (Black & White Textbook Renderer)
                  _BlackAndWhiteContentRenderer(
                    markdownText: note.content,
                    baseFontSize: _contentFontSize,
                  ),

                  const SizedBox(height: 32),

                  // Key Revision Points Box (Black & White)
                  if (note.keyPoints.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 1.2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'परीक्षा दृष्टिकोणका मुख्य बुँदाहरू (Summary of Key Revision Points):',
                            style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ...note.keyPoints.map((kp) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '■  ',
                                    style: TextStyle(fontSize: 9, color: Colors.black, height: 1.8),
                                  ),
                                  Expanded(
                                    child: Text(
                                      kp,
                                      style: TextStyle(
                                        fontFamily: 'serif',
                                        fontSize: _contentFontSize - 1.5,
                                        height: 1.45,
                                        color: const Color(0xFF111827),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),

                  const SizedBox(height: 36),
                  const Divider(color: Colors.black, thickness: 1.0),
                  const SizedBox(height: 12),

                  // Bottom Chapter-to-Chapter Stepper
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (hasPrev)
                        OutlinedButton.icon(
                          onPressed: () => prov.setActiveNote(currentNotesList[currentIndex - 1]),
                          icon: const Icon(Icons.arrow_back, size: 15, color: Colors.black),
                          label: const Text(
                            '← अघिल्लो पाठ (Previous)',
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.black, width: 1.0),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          ),
                        )
                      else
                        const SizedBox.shrink(),

                      if (hasNext)
                        ElevatedButton.icon(
                          onPressed: () => prov.setActiveNote(currentNotesList[currentIndex + 1]),
                          icon: const Icon(Icons.arrow_forward, size: 15, color: Colors.white),
                          label: const Text(
                            'अर्को पाठ (Next) →',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          ),
                        )
                      else
                        const SizedBox.shrink(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// BLACK & WHITE TEXTBOOK CONTENT & TABLE RENDERER
// ─────────────────────────────────────────────────────────────────────────────
class _BlackAndWhiteContentRenderer extends StatelessWidget {
  final String markdownText;
  final double baseFontSize;

  const _BlackAndWhiteContentRenderer({
    required this.markdownText,
    required this.baseFontSize,
  });

  @override
  Widget build(BuildContext context) {
    final lines = markdownText.trim().split('\n');
    final widgets = <Widget>[];

    int i = 0;
    while (i < lines.length) {
      final line = lines[i].trim();

      if (line.isEmpty) {
        widgets.add(const SizedBox(height: 8));
        i++;
        continue;
      }

      // Check for Markdown Table (starts with |)
      if (line.startsWith('|') && line.endsWith('|')) {
        final tableLines = <String>[];
        while (i < lines.length && lines[i].trim().startsWith('|') && lines[i].trim().endsWith('|')) {
          tableLines.add(lines[i].trim());
          i++;
        }
        widgets.add(_buildBookTable(tableLines));
        continue;
      }

      // Heading 3: ###
      if (line.startsWith('### ')) {
        final h = line.substring(4).trim();
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(top: 22, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  h,
                  style: TextStyle(
                    fontFamily: 'serif',
                    fontSize: baseFontSize + 2.5,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 4),
                const Divider(color: Colors.black, thickness: 0.8, height: 1),
              ],
            ),
          ),
        );
        i++;
        continue;
      }

      // Heading 4: ####
      if (line.startsWith('#### ')) {
        final h = line.substring(5).trim();
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(top: 14, bottom: 6),
            child: Text(
              h,
              style: TextStyle(
                fontFamily: 'serif',
                fontSize: baseFontSize + 1.2,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF111827),
              ),
            ),
          ),
        );
        i++;
        continue;
      }

      // Blockquote / Formula / Callout: >
      if (line.startsWith('>')) {
        final quoteLines = <String>[];
        while (i < lines.length && lines[i].trim().startsWith('>')) {
          quoteLines.add(lines[i].trim().replaceAll(RegExp(r'^>\s*'), ''));
          i++;
        }
        widgets.add(
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFFF9FAFB),
              border: Border(
                left: BorderSide(color: Colors.black, width: 3.5),
                top: BorderSide(color: Color(0xFFE5E7EB)),
                bottom: BorderSide(color: Color(0xFFE5E7EB)),
                right: BorderSide(color: Color(0xFFE5E7EB)),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: quoteLines.map((q) => Text(q, style: TextStyle(fontFamily: 'serif', fontSize: baseFontSize - 1.0, fontWeight: FontWeight.w600, color: Colors.black))).toList(),
            ),
          ),
        );
        continue;
      }

      // Divider: ---
      if (line == '---') {
        widgets.add(const Divider(height: 24, color: Color(0xFFD1D5DB)));
        i++;
        continue;
      }

      // Bullet points: - or *
      if (line.startsWith('- ') || line.startsWith('* ')) {
        final body = line.substring(2).trim();
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('•  ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900)),
                Expanded(child: _richText(body, baseFontSize)),
              ],
            ),
          ),
        );
        i++;
        continue;
      }

      // Numbered items: 1. or 2)
      final numMatch = RegExp(r'^(\d+[\.\)])\s*(.*)$').firstMatch(line);
      if (numMatch != null) {
        final numPrefix = numMatch.group(1)!;
        final body = numMatch.group(2)!;
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$numPrefix ', style: TextStyle(fontFamily: 'serif', fontWeight: FontWeight.w800, fontSize: baseFontSize, color: Colors.black)),
                Expanded(child: _richText(body, baseFontSize)),
              ],
            ),
          ),
        );
        i++;
        continue;
      }

      // Standard Paragraph
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: _richText(line, baseFontSize),
        ),
      );
      i++;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: widgets,
    );
  }

  Widget _buildBookTable(List<String> tableLines) {
    if (tableLines.length < 2) return const SizedBox.shrink();

    final headerRow = tableLines[0].split('|').map((c) => c.trim()).where((c) => c.isNotEmpty).toList();
    final bodyRows = <List<String>>[];

    for (int r = 1; r < tableLines.length; r++) {
      final line = tableLines[r];
      if (line.contains('---')) continue;
      final cols = line.split('|').map((c) => c.trim()).where((c) => c.isNotEmpty).toList();
      if (cols.isNotEmpty) bodyRows.add(cols);
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.0),
      ),
      child: Table(
        border: TableBorder.all(color: const Color(0xFFD1D5DB), width: 0.8),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          // Header Row (Clean Black & White)
          TableRow(
            decoration: const BoxDecoration(color: Color(0xFFF3F4F6)),
            children: headerRow.map((h) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Text(
                  h.replaceAll('**', ''),
                  style: TextStyle(
                    fontFamily: 'serif',
                    fontSize: baseFontSize - 1.5,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
              );
            }).toList(),
          ),
          // Data Rows
          ...bodyRows.map((row) {
            return TableRow(
              decoration: const BoxDecoration(color: Colors.white),
              children: row.map((cell) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  child: _richText(cell, baseFontSize - 2.0),
                );
              }).toList(),
            );
          }),
        ],
      ),
    );
  }

  Widget _richText(String raw, double fontSize) {
    final spans = <TextSpan>[];
    final regex = RegExp(r'(\*\*\*([^\*]+?)\*\*\*|\*\*([^\*]+?)\*\*|\*([^\*]+?)\*|`([^`]+?)`)');
    int lastEnd = 0;
    final base = TextStyle(
      fontFamily: 'serif',
      fontSize: fontSize,
      color: const Color(0xFF1F2937),
      height: 1.6,
      fontWeight: FontWeight.w500,
    );

    for (final match in regex.allMatches(raw)) {
      if (match.start > lastEnd) {
        final plain = raw.substring(lastEnd, match.start);
        if (plain.isNotEmpty) spans.add(TextSpan(text: plain));
      }
      final b2 = match.group(3); // **bold**
      final b1 = match.group(4); // *italic*
      final code = match.group(5); // `code`
      if (b2 != null && b2.isNotEmpty) {
        spans.add(TextSpan(text: b2, style: base.copyWith(fontWeight: FontWeight.w900, color: Colors.black)));
      } else if (b1 != null && b1.isNotEmpty) {
        spans.add(TextSpan(text: b1, style: base.copyWith(fontStyle: FontStyle.italic)));
      } else if (code != null && code.isNotEmpty) {
        spans.add(TextSpan(
          text: code,
          style: base.copyWith(
            fontFamily: 'monospace',
            backgroundColor: const Color(0xFFF3F4F6),
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ));
      }
      lastEnd = match.end;
    }

    if (lastEnd < raw.length) {
      spans.add(TextSpan(text: raw.substring(lastEnd)));
    }

    if (spans.isEmpty) return Text(raw, style: base);
    return Text.rich(TextSpan(style: base, children: spans));
  }
}
