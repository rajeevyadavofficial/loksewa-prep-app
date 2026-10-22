// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../data/models/models.dart';
import '../../data/repositories/providers.dart';

// ─────────────────────────────────────────────────────────────────────────────
// STUDY NOTES TAB — Syllabus-Aligned Chapter & Topic Wise Notes (Paper 1 & 2)
// Data loaded dynamically from Database (Node.js/MongoDB with local asset fallback)
// ─────────────────────────────────────────────────────────────────────────────

class StudyNotesTab extends StatefulWidget {
  final VoidCallback onGoToExams;
  const StudyNotesTab({super.key, required this.onGoToExams});

  @override
  State<StudyNotesTab> createState() => _StudyNotesTabState();
}

class _StudyNotesTabState extends State<StudyNotesTab> {
  final TextEditingController _searchController = TextEditingController();
  double _contentFontSize = 14.5;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _printNote() {
    if (kIsWeb) {
      try {
        html.window.print();
      } catch (_) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    final notesProv = context.watch<StudyNotesProvider>();
    final activeNote = notesProv.activeNote;

    return Container(
      color: const Color(0xFFF8FAFC),
      child: activeNote != null
          ? _buildReaderView(context, notesProv, activeNote)
          : _buildCatalogView(context, notesProv),
    );
  }

  // ───────────────────────────────────────────────────────────────────────────
  // CATALOG / LIST VIEW
  // ───────────────────────────────────────────────────────────────────────────
  Widget _buildCatalogView(BuildContext context, StudyNotesProvider prov) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 768;
    final notes = prov.notes;

    return CustomScrollView(
      slivers: [
        // Top Banner
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 32,
              vertical: isMobile ? 18 : 24,
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
                              colors: [Color(0xFF0369A1), Color(0xFF0284C7)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF0284C7).withOpacity(0.25),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.auto_stories_rounded, color: Colors.white, size: 24),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'राष्ट्रिय वाणिज्य बैंक (RBB) IT Level 5 — पाठ्यक्रममा आधारित अध्ययन नोटहरू',
                                style: TextStyle(
                                  fontSize: isMobile ? 15.5 : 20,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF0F172A),
                                  letterSpacing: -0.2,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Detailed & Simple Language Notes for Paper 1 (Banking & Management) and Paper 2 (IT & Management) • Saved in Database',
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
                    const SizedBox(height: 14),
                    // Stats chips
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildStatChip(
                          icon: Icons.menu_book,
                          label: '${prov.allNotes.length} Comprehensive Notes',
                          color: const Color(0xFF0284C7),
                          bgColor: const Color(0xFFF0F9FF),
                        ),
                        _buildStatChip(
                          icon: Icons.account_balance,
                          label: 'Paper 1: 13 Banking Topics',
                          color: const Color(0xFFDC2626),
                          bgColor: const Color(0xFFFEF2F2),
                        ),
                        _buildStatChip(
                          icon: Icons.terminal,
                          label: 'Paper 2: 12 IT Topics',
                          color: const Color(0xFF16A34A),
                          bgColor: const Color(0xFFF0FDF4),
                        ),
                        _buildStatChip(
                          icon: Icons.cloud_done_outlined,
                          label: 'Cloud Database Connected',
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

        // Filter & Search Controls
        SliverToBoxAdapter(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 32,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Paper switcher pills
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildPaperFilterPill(
                          label: 'All Notes (${prov.allNotes.length})',
                          isSelected: prov.selectedPaper == 'all',
                          onTap: () => prov.setPaper('all'),
                        ),
                        _buildPaperFilterPill(
                          label: '🏛️ Paper 1: Banking & Management',
                          isSelected: prov.selectedPaper == 'paper1',
                          onTap: () => prov.setPaper('paper1'),
                        ),
                        _buildPaperFilterPill(
                          label: '💻 Paper 2: IT & Management',
                          isSelected: prov.selectedPaper == 'paper2',
                          onTap: () => prov.setPaper('paper2'),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Unit Filter & Search Bar Row
                    Row(
                      children: [
                        // Unit Dropdown / Selector
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFCBD5E1)),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<int?>(
                              value: prov.selectedUnit,
                              hint: const Text('All Units (१–६)', style: TextStyle(fontSize: 12.5)),
                              icon: const Icon(Icons.arrow_drop_down, size: 20),
                              isDense: true,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF0F172A),
                              ),
                              onChanged: (u) => prov.setUnit(u),
                              items: [
                                const DropdownMenuItem<int?>(
                                  value: null,
                                  child: Text('All Units (सबै एकाइ)'),
                                ),
                                ...[1, 2, 3, 4, 5, 6].map((u) {
                                  return DropdownMenuItem<int?>(
                                    value: u,
                                    child: Text('Unit $u (एकाइ $u)'),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        // Search Field
                        Expanded(
                          child: SizedBox(
                            height: 38,
                            child: TextField(
                              controller: _searchController,
                              onChanged: (val) => prov.setSearch(val),
                              decoration: InputDecoration(
                                hintText: 'Search notes (e.g. CRR, BAFIA, DRP, Normalization)...',
                                hintStyle: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                                prefixIcon: const Icon(Icons.search, size: 16, color: Color(0xFF64748B)),
                                suffixIcon: _searchController.text.isNotEmpty
                                    ? IconButton(
                                        icon: const Icon(Icons.clear, size: 16),
                                        onPressed: () {
                                          _searchController.clear();
                                          prov.setSearch('');
                                        },
                                      )
                                    : null,
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
                                  borderSide: const BorderSide(color: Color(0xFF0284C7), width: 1.5),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Notes List / Empty State
        if (prov.loading)
          const SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(strokeWidth: 2.5),
                  SizedBox(height: 12),
                  Text('Loading syllabus study notes from database...', style: TextStyle(color: Color(0xFF64748B))),
                ],
              ),
            ),
          )
        else if (notes.isEmpty)
          SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.search_off, size: 48, color: Color(0xFF94A3B8)),
                  const SizedBox(height: 12),
                  const Text(
                    'No study notes found matching your filter',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF334155)),
                  ),
                  const SizedBox(height: 6),
                  TextButton(
                    onPressed: () {
                      _searchController.clear();
                      prov.setPaper('all');
                      prov.setUnit(null);
                      prov.setSearch('');
                    },
                    child: const Text('Reset Filters (सबै फिल्टर हटाउनुहोस्)'),
                  ),
                ],
              ),
            ),
          )
        else
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
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: notes.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 14),
                    itemBuilder: (context, idx) {
                      final note = notes[idx];
                      return _NoteCard(
                        note: note,
                        isBookmarked: prov.isBookmarked(note.id),
                        onToggleBookmark: () => prov.toggleBookmark(note.id),
                        onOpen: () => prov.setActiveNote(note),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildStatChip({
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

  Widget _buildPaperFilterPill({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0F172A) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFF0F172A) : const Color(0xFFCBD5E1),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF334155),
          ),
        ),
      ),
    );
  }

  // ───────────────────────────────────────────────────────────────────────────
  // READER VIEW
  // ───────────────────────────────────────────────────────────────────────────
  Widget _buildReaderView(BuildContext context, StudyNotesProvider prov, StudyNote note) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 768;
    final isBookmarked = prov.isBookmarked(note.id);

    final currentIndex = prov.allNotes.indexWhere((n) => n.id == note.id);
    final hasPrev = currentIndex > 0;
    final hasNext = currentIndex >= 0 && currentIndex < prov.allNotes.length - 1;

    return Column(
      children: [
        // Reader Top Toolbar
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 12 : 24,
            vertical: isMobile ? 8 : 12,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1)),
          ),
          child: Row(
            children: [
              OutlinedButton.icon(
                onPressed: () => prov.setActiveNote(null),
                icon: const Icon(Icons.arrow_back, size: 16),
                label: Text(isMobile ? 'Notes' : 'All Notes (सबै नोटहरू)'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF0F172A),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 10 : 14, vertical: 8),
                  textStyle: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700),
                ),
              ),

              const SizedBox(width: 8),

              // Prev / Next Note
              if (!isMobile) ...[
                IconButton(
                  tooltip: 'Previous Note',
                  onPressed: hasPrev ? () => prov.setActiveNote(prov.allNotes[currentIndex - 1]) : null,
                  icon: const Icon(Icons.chevron_left, size: 22),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                ),
                IconButton(
                  tooltip: 'Next Note',
                  onPressed: hasNext ? () => prov.setActiveNote(prov.allNotes[currentIndex + 1]) : null,
                  icon: const Icon(Icons.chevron_right, size: 22),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                ),
                const SizedBox(width: 8),
              ],

              const Spacer(),

              // Text size adjusters
              IconButton(
                tooltip: 'Decrease text size',
                icon: const Icon(Icons.text_decrease, size: 18),
                onPressed: _contentFontSize > 12
                    ? () => setState(() => _contentFontSize -= 1.0)
                    : null,
              ),
              IconButton(
                tooltip: 'Increase text size',
                icon: const Icon(Icons.text_increase, size: 18),
                onPressed: _contentFontSize < 20
                    ? () => setState(() => _contentFontSize += 1.0)
                    : null,
              ),

              const SizedBox(width: 4),

              // Bookmark Button
              IconButton(
                tooltip: isBookmarked ? 'Remove Bookmark' : 'Bookmark this Note',
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: isBookmarked ? const Color(0xFFDC2626) : const Color(0xFF64748B),
                  size: 20,
                ),
                onPressed: () => prov.toggleBookmark(note.id),
              ),

              // Copy Note Text
              IconButton(
                tooltip: 'Copy Note to Clipboard',
                icon: const Icon(Icons.copy, size: 18, color: Color(0xFF64748B)),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: '${note.title}\n\n${note.content}'));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Note content copied to clipboard!')),
                  );
                },
              ),

              if (kIsWeb)
                OutlinedButton.icon(
                  onPressed: _printNote,
                  icon: const Icon(Icons.print_outlined, size: 16),
                  label: Text(isMobile ? 'Print' : 'Print Note'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF334155),
                    side: const BorderSide(color: Color(0xFFCBD5E1)),
                    padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 12, vertical: 8),
                    textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
            ],
          ),
        ),

        // Note Body Container
        Expanded(
          child: SelectionArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 12 : 32,
                vertical: isMobile ? 16 : 28,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 860),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 16 : 36,
                      vertical: isMobile ? 20 : 36,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 12,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Note Header Badges
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: note.paper == 'paper1'
                                    ? const Color(0xFFFEF2F2)
                                    : const Color(0xFFF0FDF4),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: note.paper == 'paper1'
                                      ? const Color(0xFFFECACA)
                                      : const Color(0xFFBBF7D0),
                                ),
                              ),
                              child: Text(
                                note.paper == 'paper1' ? 'Paper 1 (Banking)' : 'Paper 2 (IT Technical)',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: note.paper == 'paper1'
                                      ? const Color(0xFF991B1B)
                                      : const Color(0xFF15803D),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'Unit ${note.unitNumber}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF475569),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.timer_outlined, size: 14, color: Color(0xFF64748B)),
                                const SizedBox(width: 4),
                                Text(
                                  '${note.readTimeMinutes} min read',
                                  style: const TextStyle(
                                    fontSize: 11.5,
                                    color: Color(0xFF64748B),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // Main Title (English & Nepali)
                        Text(
                          note.title,
                          style: TextStyle(
                            fontSize: isMobile ? 18 : 22,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF0F172A),
                            height: 1.3,
                          ),
                        ),
                        if (note.titleNepali.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            note.titleNepali,
                            style: TextStyle(
                              fontSize: isMobile ? 14.5 : 16.5,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF475569),
                              height: 1.35,
                            ),
                          ),
                        ],

                        const SizedBox(height: 8),

                        Text(
                          '${note.unitTitle} • ${note.chapterTitle}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0284C7),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Quick Summary Callout Box
                        if (note.summary.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0F9FF),
                              borderRadius: BorderRadius.circular(8),
                              border: const Border(
                                left: BorderSide(color: Color(0xFF0284C7), width: 3.5),
                                top: BorderSide(color: Color(0xFFBAE6FD)),
                                bottom: BorderSide(color: Color(0xFFBAE6FD)),
                                right: BorderSide(color: Color(0xFFBAE6FD)),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Icon(Icons.lightbulb_outline, size: 16, color: Color(0xFF0284C7)),
                                    SizedBox(width: 6),
                                    Text(
                                      'संक्षिप्त परिचय (Quick Summary)',
                                      style: TextStyle(
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF0369A1),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  note.summary,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    height: 1.5,
                                    color: Color(0xFF0C4A6E),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        const SizedBox(height: 20),
                        const Divider(color: Color(0xFFE2E8F0)),
                        const SizedBox(height: 10),

                        // Rich Note Content
                        _NoteContentRenderer(
                          markdownText: note.content,
                          baseFontSize: _contentFontSize,
                        ),

                        const SizedBox(height: 28),

                        // Key Takeaways Box
                        if (note.keyPoints.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFAF5FF),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: const Color(0xFFE9D5FF), width: 1.2),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Icon(Icons.star_rounded, size: 18, color: Color(0xFF9333EA)),
                                    SizedBox(width: 8),
                                    Text(
                                      'मुख्य बुँदाहरू (Key Takeaways / Quick Revision)',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF6B21A8),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                ...note.keyPoints.map((kp) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 6),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('✓  ', style: TextStyle(color: Color(0xFF9333EA), fontWeight: FontWeight.w800)),
                                        Expanded(
                                          child: Text(
                                            kp,
                                            style: const TextStyle(
                                              fontSize: 13,
                                              height: 1.45,
                                              color: Color(0xFF3B0764),
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

                        const SizedBox(height: 32),

                        // Bottom Navigation Between Notes
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (hasPrev)
                              OutlinedButton.icon(
                                onPressed: () => prov.setActiveNote(prov.allNotes[currentIndex - 1]),
                                icon: const Icon(Icons.arrow_back, size: 15),
                                label: const Text('Previous Note'),
                              )
                            else
                              const SizedBox.shrink(),
                            if (hasNext)
                              ElevatedButton.icon(
                                onPressed: () => prov.setActiveNote(prov.allNotes[currentIndex + 1]),
                                icon: const Icon(Icons.arrow_forward, size: 15),
                                label: const Text('Next Note'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF0F172A),
                                  foregroundColor: Colors.white,
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
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// NOTE CARD COMPONENT (Catalog item)
// ─────────────────────────────────────────────────────────────────────────────
class _NoteCard extends StatelessWidget {
  final StudyNote note;
  final bool isBookmarked;
  final VoidCallback onToggleBookmark;
  final VoidCallback onOpen;

  const _NoteCard({
    required this.note,
    required this.isBookmarked,
    required this.onToggleBookmark,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    final isPaper1 = note.paper == 'paper1';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onOpen,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top tags row
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: isPaper1 ? const Color(0xFFFEF2F2) : const Color(0xFFF0FDF4),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: isPaper1 ? const Color(0xFFFECACA) : const Color(0xFFBBF7D0),
                      ),
                    ),
                    child: Text(
                      isPaper1 ? 'Paper 1 (Banking)' : 'Paper 2 (IT Technical)',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: isPaper1 ? const Color(0xFF991B1B) : const Color(0xFF15803D),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Unit ${note.unitNumber} • ${note.chapterTitle}',
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF64748B),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      size: 18,
                      color: isBookmarked ? const Color(0xFFDC2626) : const Color(0xFF94A3B8),
                    ),
                    onPressed: onToggleBookmark,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Title
              Text(
                note.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                  height: 1.3,
                ),
              ),
              if (note.titleNepali.isNotEmpty) ...[
                const SizedBox(height: 3),
                Text(
                  note.titleNepali,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF475569),
                  ),
                ),
              ],

              const SizedBox(height: 10),

              // Summary
              if (note.summary.isNotEmpty)
                Text(
                  note.summary,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: Color(0xFF334155),
                    height: 1.45,
                  ),
                ),

              const SizedBox(height: 12),

              // Bottom action row
              Row(
                children: [
                  const Icon(Icons.timer_outlined, size: 14, color: Color(0xFF64748B)),
                  const SizedBox(width: 4),
                  Text(
                    '${note.readTimeMinutes} min read',
                    style: const TextStyle(fontSize: 11.5, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  Text(
                    'Read Full Note (विस्तृत अध्ययन) →',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                      color: isPaper1 ? const Color(0xFFDC2626) : const Color(0xFF0284C7),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// NOTE CONTENT MARKDOWN & TABLE RENDERER
// ─────────────────────────────────────────────────────────────────────────────
class _NoteContentRenderer extends StatelessWidget {
  final String markdownText;
  final double baseFontSize;

  const _NoteContentRenderer({
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
        widgets.add(_buildTableWidget(tableLines));
        continue;
      }

      // Heading 3: ###
      if (line.startsWith('### ')) {
        final h = line.substring(4).trim();
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(top: 18, bottom: 6),
            child: Text(
              h,
              style: TextStyle(
                fontSize: baseFontSize + 3.0,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF0F172A),
                letterSpacing: -0.2,
              ),
            ),
          ),
        );
        i++;
        continue;
      }

      // Heading 4 or bold subhead: ####
      if (line.startsWith('#### ')) {
        final h = line.substring(5).trim();
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 4),
            child: Text(
              h,
              style: TextStyle(
                fontSize: baseFontSize + 1.5,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF1E293B),
              ),
            ),
          ),
        );
        i++;
        continue;
      }

      // Blockquote: >
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
            decoration: BoxDecoration(
              color: const Color(0xFFFEF3C7),
              borderRadius: BorderRadius.circular(6),
              border: const Border(
                left: BorderSide(color: Color(0xFFD97706), width: 4),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: quoteLines.map((q) => Text(q, style: TextStyle(fontSize: baseFontSize, fontWeight: FontWeight.w600, color: const Color(0xFF78350F)))).toList(),
            ),
          ),
        );
        continue;
      }

      // Divider: ---
      if (line == '---') {
        widgets.add(const Divider(height: 24, color: Color(0xFFE2E8F0)));
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
                const Text('•  ', style: TextStyle(color: Color(0xFF0284C7), fontWeight: FontWeight.w900)),
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
                Text('$numPrefix ', style: TextStyle(fontWeight: FontWeight.w800, fontSize: baseFontSize, color: const Color(0xFF0F172A))),
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

  Widget _buildTableWidget(List<String> tableLines) {
    if (tableLines.length < 2) return const SizedBox.shrink();

    final headerRow = tableLines[0].split('|').map((c) => c.trim()).where((c) => c.isNotEmpty).toList();
    final bodyRows = <List<String>>[];

    for (int r = 1; r < tableLines.length; r++) {
      final line = tableLines[r];
      if (line.contains('---')) continue; // Skip separator line
      final cols = line.split('|').map((c) => c.trim()).where((c) => c.isNotEmpty).toList();
      if (cols.isNotEmpty) bodyRows.add(cols);
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFCBD5E1), width: 1.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Table(
        border: TableBorder.all(color: const Color(0xFFE2E8F0), width: 0.8),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          // Header Row
          TableRow(
            decoration: const BoxDecoration(color: Color(0xFFF1F5F9)),
            children: headerRow.map((h) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Text(
                  h.replaceAll('**', ''),
                  style: TextStyle(
                    fontSize: baseFontSize - 1.0,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF0F172A),
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
                  child: _richText(cell, baseFontSize - 1.5),
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
      fontSize: fontSize,
      color: const Color(0xFF1E293B),
      height: 1.55,
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
        spans.add(TextSpan(text: b2, style: base.copyWith(fontWeight: FontWeight.w800, color: const Color(0xFF0F172A))));
      } else if (b1 != null && b1.isNotEmpty) {
        spans.add(TextSpan(text: b1, style: base.copyWith(fontStyle: FontStyle.italic)));
      } else if (code != null && code.isNotEmpty) {
        spans.add(TextSpan(
          text: code,
          style: base.copyWith(
            fontFamily: 'monospace',
            backgroundColor: const Color(0xFFF1F5F9),
            fontWeight: FontWeight.w700,
            color: const Color(0xFFDC2626),
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
