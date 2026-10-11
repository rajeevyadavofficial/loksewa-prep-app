import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';
import '../../data/models/models.dart';
import '../../data/repositories/providers.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});
  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _tab = 0;
  bool _loadingStats = false;
  bool _statsFetchedOnce = false;
  Map<String, dynamic>? _liveStats;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuestionProvider>().loadAll();
      _fetchAdminStats();
    });
  }

  Future<void> _fetchAdminStats() async {
    final token = context.read<AuthProvider>().token;
    if (token == null || token.isEmpty) {
      if (mounted) setState(() => _loadingStats = false);
      return;
    }
    setState(() {
      _loadingStats = true;
      _statsFetchedOnce = true;
    });
    try {
      final res = await http.get(
        Uri.parse('${AppConstants.apiBaseUrl}/admin/stats'),
        headers: {'Authorization': 'Bearer $token'},
      ).timeout(const Duration(seconds: 15));
      if (res.statusCode == 200 && mounted) {
        setState(() {
          _liveStats = jsonDecode(res.body) as Map<String, dynamic>;
          _loadingStats = false;
        });
        return;
      }
    } catch (_) {}
    if (mounted) {
      setState(() {
        _liveStats ??= {};
        _loadingStats = false;
      });
    }
  }

  Future<Map<String, dynamic>?> _promptExpiryDuration(String title) async {
    int selectedDays = 30;
    DateTime? customDate;
    final daysCtrl = TextEditingController(text: '30');

    return showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) {
          final previewDate = customDate ?? DateTime.now().add(Duration(days: selectedDays));
          final previewStr = previewDate.toLocal().toString().split(' ').first;
          return AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            title: Row(
              children: [
                const Icon(Icons.timer_outlined, color: AppTheme.iconRed, size: 22),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(title, style: const TextStyle(fontSize: 16.5, fontWeight: FontWeight.w800)),
                ),
              ],
            ),
            content: SizedBox(
              width: 460,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select how long the Pro Plan (रू 199) should remain active before expiring:',
                    style: TextStyle(fontSize: 13, color: AppTheme.textMuted),
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      (7, '7 Days'),
                      (15, '15 Days'),
                      (30, '30 Days (1 Mo)'),
                      (90, '90 Days (3 Mo)'),
                      (180, '180 Days (6 Mo)'),
                      (365, '365 Days (1 Yr)'),
                    ].map((preset) {
                      final isSelected = customDate == null && selectedDays == preset.$1;
                      return ChoiceChip(
                        label: Text(preset.$2),
                        selected: isSelected,
                        selectedColor: AppTheme.iconRedLight,
                        labelStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: isSelected ? AppTheme.iconRedDark : AppTheme.textPrimary,
                        ),
                        onSelected: (_) {
                          setDialogState(() {
                            customDate = null;
                            selectedDays = preset.$1;
                            daysCtrl.text = '${preset.$1}';
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: daysCtrl,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Custom Duration (Days)',
                            suffixText: 'days',
                          ),
                          onChanged: (v) {
                            final parsed = int.tryParse(v.trim());
                            if (parsed != null && parsed > 0) {
                              setDialogState(() {
                                customDate = null;
                                selectedDays = parsed;
                              });
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton.icon(
                        icon: const Icon(Icons.calendar_today_outlined, size: 15, color: AppTheme.iconRed),
                        label: const Text('Pick Exact Date', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: ctx,
                            initialDate: previewDate,
                            firstDate: DateTime.now().add(const Duration(days: 1)),
                            lastDate: DateTime.now().add(const Duration(days: 3650)),
                          );
                          if (picked != null) {
                            setDialogState(() {
                              customDate = DateTime(picked.year, picked.month, picked.day, 23, 59, 59);
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppTheme.bgSurface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.divider),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.event_available_rounded, size: 16, color: AppTheme.iconRed),
                        const SizedBox(width: 8),
                        Text(
                          'Plan will expire on: $previewStr',
                          style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, null),
                child: const Text('Cancel', style: TextStyle(color: AppTheme.textMuted)),
              ),
              FilledButton.icon(
                style: FilledButton.styleFrom(backgroundColor: AppTheme.iconRed, foregroundColor: Colors.white),
                icon: const Icon(Icons.check_circle_outline_rounded, size: 16, color: Colors.white),
                label: Text('Activate Until $previewStr'),
                onPressed: () {
                  Navigator.pop(ctx, {
                    'durationDays': selectedDays,
                    'expiresAt': previewDate.toIso8601String(),
                  });
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _updateUserPlan(String userId, String newPlan) async {
    final token = context.read<AuthProvider>().token;
    if (token == null) return;

    Map<String, dynamic>? expiryConfig;
    if (newPlan != 'free') {
      expiryConfig = await _promptExpiryDuration('Set Pro Plan Expiry Time');
      if (expiryConfig == null || !mounted) return;
    }

    try {
      final res = await http.put(
        Uri.parse('${AppConstants.apiBaseUrl}/admin/users/$userId/plan'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'plan': newPlan,
          if (expiryConfig != null) ...expiryConfig,
        }),
      );
      if (res.statusCode == 200 && mounted) {
        final label = newPlan == 'free' ? 'FREE' : 'PRO (रू 199)';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User plan updated to $label in MongoDB Atlas!'),
            backgroundColor: AppTheme.primaryColor,
          ),
        );
        _fetchAdminStats();
      }
    } catch (_) {}
  }

  Future<void> _verifyPayment(String paymentId, String action) async {
    final token = context.read<AuthProvider>().token;
    if (token == null) return;

    Map<String, dynamic>? expiryConfig;
    if (action == 'approve') {
      expiryConfig = await _promptExpiryDuration('Verify Payment & Set Plan Expiry');
      if (expiryConfig == null || !mounted) return;
    }

    try {
      final res = await http.put(
        Uri.parse('${AppConstants.apiBaseUrl}/admin/payments/$paymentId/verify'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'action': action,
          if (expiryConfig != null) ...expiryConfig,
        }),
      );
      if (res.statusCode == 200 && mounted) {
        final data = jsonDecode(res.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              data['message']?.toString() ??
                  (action == 'approve'
                      ? 'Payment verified & candidate Pro plan activated!'
                      : 'Payment request rejected.'),
            ),
            backgroundColor: action == 'approve' ? AppTheme.primaryColor : AppTheme.iconRed,
          ),
        );
        _fetchAdminStats();
      }
    } catch (_) {}
  }

  Future<void> _deleteUser(String userId, String userName) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: const Text('Delete Candidate Account?'),
        content: Text(
          'Are you sure you want to permanently delete "$userName"? This action cannot be undone.',
          style: const TextStyle(color: AppTheme.textBody, fontSize: 13.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel', style: TextStyle(color: AppTheme.textMuted)),
          ),
          FilledButton.icon(
            onPressed: () => Navigator.pop(ctx, true),
            icon: const Icon(Icons.delete_outline_rounded, size: 16, color: Colors.white),
            label: const Text('Delete User'),
            style: FilledButton.styleFrom(backgroundColor: AppTheme.iconRed, foregroundColor: Colors.white),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    final token = context.read<AuthProvider>().token;
    if (token == null) return;
    try {
      final res = await http.delete(
        Uri.parse('${AppConstants.apiBaseUrl}/admin/users/$userId'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (!mounted) return;
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Deleted user "$userName" successfully.'),
            backgroundColor: AppTheme.primaryColor,
          ),
        );
        _fetchAdminStats();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['error']?.toString() ?? 'Failed to delete user'),
            backgroundColor: AppTheme.iconRed,
          ),
        );
      }
    } catch (_) {}
  }

  // ─── Modal: Add New Lok Sewa Exam Course ────────────────────
  void _showAddExamDialog() {
    final idCtrl = TextEditingController(text: 'psc_custom_${DateTime.now().millisecondsSinceEpoch % 1000}');
    final titleCtrl = TextEditingController();
    final titleNpCtrl = TextEditingController();
    final orgCtrl = TextEditingController(text: 'Public Service Commission (Lok Sewa Aayog)');
    final levelCtrl = TextEditingController(text: 'Level 5 / Non-Gazetted 1st Class');
    final descCtrl = TextEditingController();
    final schemeCtrl = TextEditingController(
      text: 'Paper I: GK & IQ Objective (100 Marks)\nPaper II: Service Related Subjective (100 Marks)',
    );
    final topicsCtrl = TextEditingController(
      text: 'Unit 1: Constitution of Nepal & Governance\nUnit 2: Office Management & Public Administration\nUnit 3: Service Specific Laws & Acts',
    );
    String category = 'Civil Service';
    bool isComingSoon = true;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          title: const Text('Add New Lok Sewa Exam / Post'),
          content: SizedBox(
            width: 560,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: idCtrl,
                          decoration: const InputDecoration(labelText: 'Unique Exam ID (e.g. nbl_l4)'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: category,
                          decoration: const InputDecoration(labelText: 'Category'),
                          items: const [
                            DropdownMenuItem(value: 'Civil Service', child: Text('Civil Service (निजामती)')),
                            DropdownMenuItem(value: 'Banking', child: Text('Banking (बैंकिङ)')),
                            DropdownMenuItem(value: 'IT & Technical', child: Text('IT & Technical (प्राविधिक)')),
                            DropdownMenuItem(value: 'Sansthan', child: Text('Sansthan (संस्थान)')),
                          ],
                          onChanged: (v) => setDialogState(() => category = v!),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: titleCtrl,
                    decoration: const InputDecoration(labelText: 'Exam / Post Title (English) *'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: titleNpCtrl,
                    decoration: const InputDecoration(labelText: 'Exam / Post Title (Nepali — नेपाली नाम) *'),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: orgCtrl,
                          decoration: const InputDecoration(labelText: 'Conducting Organization'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: levelCtrl,
                          decoration: const InputDecoration(labelText: 'Post Level / Class'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: descCtrl,
                    decoration: const InputDecoration(labelText: 'Short Course Description'),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: schemeCtrl,
                    decoration: const InputDecoration(labelText: 'Exam Scheme (1 line per paper/stage)'),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: topicsCtrl,
                    decoration: const InputDecoration(labelText: 'Core Syllabus Topics (1 line per unit)'),
                    maxLines: 4,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: AppTheme.bgSurface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.divider),
                    ),
                    child: SwitchListTile(
                      title: const Text(
                        'Mark as "Coming Soon" (Not Clickable for Candidates)',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppTheme.textPrimary),
                      ),
                      subtitle: Text(
                        isComingSoon
                            ? 'Exam will display a COMING SOON badge and remain locked.'
                            : 'Exam will be LIVE and immediately clickable by candidates.',
                        style: const TextStyle(fontSize: 11.5, color: AppTheme.textMuted),
                      ),
                      activeColor: AppTheme.iconRed,
                      value: isComingSoon,
                      onChanged: (v) => setDialogState(() => isComingSoon = v),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel', style: TextStyle(color: AppTheme.textMuted))),
            FilledButton.icon(
              icon: const Icon(Icons.cloud_upload_outlined, size: 18, color: Colors.white),
              label: const Text('Save Exam to MongoDB'),
              style: FilledButton.styleFrom(backgroundColor: AppTheme.iconRed, foregroundColor: Colors.white),
              onPressed: () async {
                final token = context.read<AuthProvider>().token ?? '';
                final schemeList = schemeCtrl.text
                    .split('\n')
                    .map((s) => s.trim())
                    .where((s) => s.isNotEmpty)
                    .toList();
                final topicList = topicsCtrl.text
                    .split('\n')
                    .map((s) => s.trim())
                    .where((s) => s.isNotEmpty)
                    .toList();

                final ok = await context.read<QuestionProvider>().addExamToMongo({
                  'id': idCtrl.text.trim(),
                  'title': titleCtrl.text.trim(),
                  'title_nepali': titleNpCtrl.text.trim().isEmpty ? titleCtrl.text.trim() : titleNpCtrl.text.trim(),
                  'category': category,
                  'organization': orgCtrl.text.trim(),
                  'level': levelCtrl.text.trim(),
                  'description': descCtrl.text.trim(),
                  'is_coming_soon': isComingSoon,
                  'exam_scheme': schemeList,
                  'syllabus_sections': [
                    {
                      'title': 'Official Curriculum & Core Units',
                      'topics': topicList,
                    }
                  ],
                }, token);

                if (mounted) {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(ok ? 'New Exam saved to MongoDB Atlas!' : 'Failed to save exam'),
                      backgroundColor: ok ? AppTheme.primaryColor : AppTheme.iconRed,
                    ),
                  );
                  _fetchAdminStats();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // ─── Modal: Add New Question to Any Exam ────────────────────
  void _showAddQuestionDialog() {
    final qp = context.read<QuestionProvider>();
    final exams = qp.exams;
    String selectedExamId = qp.selectedExamId == 'all'
        ? (exams.isNotEmpty ? exams.first.id : 'rbb_it_5')
        : qp.selectedExamId;

    final idCtrl = TextEditingController(text: 'q_${DateTime.now().millisecondsSinceEpoch % 10000}');
    final unitTitleCtrl = TextEditingController(text: 'Unit 1: Core Syllabus Topic');
    final yearCtrl = TextEditingController(text: '2082 BS');
    final qNpCtrl = TextEditingController();
    final qEnCtrl = TextEditingController();
    final ansNpCtrl = TextEditingController();
    final ansEnCtrl = TextEditingController();
    final optACtrl = TextEditingController();
    final optBCtrl = TextEditingController();
    final optCCtrl = TextEditingController();
    final optDCtrl = TextEditingController();
    final expCtrl = TextEditingController();

    String qType = 'subjective';
    String paper = 'paper1';
    String section = 'sectionA';
    int unitNum = 1;
    int marks = 5;
    int correctIdx = 0;
    bool isPremium = true;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          title: const Text('Add Question to Exam (MongoDB Atlas)'),
          content: SizedBox(
            width: 580,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    value: exams.any((e) => e.id == selectedExamId) ? selectedExamId : (exams.isNotEmpty ? exams.first.id : 'rbb_it_5'),
                    decoration: const InputDecoration(labelText: 'Select Target Lok Sewa Exam *'),
                    items: exams
                        .map((e) => DropdownMenuItem(value: e.id, child: Text('${e.title} (${e.category})')))
                        .toList(),
                    onChanged: (v) => setDialogState(() => selectedExamId = v!),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: qType,
                          decoration: const InputDecoration(labelText: 'Question Type'),
                          items: const [
                            DropdownMenuItem(value: 'subjective', child: Text('Subjective (Written Q&A)')),
                            DropdownMenuItem(value: 'mcq', child: Text('Objective MCQ (4 Options)')),
                          ],
                          onChanged: (v) => setDialogState(() {
                            qType = v!;
                            marks = qType == 'mcq' ? 1 : 5;
                          }),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: paper,
                          decoration: const InputDecoration(labelText: 'Paper'),
                          items: const [
                            DropdownMenuItem(value: 'paper1', child: Text('Paper I')),
                            DropdownMenuItem(value: 'paper2', child: Text('Paper II')),
                          ],
                          onChanged: (v) => setDialogState(() => paper = v!),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          value: unitNum,
                          decoration: const InputDecoration(labelText: 'Unit No.'),
                          items: [1, 2, 3, 4, 5, 6]
                              .map((u) => DropdownMenuItem(value: u, child: Text('Unit $u')))
                              .toList(),
                          onChanged: (v) => setDialogState(() => unitNum = v!),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          value: marks,
                          decoration: const InputDecoration(labelText: 'Marks'),
                          items: const [
                            DropdownMenuItem(value: 1, child: Text('1 Mark (MCQ)')),
                            DropdownMenuItem(value: 2, child: Text('2 Marks (MCQ)')),
                            DropdownMenuItem(value: 5, child: Text('5 Marks (Short)')),
                            DropdownMenuItem(value: 10, child: Text('10 Marks (Long)')),
                          ],
                          onChanged: (v) => setDialogState(() => marks = v!),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: yearCtrl,
                          decoration: const InputDecoration(labelText: 'Year Asked'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: unitTitleCtrl,
                    decoration: const InputDecoration(labelText: 'Unit / Topic Title'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: qNpCtrl,
                    decoration: const InputDecoration(labelText: 'Question in Nepali (नेपाली प्रश्न) *'),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: qEnCtrl,
                    decoration: const InputDecoration(labelText: 'Question in English *'),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 12),
                  if (qType == 'subjective') ...[
                    TextField(
                      controller: ansNpCtrl,
                      decoration: const InputDecoration(labelText: 'Model Answer (Nepali — लोकसेवा उत्तर)'),
                      maxLines: 4,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: ansEnCtrl,
                      decoration: const InputDecoration(labelText: 'Model Answer (English)'),
                      maxLines: 4,
                    ),
                  ] else ...[
                    TextField(controller: optACtrl, decoration: const InputDecoration(labelText: 'Option A')),
                    const SizedBox(height: 8),
                    TextField(controller: optBCtrl, decoration: const InputDecoration(labelText: 'Option B')),
                    const SizedBox(height: 8),
                    TextField(controller: optCCtrl, decoration: const InputDecoration(labelText: 'Option C')),
                    const SizedBox(height: 8),
                    TextField(controller: optDCtrl, decoration: const InputDecoration(labelText: 'Option D')),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<int>(
                      value: correctIdx,
                      decoration: const InputDecoration(labelText: 'Correct Option'),
                      items: const [
                        DropdownMenuItem(value: 0, child: Text('Option A')),
                        DropdownMenuItem(value: 1, child: Text('Option B')),
                        DropdownMenuItem(value: 2, child: Text('Option C')),
                        DropdownMenuItem(value: 3, child: Text('Option D')),
                      ],
                      onChanged: (v) => setDialogState(() => correctIdx = v!),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: expCtrl,
                      decoration: const InputDecoration(labelText: 'Answer Explanation'),
                      maxLines: 2,
                    ),
                  ],
                  const SizedBox(height: 8),
                  SwitchListTile(
                    activeColor: AppTheme.iconRed,
                    title: const Text('Require Paid Subscription (Basic/Premium)'),
                    value: isPremium,
                    onChanged: (v) => setDialogState(() => isPremium = v),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel', style: TextStyle(color: AppTheme.textMuted))),
            FilledButton.icon(
              icon: const Icon(Icons.save_outlined, size: 18, color: Colors.white),
              label: const Text('Save Question to MongoDB'),
              style: FilledButton.styleFrom(backgroundColor: AppTheme.iconRed, foregroundColor: Colors.white),
              onPressed: () async {
                final token = context.read<AuthProvider>().token ?? '';
                final payload = <String, dynamic>{
                  'id': idCtrl.text.trim(),
                  'exam_id': selectedExamId,
                  'paper': paper,
                  'section': section,
                  'unit_number': unitNum,
                  'unit_title': unitTitleCtrl.text.trim(),
                  'marks': marks,
                  'type': qType,
                  'years_asked': [yearCtrl.text.trim()],
                  'question_nepali': qNpCtrl.text.trim(),
                  'question_english': qEnCtrl.text.trim(),
                  'is_premium': isPremium,
                };
                if (qType == 'subjective') {
                  payload['answer_nepali'] = ansNpCtrl.text.trim();
                  payload['answer_english'] = ansEnCtrl.text.trim();
                } else {
                  payload['options'] = [
                    optACtrl.text.trim(),
                    optBCtrl.text.trim(),
                    optCCtrl.text.trim(),
                    optDCtrl.text.trim(),
                  ];
                  payload['correct_option_index'] = correctIdx;
                  payload['explanation'] = expCtrl.text.trim();
                }

                final ok = await context.read<QuestionProvider>().addQuestionToMongo(payload, token);
                if (mounted) {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(ok ? 'Question saved to MongoDB Atlas!' : 'Failed to save question'),
                      backgroundColor: ok ? AppTheme.primaryColor : AppTheme.iconRed,
                    ),
                  );
                  _fetchAdminStats();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    if (auth.initializing) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator(color: AppTheme.iconRed)),
      );
    }
    if (!(auth.user?.isAdmin ?? false)) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.lock_outline_rounded, size: 56, color: AppTheme.iconRed),
              const SizedBox(height: 16),
              const Text('Admin Access Required', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              const Text('Please sign in via the dedicated Admin Portal (/admin/adminlogin).', style: TextStyle(color: AppTheme.textMuted)),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () => GoRouter.of(context).go(AppConstants.routeAdminLogin),
                icon: const Icon(Icons.admin_panel_settings_outlined, size: 18, color: Colors.white),
                label: const Text('Go to Admin Login'),
                style: FilledButton.styleFrom(backgroundColor: AppTheme.iconRed, foregroundColor: Colors.white),
              ),
            ],
          ),
        ),
      );
    }

    if (!_statsFetchedOnce && !_loadingStats) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && !_statsFetchedOnce && !_loadingStats) {
          _fetchAdminStats();
        }
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('LoksewaHero Admin CMS — Multi-Exam & Question Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: AppTheme.iconRed),
            tooltip: 'Sync MongoDB Atlas',
            onPressed: () {
              context.read<QuestionProvider>().loadAll(forceRefresh: true);
              _fetchAdminStats();
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: OutlinedButton.icon(
              icon: const Icon(Icons.arrow_back_rounded, color: AppTheme.primaryColor, size: 17),
              label: const Text('Candidate View', style: TextStyle(color: AppTheme.textPrimary)),
              onPressed: () => GoRouter.of(context).go(AppConstants.routeDashboard),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppTheme.divider),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              ),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _tab,
            onDestinationSelected: (i) => setState(() => _tab = i),
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard_rounded), label: Text('Overview')),
              NavigationRailDestination(icon: Icon(Icons.library_books_outlined), selectedIcon: Icon(Icons.library_books_rounded), label: Text('Exams')),
              NavigationRailDestination(icon: Icon(Icons.quiz_outlined), selectedIcon: Icon(Icons.quiz_rounded), label: Text('Questions')),
              NavigationRailDestination(icon: Icon(Icons.people_outline), selectedIcon: Icon(Icons.people_rounded), label: Text('Users')),
              NavigationRailDestination(icon: Icon(Icons.qr_code_scanner_rounded), selectedIcon: Icon(Icons.qr_code_2_rounded), label: Text('QR & Contacts')),
            ],
          ),
          const VerticalDivider(width: 1, color: AppTheme.divider),
          Expanded(
            child: _loadingStats
                ? const Center(child: CircularProgressIndicator(color: AppTheme.iconRed))
                : IndexedStack(
                    index: _tab,
                    children: [
                      _AdminOverview(
                        stats: _liveStats,
                        onAddExam: _showAddExamDialog,
                        onAddQuestion: _showAddQuestionDialog,
                        onOpenQrSettings: () => setState(() => _tab = 4),
                        onVerifyPayment: _verifyPayment,
                      ),
                      _ExamsManagerPanel(onAddExam: _showAddExamDialog),
                      _QuestionsManagerPanel(onAddQuestion: _showAddQuestionDialog),
                      _UsersPanel(
                        stats: _liveStats,
                        onUpdatePlan: _updateUserPlan,
                        onVerifyPayment: _verifyPayment,
                        onDeleteUser: _deleteUser,
                      ),
                      const _PaymentQrSettingsPanel(),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

// ─── Tab 0: Overview ──────────────────────────────────────────
class _AdminOverview extends StatelessWidget {
  final Map<String, dynamic>? stats;
  final VoidCallback onAddExam;
  final VoidCallback onAddQuestion;
  final VoidCallback onOpenQrSettings;
  final void Function(String paymentId, String action) onVerifyPayment;

  const _AdminOverview({
    required this.stats,
    required this.onAddExam,
    required this.onAddQuestion,
    required this.onOpenQrSettings,
    required this.onVerifyPayment,
  });

  @override
  Widget build(BuildContext context) {
    final qp = context.watch<QuestionProvider>();
    final dbMode = stats?['databaseMode'] ?? 'MongoDB Atlas Cloud';
    final totalUsers = stats?['totalUsers'] ?? 1;
    final totalRev = stats?['totalRevenue'] ?? 0;
    final recentPayments = (stats?['recentPayments'] as List<dynamic>?) ?? [];
    final pendingPayments = (stats?['pendingPayments'] as List<dynamic>?) ??
        recentPayments.where((p) => p['status'] == 'pending').toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.divider),
            ),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.cloud_done_outlined, color: AppTheme.iconRed, size: 20),
                    const SizedBox(width: 10),
                    Text(
                      'Database Status: $dbMode',
                      style: const TextStyle(fontWeight: FontWeight.w700, color: AppTheme.textPrimary, fontSize: 13.5),
                    ),
                  ],
                ),
                Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  children: [
                    OutlinedButton.icon(
                      onPressed: onOpenQrSettings,
                      icon: const Icon(Icons.qr_code_2_rounded, size: 16, color: AppTheme.iconRed),
                      label: const Text('Manage Payment & WhatsApp QR'),
                    ),
                    OutlinedButton.icon(
                      onPressed: onAddExam,
                      icon: const Icon(Icons.add_rounded, size: 16, color: AppTheme.primaryColor),
                      label: const Text('New Exam'),
                    ),
                    FilledButton.icon(
                      onPressed: onAddQuestion,
                      icon: const Icon(Icons.add_rounded, size: 16, color: Colors.white),
                      label: const Text('New Question'),
                      style: FilledButton.styleFrom(backgroundColor: AppTheme.iconRed, foregroundColor: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: MediaQuery.of(context).size.width > 800 ? 4 : 2,
            childAspectRatio: 1.65,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _AdminStatCard('Active Exams', '${qp.exams.length}', Icons.library_books_outlined, true),
              _AdminStatCard('Pending Verifications', '${pendingPayments.length}', Icons.pending_actions_rounded, true),
              _AdminStatCard('Registered Users', '$totalUsers', Icons.people_outline, false),
              _AdminStatCard('Verified Revenue', 'रू $totalRev', Icons.payments_outlined, false),
            ],
          ),
          const SizedBox(height: 24),
          // Pending Payment Verification Queue
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: pendingPayments.isNotEmpty ? AppTheme.iconRed : AppTheme.divider,
                width: pendingPayments.isNotEmpty ? 1.5 : 1.0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.verified_user_outlined, color: AppTheme.iconRed, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Pending WhatsApp Screenshot Verifications (${pendingPayments.length})',
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15.5, color: AppTheme.textPrimary),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Check your Official WhatsApp for the candidate\'s payment screenshot, then click "Verify & Activate Plan" to upgrade their account.',
                  style: TextStyle(fontSize: 12.5, color: AppTheme.textMuted),
                ),
                const Divider(height: 20, color: AppTheme.divider),
                if (pendingPayments.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'No pending payment verification requests right now.',
                      style: TextStyle(color: AppTheme.textMuted, fontSize: 13),
                    ),
                  )
                else
                  ...pendingPayments.map((p) {
                    final payId = p['_id']?.toString() ?? '';
                    final planName = (p['plan']?.toString() ?? 'basic').toUpperCase();
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppTheme.bgSurface,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppTheme.iconRed.withOpacity(0.35)),
                      ),
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 10,
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${p['userName']} (${p['userEmail']})',
                                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: AppTheme.textPrimary),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppTheme.iconRedLight,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      'REQUESTED: $planName (रू ${p['amount']})',
                                      style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w800, color: AppTheme.iconRedDark),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Method: ${p['method']?.toString().toUpperCase()} • Note/Ref: ${p['transactionRef']}',
                                style: const TextStyle(color: AppTheme.textMuted, fontSize: 12),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              OutlinedButton.icon(
                                onPressed: () => onVerifyPayment(payId, 'reject'),
                                icon: const Icon(Icons.close_rounded, size: 15, color: AppTheme.iconRed),
                                label: const Text('Reject', style: TextStyle(fontSize: 12, color: AppTheme.iconRed, fontWeight: FontWeight.w700)),
                              ),
                              const SizedBox(width: 8),
                              FilledButton.icon(
                                onPressed: () => onVerifyPayment(payId, 'approve'),
                                icon: const Icon(Icons.check_circle_outline_rounded, size: 16, color: Colors.white),
                                label: Text('Verify & Activate $planName', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                                style: FilledButton.styleFrom(
                                  backgroundColor: AppTheme.iconRed,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.divider),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'All Recent Payment History (MongoDB Atlas)',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: AppTheme.textPrimary),
                ),
                const Divider(height: 20, color: AppTheme.divider),
                if (recentPayments.isEmpty)
                  const Text('No payment records yet.', style: TextStyle(color: AppTheme.textMuted))
                else
                  ...recentPayments.map((p) {
                    final status = p['status']?.toString() ?? 'completed';
                    final isPending = status == 'pending';
                    final isRejected = status == 'rejected';
                    return ListTile(
                      leading: Icon(
                        isPending
                            ? Icons.hourglass_top_rounded
                            : isRejected
                                ? Icons.cancel_outlined
                                : Icons.verified_rounded,
                        color: isPending || isRejected ? AppTheme.iconRed : AppTheme.primaryColor,
                      ),
                      title: Text(
                        '${p['userName']} (${p['userEmail']}) — ${p['plan'].toString().toUpperCase()}',
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5),
                      ),
                      subtitle: Text(
                        'Method: ${p['method']} • Ref: ${p['transactionRef']} • Status: ${status.toUpperCase()}',
                        style: const TextStyle(color: AppTheme.textMuted, fontSize: 12),
                      ),
                      trailing: Text(
                        'रू ${p['amount']}',
                        style: const TextStyle(fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
                      ),
                      contentPadding: EdgeInsets.zero,
                    );
                  }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AdminStatCard extends StatelessWidget {
  final String label, value;
  final IconData icon;
  final bool isRed;
  const _AdminStatCard(this.label, this.value, this.icon, this.isRed);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isRed ? AppTheme.iconRed : AppTheme.primaryColor, size: 22),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppTheme.textPrimary)),
          Text(label, style: const TextStyle(color: AppTheme.textMuted, fontSize: 11.5)),
        ],
      ),
    );
  }
}

// ─── Tab 1: Manage Exams Panel ────────────────────────────────
class _ExamsManagerPanel extends StatelessWidget {
  final VoidCallback onAddExam;
  const _ExamsManagerPanel({required this.onAddExam});

  @override
  Widget build(BuildContext context) {
    final qp = context.watch<QuestionProvider>();
    final token = context.read<AuthProvider>().token ?? '';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Lok Sewa Exam Courses (${qp.exams.length})',
                style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
              ),
              const Spacer(),
              FilledButton.icon(
                onPressed: onAddExam,
                icon: const Icon(Icons.add_rounded, size: 18, color: Colors.white),
                label: const Text('Add New Lok Sewa Exam'),
                style: FilledButton.styleFrom(backgroundColor: AppTheme.iconRed, foregroundColor: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Add or manage Lok Sewa exams. Toggle any exam between "LIVE (Clickable)" and "COMING SOON (Locked for Candidates)".',
            style: TextStyle(color: AppTheme.textMuted, fontSize: 13),
          ),
          const SizedBox(height: 20),
          ...qp.exams.map((exam) {
            final qCount = qp.countForExam(exam.id);
            final isComingSoon = exam.isComingSoon;
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: isComingSoon ? AppTheme.bgSurface : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isComingSoon ? AppTheme.divider : AppTheme.primaryColor,
                  width: isComingSoon ? 1.0 : 1.5,
                ),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isComingSoon ? Colors.white : AppTheme.iconRedLight,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: isComingSoon ? AppTheme.divider : AppTheme.iconRed.withOpacity(0.25)),
                  ),
                  child: Icon(
                    isComingSoon ? Icons.lock_clock_outlined : Icons.library_books_outlined,
                    color: isComingSoon ? AppTheme.textMuted : AppTheme.iconRed,
                    size: 20,
                  ),
                ),
                title: Wrap(
                  spacing: 10,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      '${exam.title}  •  [${exam.category}]',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.5,
                        color: isComingSoon ? AppTheme.textBody : AppTheme.textPrimary,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: isComingSoon ? Colors.white : AppTheme.iconRedLight,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: isComingSoon ? AppTheme.divider : AppTheme.iconRed.withOpacity(0.35),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isComingSoon ? Icons.lock_outline_rounded : Icons.check_circle_rounded,
                            size: 12,
                            color: isComingSoon ? AppTheme.textMuted : AppTheme.iconRed,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            isComingSoon ? 'COMING SOON (LOCKED)' : 'LIVE & CLICKABLE',
                            style: TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w800,
                              color: isComingSoon ? AppTheme.textMuted : AppTheme.iconRed,
                              letterSpacing: 0.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(exam.titleNepali, style: const TextStyle(fontSize: 12.5, color: AppTheme.textBody)),
                      Text(
                        'ID: ${exam.id} • ${exam.organization} • ${exam.level} • $qCount Questions',
                        style: const TextStyle(fontSize: 11.5, color: AppTheme.textMuted),
                      ),
                    ],
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () async {
                        final newStatus = !isComingSoon;
                        final ok = await qp.toggleExamComingSoon(exam.id, newStatus, token);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                ok
                                    ? '${exam.title} is now ${newStatus ? "COMING SOON (Not Clickable)" : "LIVE (Clickable)"}!'
                                    : 'Failed to update exam status',
                              ),
                              backgroundColor: ok ? AppTheme.primaryColor : AppTheme.iconRed,
                            ),
                          );
                        }
                      },
                      icon: Icon(
                        isComingSoon ? Icons.rocket_launch_outlined : Icons.pause_circle_outline_rounded,
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
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        side: BorderSide(
                          color: isComingSoon ? AppTheme.iconRed : AppTheme.divider,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.delete_outline_rounded, color: AppTheme.iconRed),
                      tooltip: 'Delete Exam from MongoDB',
                      onPressed: () async {
                        final ok = await qp.deleteExamFromMongo(exam.id, token);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(ok ? 'Deleted exam ${exam.title}' : 'Failed to delete exam')),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ─── Tab 2: Manage Questions Panel ────────────────────────────
class _QuestionsManagerPanel extends StatelessWidget {
  final VoidCallback onAddQuestion;
  const _QuestionsManagerPanel({required this.onAddQuestion});

  @override
  Widget build(BuildContext context) {
    final qp = context.watch<QuestionProvider>();
    final token = context.read<AuthProvider>().token ?? '';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Question Bank (${qp.questions.length} shown)',
                style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
              ),
              const Spacer(),
              DropdownButton<String>(
                value: qp.exams.any((e) => e.id == qp.selectedExamId) || qp.selectedExamId == 'all'
                    ? qp.selectedExamId
                    : 'all',
                items: [
                  const DropdownMenuItem(value: 'all', child: Text('Filter: All Exams')),
                  ...qp.exams.map((e) => DropdownMenuItem(value: e.id, child: Text(e.title))),
                ],
                onChanged: (v) {
                  if (v != null) qp.selectExam(v);
                },
              ),
              const SizedBox(width: 12),
              FilledButton.icon(
                icon: const Icon(Icons.add_rounded, size: 16, color: Colors.white),
                label: const Text('Add Question'),
                style: FilledButton.styleFrom(backgroundColor: AppTheme.iconRed, foregroundColor: Colors.white),
                onPressed: onAddQuestion,
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...qp.questions.take(40).map((q) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.divider),
            ),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: q.type == QuestionType.mcq ? const Color(0xFFF4F4F5) : AppTheme.iconRedLight,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  q.type == QuestionType.mcq ? 'MCQ' : '${q.marks}M',
                  style: TextStyle(
                    color: q.type == QuestionType.mcq ? AppTheme.textPrimary : AppTheme.iconRedDark,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              title: Text(q.questionEnglish, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600)),
              subtitle: Text(
                'Exam: ${q.examId} • Unit ${q.unitNumber} • ${q.paper == PaperType.paper1 ? "Paper I" : "Paper II"}',
                style: const TextStyle(fontSize: 11.5, color: AppTheme.textMuted),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (q.isPremium) const Icon(Icons.lock_outline_rounded, size: 15, color: AppTheme.iconRed),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.delete_outline_rounded, size: 18, color: AppTheme.iconRed),
                    tooltip: 'Delete from MongoDB',
                    onPressed: () async {
                      final ok = await qp.deleteQuestionFromMongo(q.id, token);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(ok ? 'Deleted ${q.id} from MongoDB' : 'Failed to delete')),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}

// ─── Tab 3: Users Panel ───────────────────────────────────────
class _UsersPanel extends StatelessWidget {
  final Map<String, dynamic>? stats;
  final void Function(String userId, String newPlan) onUpdatePlan;
  final void Function(String paymentId, String action) onVerifyPayment;
  final void Function(String userId, String userName) onDeleteUser;
  const _UsersPanel({
    required this.stats,
    required this.onUpdatePlan,
    required this.onVerifyPayment,
    required this.onDeleteUser,
  });

  @override
  Widget build(BuildContext context) {
    final users = (stats?['users'] as List<dynamic>?) ?? [];
    final recentPayments = (stats?['recentPayments'] as List<dynamic>?) ?? [];
    final pendingPayments = (stats?['pendingPayments'] as List<dynamic>?) ??
        recentPayments.where((p) => p['status'] == 'pending').toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'MongoDB User & Subscription Management',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
          ),
          const SizedBox(height: 6),
          const Text(
            'Verify WhatsApp payment screenshots to activate candidate plans, manually upgrade/downgrade plans, or delete candidate accounts.',
            style: TextStyle(color: AppTheme.textMuted, fontSize: 13),
          ),
          if (pendingPayments.isNotEmpty) ...[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.iconRed, width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.pending_actions_rounded, color: AppTheme.iconRed, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Pending Payment Verifications (${pendingPayments.length})',
                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: AppTheme.textPrimary),
                      ),
                    ],
                  ),
                  const Divider(height: 18, color: AppTheme.divider),
                  ...pendingPayments.map((p) {
                    final payId = p['_id']?.toString() ?? '';
                    final planName = (p['plan']?.toString() ?? 'basic').toUpperCase();
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${p['userName']} (${p['userEmail']}) • Requested: $planName (रू ${p['amount']}) via ${p['method']?.toString().toUpperCase()} — "${p['transactionRef']}"',
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textPrimary),
                            ),
                          ),
                          const SizedBox(width: 8),
                          OutlinedButton(
                            onPressed: () => onVerifyPayment(payId, 'reject'),
                            child: const Text('Reject', style: TextStyle(fontSize: 12, color: AppTheme.iconRed)),
                          ),
                          const SizedBox(width: 8),
                          FilledButton.icon(
                            onPressed: () => onVerifyPayment(payId, 'approve'),
                            icon: const Icon(Icons.check_circle_outline_rounded, size: 15, color: Colors.white),
                            label: Text('Verify & Activate $planName', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                            style: FilledButton.styleFrom(backgroundColor: AppTheme.iconRed, foregroundColor: Colors.white),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
          const SizedBox(height: 20),
          ...users.map((u) {
            final uid = u['uid']?.toString() ?? '';
            final uName = u['name']?.toString() ?? 'Candidate';
            final uEmail = u['email']?.toString() ?? '';
            final isAdminUser = u['isAdmin'] == true;
            final currentPlan = u['plan']?.toString() ?? 'free';
            final rawExpiry = u['planExpiresAt']?.toString();
            String? expiryText;
            if (currentPlan != 'free' && rawExpiry != null && rawExpiry.isNotEmpty) {
              try {
                final dt = DateTime.parse(rawExpiry).toLocal();
                expiryText = '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
              } catch (_) {}
            }
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.divider),
              ),
              child: Wrap(
                spacing: 16,
                runSpacing: 12,
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isAdminUser ? AppTheme.bgSurface : AppTheme.iconRedLight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          isAdminUser ? Icons.admin_panel_settings_outlined : Icons.person_outline_rounded,
                          color: isAdminUser ? AppTheme.primaryColor : AppTheme.iconRed,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                uName,
                                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: AppTheme.textPrimary),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: isAdminUser ? AppTheme.primaryColor : AppTheme.bgSurface,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: AppTheme.divider),
                                ),
                                child: Text(
                                  isAdminUser ? 'ADMIN' : 'CANDIDATE',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    color: isAdminUser ? Colors.white : AppTheme.textMuted,
                                  ),
                                ),
                              ),
                              if (expiryText != null) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppTheme.iconRedLight,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: AppTheme.iconRed.withOpacity(0.3)),
                                  ),
                                  child: Text(
                                    'Expires: $expiryText',
                                    style: const TextStyle(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.w700,
                                      color: AppTheme.iconRed,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text(uEmail, style: const TextStyle(fontSize: 12.5, color: AppTheme.textMuted)),
                        ],
                      ),
                    ],
                  ),
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppTheme.bgSurface,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppTheme.divider),
                        ),
                        child: DropdownButton<String>(
                          value: currentPlan == 'free' ? 'free' : 'premium',
                          underline: const SizedBox.shrink(),
                          isDense: false,
                          items: const [
                            DropdownMenuItem(value: 'free', child: Text('Plan: Free', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600))),
                            DropdownMenuItem(value: 'premium', child: Text('Plan: Pro (रू 199)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600))),
                          ],
                          onChanged: (val) {
                            if (val != null && val != (currentPlan == 'free' ? 'free' : 'premium')) {
                              onUpdatePlan(uid, val);
                            }
                          },
                        ),
                      ),
                      if (currentPlan != 'free')
                        OutlinedButton.icon(
                          onPressed: () => onUpdatePlan(uid, 'premium'),
                          icon: const Icon(Icons.event_available_rounded, size: 15, color: AppTheme.primaryColor),
                          label: const Text(
                            'Set Expiry',
                            style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppTheme.primaryColor),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                            side: const BorderSide(color: AppTheme.primaryColor),
                          ),
                        ),
                      if (isAdminUser)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppTheme.bgSurface,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppTheme.divider),
                          ),
                          child: const Text('Protected Admin', style: TextStyle(fontSize: 12, color: AppTheme.textMuted, fontWeight: FontWeight.w600)),
                        )
                      else
                        OutlinedButton.icon(
                          onPressed: () => onDeleteUser(uid, uName),
                          icon: const Icon(Icons.delete_outline_rounded, size: 16, color: AppTheme.iconRed),
                          label: const Text(
                            'Delete User',
                            style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppTheme.iconRed),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            side: const BorderSide(color: AppTheme.iconRed),
                          ),
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

// ─── Tab 4: Payment QR, WhatsApp QR & Contact Settings Panel ──
class _PaymentQrSettingsPanel extends StatefulWidget {
  const _PaymentQrSettingsPanel();

  @override
  State<_PaymentQrSettingsPanel> createState() => _PaymentQrSettingsPanelState();
}

class _PaymentQrSettingsPanelState extends State<_PaymentQrSettingsPanel> {
  final _whatsappNumCtrl = TextEditingController();
  final _whatsappLinkCtrl = TextEditingController();
  final _whatsappQrCtrl = TextEditingController();
  final _paymentQrCtrl = TextEditingController();
  final _esewaCtrl = TextEditingController();
  final _khaltiCtrl = TextEditingController();
  final _fonepayCtrl = TextEditingController();
  final _bankNameCtrl = TextEditingController();
  final _bankAccNameCtrl = TextEditingController();
  final _bankAccNumCtrl = TextEditingController();
  final _bankBranchCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  bool _saving = false;
  bool _uploadingPaymentQr = false;
  bool _uploadingWhatsappQr = false;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      final qp = context.read<QuestionProvider>();
      _loadFromSettings(qp.settings);
      qp.fetchSettingsFromBackend().then((s) {
        if (mounted && !_uploadingPaymentQr && !_uploadingWhatsappQr && !_saving) {
          setState(() => _loadFromSettings(s));
        }
      });
    }
  }

  void _loadFromSettings(AppSettings s) {
    _whatsappNumCtrl.text = s.whatsappNumber;
    _whatsappLinkCtrl.text = s.whatsappLink;
    _whatsappQrCtrl.text = s.whatsappQrUrl;
    _paymentQrCtrl.text = s.paymentQrUrl;
    _esewaCtrl.text = s.esewaId;
    _khaltiCtrl.text = s.khaltiId;
    _fonepayCtrl.text = s.fonepayMerchant;
    _bankNameCtrl.text = s.bankName;
    _bankAccNameCtrl.text = s.bankAccountName;
    _bankAccNumCtrl.text = s.bankAccountNumber;
    _bankBranchCtrl.text = s.bankBranch;
    _emailCtrl.text = s.supportEmail;
    _phoneCtrl.text = s.supportPhone;
    _addressCtrl.text = s.officeAddress;
    _noteCtrl.text = s.verificationNote;
  }

  @override
  void dispose() {
    _whatsappNumCtrl.dispose();
    _whatsappLinkCtrl.dispose();
    _whatsappQrCtrl.dispose();
    _paymentQrCtrl.dispose();
    _esewaCtrl.dispose();
    _khaltiCtrl.dispose();
    _fonepayCtrl.dispose();
    _bankNameCtrl.dispose();
    _bankAccNameCtrl.dispose();
    _bankAccNumCtrl.dispose();
    _bankBranchCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  void _pickAndUploadToCloudinary({
    required String targetField,
    required TextEditingController controller,
    required bool isPaymentQr,
  }) {
    final input = html.FileUploadInputElement()..accept = 'image/*';
    input.click();
    input.onChange.listen((_) {
      final files = input.files;
      if (files == null || files.isEmpty) return;
      final file = files.first;
      final reader = html.FileReader();
      setState(() {
        if (isPaymentQr) {
          _uploadingPaymentQr = true;
        } else {
          _uploadingWhatsappQr = true;
        }
      });

      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((_) async {
        final dataUrl = reader.result as String?;
        if (dataUrl == null || !mounted) return;

        final token = context.read<AuthProvider>().token ?? '';
        final uploadedUrl = await context.read<QuestionProvider>().uploadImageToCloudinary(
              imageDataUrl: dataUrl,
              targetField: targetField,
              token: token,
            );

        if (!mounted) return;
        setState(() {
          if (isPaymentQr) {
            _uploadingPaymentQr = false;
          } else {
            _uploadingWhatsappQr = false;
          }
          if (uploadedUrl != null && uploadedUrl.isNotEmpty) {
            controller.text = uploadedUrl;
          }
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              uploadedUrl != null
                  ? 'Uploaded to Cloudinary (rajeevyadav) & saved to MongoDB Atlas!'
                  : 'Failed to upload image to Cloudinary',
            ),
            backgroundColor: uploadedUrl != null ? AppTheme.primaryColor : AppTheme.iconRed,
          ),
        );
      });
    });
  }

  Future<void> _saveSettings() async {
    setState(() => _saving = true);
    final token = context.read<AuthProvider>().token ?? '';
    final updated = AppSettings(
      whatsappNumber: _whatsappNumCtrl.text.trim(),
      whatsappLink: _whatsappLinkCtrl.text.trim(),
      whatsappQrUrl: _whatsappQrCtrl.text.trim(),
      paymentQrUrl: _paymentQrCtrl.text.trim(),
      esewaId: _esewaCtrl.text.trim(),
      khaltiId: _khaltiCtrl.text.trim(),
      fonepayMerchant: _fonepayCtrl.text.trim(),
      bankName: _bankNameCtrl.text.trim(),
      bankAccountName: _bankAccNameCtrl.text.trim(),
      bankAccountNumber: _bankAccNumCtrl.text.trim(),
      bankBranch: _bankBranchCtrl.text.trim(),
      supportEmail: _emailCtrl.text.trim(),
      supportPhone: _phoneCtrl.text.trim(),
      officeAddress: _addressCtrl.text.trim(),
      verificationNote: _noteCtrl.text.trim(),
    );

    final ok = await context.read<QuestionProvider>().updateSettingsToMongo(updated, token);
    if (!mounted) return;
    setState(() => _saving = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok
              ? 'Payment QR, WhatsApp QR & Contact settings saved to MongoDB Atlas!'
              : 'Saved locally (Backend syncing)',
        ),
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }

  void _autoGenerateWhatsappQr() {
    final rawDigits = _whatsappNumCtrl.text.replaceAll(RegExp(r'[^0-9]'), '');
    final digits = rawDigits.isEmpty ? '9779800000000' : rawDigits;
    final waUrl = 'https://wa.me/$digits';
    setState(() {
      _whatsappLinkCtrl.text = waUrl;
      _whatsappQrCtrl.text = 'https://api.qrserver.com/v1/create-qr-code/?size=240x240&data=$waUrl';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment QR, WhatsApp Verification QR & Contact Settings',
                      style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Upload QR images directly to Cloudinary (cloud: rajeevyadav) or configure Wallets, Bank Account & WhatsApp Contacts.',
                      style: TextStyle(color: AppTheme.textMuted, fontSize: 13),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              FilledButton.icon(
                onPressed: _saving ? null : _saveSettings,
                icon: _saving
                    ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Icon(Icons.cloud_upload_outlined, size: 18, color: Colors.white),
                label: const Text('Save All to MongoDB'),
                style: FilledButton.styleFrom(
                  backgroundColor: AppTheme.iconRed,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Live QR Previews Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.divider),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.qr_code_2_rounded, color: AppTheme.primaryColor, size: 20),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text(
                              '1. Payment QR Code (eSewa / Khalti / FonePay / Bank)',
                              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5),
                            ),
                          ),
                          FilledButton.icon(
                            onPressed: _uploadingPaymentQr
                                ? null
                                : () => _pickAndUploadToCloudinary(
                                      targetField: 'paymentQrUrl',
                                      controller: _paymentQrCtrl,
                                      isPaymentQr: true,
                                    ),
                            icon: _uploadingPaymentQr
                                ? const SizedBox(
                                    width: 14,
                                    height: 14,
                                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                  )
                                : const Icon(Icons.cloud_upload_rounded, size: 15, color: Colors.white),
                            label: Text(
                              _uploadingPaymentQr ? 'Uploading...' : 'Upload to Cloudinary',
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                            ),
                            style: FilledButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 20, color: AppTheme.divider),
                      Row(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppTheme.divider),
                            ),
                            child: Image.network(
                              _paymentQrCtrl.text,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => const Icon(Icons.qr_code_2_rounded, size: 64),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              children: [
                                TextField(
                                  controller: _paymentQrCtrl,
                                  decoration: const InputDecoration(
                                    labelText: 'Payment QR Image URL (Cloudinary / Direct URL)',
                                    helperText: 'Click "Upload to Cloudinary" above or paste an image URL',
                                  ),
                                  onChanged: (_) => setState(() {}),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.iconRed.withOpacity(0.45)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.chat_bubble_outline_rounded, color: AppTheme.iconRed, size: 19),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text(
                              '2. WhatsApp Verification QR & Number',
                              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: AppTheme.textPrimary),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: _autoGenerateWhatsappQr,
                            icon: const Icon(Icons.auto_fix_high_rounded, size: 15, color: AppTheme.iconRed),
                            label: const Text('Auto-QR', style: TextStyle(fontSize: 11.5, color: AppTheme.iconRed, fontWeight: FontWeight.w700)),
                          ),
                          const SizedBox(width: 6),
                          FilledButton.icon(
                            onPressed: _uploadingWhatsappQr
                                ? null
                                : () => _pickAndUploadToCloudinary(
                                      targetField: 'whatsappQrUrl',
                                      controller: _whatsappQrCtrl,
                                      isPaymentQr: false,
                                    ),
                            icon: _uploadingWhatsappQr
                                ? const SizedBox(
                                    width: 14,
                                    height: 14,
                                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                  )
                                : const Icon(Icons.cloud_upload_rounded, size: 15, color: Colors.white),
                            label: Text(
                              _uploadingWhatsappQr ? 'Uploading...' : 'Upload to Cloudinary',
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                            ),
                            style: FilledButton.styleFrom(
                              backgroundColor: AppTheme.iconRed,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 20, color: AppTheme.divider),
                      Row(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppTheme.divider),
                            ),
                            child: Image.network(
                              _whatsappQrCtrl.text,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => const Icon(Icons.qr_code_rounded, size: 64, color: AppTheme.iconRed),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              children: [
                                TextField(
                                  controller: _whatsappNumCtrl,
                                  decoration: const InputDecoration(
                                    labelText: 'Official WhatsApp Number (for Screenshot)',
                                    prefixIcon: Icon(Icons.phone_outlined, size: 18, color: AppTheme.iconRed),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextField(
                                  controller: _whatsappQrCtrl,
                                  decoration: const InputDecoration(
                                    labelText: 'WhatsApp QR Image URL (Cloudinary / Auto-QR)',
                                  ),
                                  onChanged: (_) => setState(() {}),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Wallet, Bank & Contact Fields
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.divider),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.account_balance_wallet_outlined, color: AppTheme.iconRed, size: 20),
                    SizedBox(width: 8),
                    Text('Digital Wallets, Bank Account & Support Contacts', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                  ],
                ),
                const Divider(height: 22, color: AppTheme.divider),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _esewaCtrl,
                        decoration: const InputDecoration(labelText: 'eSewa Wallet ID / Number'),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: TextField(
                        controller: _khaltiCtrl,
                        decoration: const InputDecoration(labelText: 'Khalti Wallet ID / Number'),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: TextField(
                        controller: _fonepayCtrl,
                        decoration: const InputDecoration(labelText: 'FonePay Merchant Name'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _bankNameCtrl,
                        decoration: const InputDecoration(labelText: 'Bank Name'),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: TextField(
                        controller: _bankAccNameCtrl,
                        decoration: const InputDecoration(labelText: 'Bank Account Holder Name'),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: TextField(
                        controller: _bankAccNumCtrl,
                        decoration: const InputDecoration(labelText: 'Bank Account Number'),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: TextField(
                        controller: _bankBranchCtrl,
                        decoration: const InputDecoration(labelText: 'Bank Branch'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _whatsappLinkCtrl,
                        decoration: const InputDecoration(labelText: 'WhatsApp Direct Chat Link (wa.me/...)'),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: TextField(
                        controller: _emailCtrl,
                        decoration: const InputDecoration(labelText: 'Support Email Address'),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: TextField(
                        controller: _phoneCtrl,
                        decoration: const InputDecoration(labelText: 'Support Phone / Helpline'),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: TextField(
                        controller: _addressCtrl,
                        decoration: const InputDecoration(labelText: 'Office Location / Address'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _noteCtrl,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Candidate Payment Verification Instructions (Shown on Subscription & Payment Dialog)',
                  ),
                ),
                const SizedBox(height: 18),
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton.icon(
                    onPressed: _saving ? null : _saveSettings,
                    icon: const Icon(Icons.save_outlined, size: 18, color: Colors.white),
                    label: const Text('Save Payment & Contact Settings'),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppTheme.iconRed,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
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
}

