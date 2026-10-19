import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../data/repositories/providers.dart';
import 'exam_edit_dialog.dart';
import 'question_edit_dialog.dart';

class ExamsManagerTab extends StatelessWidget {
  final VoidCallback onAddExam;

  const ExamsManagerTab({super.key, required this.onAddExam});

  @override
  Widget build(BuildContext context) {
    final qp = context.watch<QuestionProvider>();
    final token = context.read<AuthProvider>().adminToken ?? '';
    final isMobile = MediaQuery.of(context).size.width < 750;

    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 14 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                    'Lok Sewa Exam Courses (${qp.exams.length})',
                    style: TextStyle(fontSize: isMobile ? 18 : 21, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    'Create, edit syllabus, and toggle active status (Live vs. Coming Soon) for all government exams.',
                    style: TextStyle(color: AppTheme.textMuted, fontSize: 13),
                  ),
                ],
              ),
              FilledButton.icon(
                onPressed: () => ExamEditDialog.show(context),
                icon: const Icon(Icons.add_rounded, size: 17, color: Colors.white),
                label: const Text('Add Lok Sewa Exam'),
                style: FilledButton.styleFrom(backgroundColor: AppTheme.iconRed, foregroundColor: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 20),

          ...qp.exams.map((exam) {
            final qCount = qp.countForExam(exam.id);
            final isComingSoon = exam.isComingSoon;

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isComingSoon ? AppTheme.divider : AppTheme.primaryColor,
                  width: isComingSoon ? 1.0 : 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isComingSoon ? AppTheme.bgSurface : AppTheme.iconRedLight,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: isComingSoon ? AppTheme.divider : AppTheme.iconRed.withOpacity(0.2)),
                        ),
                        child: Icon(
                          isComingSoon ? Icons.lock_clock_outlined : Icons.school_rounded,
                          color: isComingSoon ? AppTheme.textMuted : AppTheme.iconRed,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                  exam.title,
                                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: AppTheme.textPrimary),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: isComingSoon ? AppTheme.bgSurface : AppTheme.iconRedLight,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: isComingSoon ? AppTheme.divider : AppTheme.iconRed.withOpacity(0.3),
                                    ),
                                  ),
                                  child: Text(
                                    isComingSoon ? 'COMING SOON (LOCKED)' : 'LIVE & ACTIVE',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                      color: isComingSoon ? AppTheme.textMuted : AppTheme.iconRed,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppTheme.bgSurface,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    exam.category,
                                    style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: AppTheme.textMuted),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 3),
                            Text(
                              exam.titleNepali,
                              style: const TextStyle(fontSize: 13, color: AppTheme.textBody),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'ID: ${exam.id} • ${exam.organization} • ${exam.level} • $qCount Published Questions',
                              style: const TextStyle(fontSize: 11.5, color: AppTheme.textMuted),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.end,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      OutlinedButton.icon(
                        icon: const Icon(Icons.post_add_rounded, size: 15),
                        label: const Text('Add Question to Exam', style: TextStyle(fontSize: 12)),
                        onPressed: () => QuestionEditDialog.show(context, defaultExamId: exam.id),
                      ),
                      OutlinedButton.icon(
                        icon: const Icon(Icons.edit_note_rounded, size: 16),
                        label: const Text('Edit Course / Syllabus', style: TextStyle(fontSize: 12)),
                        onPressed: () => ExamEditDialog.show(context, exam: exam),
                      ),
                      OutlinedButton.icon(
                        onPressed: () async {
                          final newStatus = !isComingSoon;
                          final ok = await qp.toggleExamComingSoon(exam.id, newStatus, token);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(ok
                                    ? '${exam.title} is now ${newStatus ? "COMING SOON" : "LIVE"}!'
                                    : 'Failed to update exam status'),
                                backgroundColor: ok ? AppTheme.primaryColor : AppTheme.iconRed,
                              ),
                            );
                          }
                        },
                        icon: Icon(
                          isComingSoon ? Icons.rocket_launch_outlined : Icons.lock_outline_rounded,
                          size: 15,
                          color: isComingSoon ? AppTheme.iconRed : AppTheme.textPrimary,
                        ),
                        label: Text(
                          isComingSoon ? 'Make Live' : 'Set Coming Soon',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: isComingSoon ? AppTheme.iconRed : AppTheme.textPrimary,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline_rounded, size: 18, color: AppTheme.iconRed),
                        tooltip: 'Delete Exam',
                        onPressed: () async {
                          final confirmed = await showDialog<bool>(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              backgroundColor: Colors.white,
                              title: const Text('Delete Exam Course?'),
                              content: Text('Are you sure you want to delete "${exam.title}"? Questions linked to this exam will remain.'),
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
                            final ok = await qp.deleteExamFromMongo(exam.id, token);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(ok ? 'Exam deleted' : 'Failed to delete exam')),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
