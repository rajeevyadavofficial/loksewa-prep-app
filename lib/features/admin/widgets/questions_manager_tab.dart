import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../data/models/models.dart';
import '../../../../data/repositories/providers.dart';
import 'question_edit_dialog.dart';

class QuestionsManagerTab extends StatefulWidget {
  final VoidCallback onAddQuestion;

  const QuestionsManagerTab({super.key, required this.onAddQuestion});

  @override
  State<QuestionsManagerTab> createState() => _QuestionsManagerTabState();
}

class _QuestionsManagerTabState extends State<QuestionsManagerTab> {
  final _searchCtrl = TextEditingController();
  String _selectedExamFilter = 'all';
  String _selectedTypeFilter = 'all';
  String _selectedPaperFilter = 'all';
  int _currentPage = 1;
  int _pageSize = 25;

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<Question> _getFilteredQuestions(List<Question> all) {
    return all.where((q) {
      if (_selectedExamFilter != 'all' && q.examId != _selectedExamFilter) {
        return false;
      }
      if (_selectedTypeFilter == 'mcq' && q.type != QuestionType.mcq) return false;
      if (_selectedTypeFilter == 'subjective' && q.type != QuestionType.subjective) return false;
      if (_selectedPaperFilter == 'paper1' && q.paper != PaperType.paper1) return false;
      if (_selectedPaperFilter == 'paper2' && q.paper != PaperType.paper2) return false;

      final query = _searchCtrl.text.trim().toLowerCase();
      if (query.isNotEmpty) {
        final inEn = q.questionEnglish.toLowerCase().contains(query);
        final inNp = q.questionNepali.toLowerCase().contains(query);
        final inUnit = q.unitTitle.toLowerCase().contains(query);
        final inId = q.id.toLowerCase().contains(query);
        if (!inEn && !inNp && !inUnit && !inId) return false;
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final qp = context.watch<QuestionProvider>();
    final token = context.read<AuthProvider>().adminToken ?? '';
    final isMobile = MediaQuery.of(context).size.width < 750;

    final filtered = _getFilteredQuestions(qp.allQuestions);
    final totalCount = filtered.length;
    final totalPages = (totalCount / _pageSize).ceil().clamp(1, 9999);
    final actualPage = _currentPage.clamp(1, totalPages);

    final startIndex = (actualPage - 1) * _pageSize;
    final endIndex = (startIndex + _pageSize).clamp(0, totalCount);
    final pageItems = totalCount > 0 ? filtered.sublist(startIndex, endIndex) : <Question>[];

    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 14 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row with Add Question button
          Wrap(
            spacing: 12,
            runSpacing: 10,
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question Bank Master ($totalCount Questions)',
                    style: TextStyle(fontSize: isMobile ? 18 : 21, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    'Search, filter, view, edit or delete questions across all Lok Sewa exams in MongoDB Atlas.',
                    style: TextStyle(color: AppTheme.textMuted, fontSize: 13),
                  ),
                ],
              ),
              FilledButton.icon(
                onPressed: () => QuestionEditDialog.show(context),
                icon: const Icon(Icons.add_rounded, size: 17, color: Colors.white),
                label: const Text('Add New Question'),
                style: FilledButton.styleFrom(backgroundColor: AppTheme.iconRed, foregroundColor: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Search and Filters Bar
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.divider),
            ),
            child: Column(
              children: [
                TextField(
                  controller: _searchCtrl,
                  decoration: InputDecoration(
                    hintText: 'Search questions by keywords, unit title, Nepali or English text...',
                    prefixIcon: const Icon(Icons.search_rounded, size: 20),
                    suffixIcon: _searchCtrl.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded, size: 18),
                            onPressed: () {
                              setState(() {
                                _searchCtrl.clear();
                                _currentPage = 1;
                              });
                            },
                          )
                        : null,
                  ),
                  onChanged: (_) => setState(() => _currentPage = 1),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    // Exam filter
                    DropdownButton<String>(
                      value: qp.exams.any((e) => e.id == _selectedExamFilter) || _selectedExamFilter == 'all'
                          ? _selectedExamFilter
                          : 'all',
                      items: [
                        const DropdownMenuItem(value: 'all', child: Text('All Lok Sewa Exams')),
                        ...qp.exams.map((e) => DropdownMenuItem(value: e.id, child: Text(e.title))),
                      ],
                      onChanged: (v) {
                        if (v != null) {
                          setState(() {
                            _selectedExamFilter = v;
                            _currentPage = 1;
                          });
                        }
                      },
                    ),

                    // Type filter
                    DropdownButton<String>(
                      value: _selectedTypeFilter,
                      items: const [
                        DropdownMenuItem(value: 'all', child: Text('All Formats (MCQ & Subjective)')),
                        DropdownMenuItem(value: 'subjective', child: Text('Subjective Only')),
                        DropdownMenuItem(value: 'mcq', child: Text('MCQ Only')),
                      ],
                      onChanged: (v) {
                        if (v != null) {
                          setState(() {
                            _selectedTypeFilter = v;
                            _currentPage = 1;
                          });
                        }
                      },
                    ),

                    // Paper filter
                    DropdownButton<String>(
                      value: _selectedPaperFilter,
                      items: const [
                        DropdownMenuItem(value: 'all', child: Text('Paper I & Paper II')),
                        DropdownMenuItem(value: 'paper1', child: Text('Paper I')),
                        DropdownMenuItem(value: 'paper2', child: Text('Paper II')),
                      ],
                      onChanged: (v) {
                        if (v != null) {
                          setState(() {
                            _selectedPaperFilter = v;
                            _currentPage = 1;
                          });
                        }
                      },
                    ),

                    // Page size
                    DropdownButton<int>(
                      value: _pageSize,
                      items: const [
                        DropdownMenuItem(value: 15, child: Text('15 / page')),
                        DropdownMenuItem(value: 25, child: Text('25 / page')),
                        DropdownMenuItem(value: 50, child: Text('50 / page')),
                        DropdownMenuItem(value: 100, child: Text('100 / page')),
                      ],
                      onChanged: (v) {
                        if (v != null) {
                          setState(() {
                            _pageSize = v;
                            _currentPage = 1;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Question Items List / Cards
          if (pageItems.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.divider),
              ),
              child: const Column(
                children: [
                  Icon(Icons.search_off_rounded, size: 40, color: AppTheme.textMuted),
                  SizedBox(height: 10),
                  Text('No questions matched your search criteria.', style: TextStyle(fontWeight: FontWeight.w700)),
                ],
              ),
            )
          else
            ...pageItems.map((q) => _buildQuestionCard(context, q, token)),

          const SizedBox(height: 20),

          // Pagination Controls
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.divider),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Showing ${totalCount == 0 ? 0 : startIndex + 1}–$endIndex of $totalCount',
                  style: const TextStyle(fontSize: 12.5, color: AppTheme.textMuted, fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left_rounded),
                      onPressed: actualPage > 1 ? () => setState(() => _currentPage--) : null,
                    ),
                    Text(
                      'Page $actualPage of $totalPages',
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right_rounded),
                      onPressed: actualPage < totalPages ? () => setState(() => _currentPage++) : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(BuildContext context, Question q, String token) {
    final isMcq = q.type == QuestionType.mcq;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isMcq ? AppTheme.bgSurface : AppTheme.iconRedLight,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: isMcq ? AppTheme.divider : AppTheme.iconRed.withOpacity(0.3)),
                ),
                child: Text(
                  isMcq ? 'MCQ 1M' : '${q.marks}M',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: isMcq ? AppTheme.textPrimary : AppTheme.iconRedDark,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      q.questionEnglish,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.textPrimary),
                    ),
                    if (q.questionNepali.isNotEmpty) ...[
                      const SizedBox(height: 3),
                      Text(
                        q.questionNepali,
                        style: const TextStyle(fontSize: 13, color: AppTheme.textBody),
                      ),
                    ],
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        Text('Exam: ${q.examId}', style: const TextStyle(fontSize: 11.5, color: AppTheme.textMuted)),
                        const Text('•', style: TextStyle(color: AppTheme.textMuted)),
                        Text('Unit ${q.unitNumber}: ${q.unitTitle}', style: const TextStyle(fontSize: 11.5, color: AppTheme.textMuted)),
                        const Text('•', style: TextStyle(color: AppTheme.textMuted)),
                        Text(q.paper == PaperType.paper1 ? 'Paper I' : 'Paper II', style: const TextStyle(fontSize: 11.5, color: AppTheme.textMuted)),
                        const Text('•', style: TextStyle(color: AppTheme.textMuted)),
                        Text(q.section == SectionType.sectionA ? 'Section A' : 'Section B', style: const TextStyle(fontSize: 11.5, color: AppTheme.textMuted)),
                        if (q.isPremium) ...[
                          const Text('•', style: TextStyle(color: AppTheme.textMuted)),
                          const Text('🔒 Pro Only', style: TextStyle(fontSize: 11.5, color: AppTheme.iconRed, fontWeight: FontWeight.w700)),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit_note_rounded, size: 20, color: AppTheme.primaryColor),
                    tooltip: 'Edit Question',
                    onPressed: () => QuestionEditDialog.show(context, question: q),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline_rounded, size: 19, color: AppTheme.iconRed),
                    tooltip: 'Delete Question',
                    onPressed: () async {
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          backgroundColor: Colors.white,
                          title: const Text('Delete Question?'),
                          content: Text('Are you sure you want to permanently delete "${q.id}"?'),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                            FilledButton(
                              style: FilledButton.styleFrom(backgroundColor: AppTheme.iconRed),
                              onPressed: () => Navigator.pop(ctx, true),
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );
                      if (confirmed == true && context.mounted) {
                        final ok = await context.read<QuestionProvider>().deleteQuestionFromMongo(q.id, token);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(ok ? 'Question deleted' : 'Failed to delete question')),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
