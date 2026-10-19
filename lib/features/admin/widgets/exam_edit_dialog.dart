import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../data/models/models.dart';
import '../../../../data/repositories/providers.dart';

class ExamEditDialog extends StatefulWidget {
  final ExamCourse? exam;

  const ExamEditDialog({super.key, this.exam});

  static Future<bool?> show(BuildContext context, {ExamCourse? exam}) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => ExamEditDialog(exam: exam),
    );
  }

  @override
  State<ExamEditDialog> createState() => _ExamEditDialogState();
}

class _ExamEditDialogState extends State<ExamEditDialog> {
  late final TextEditingController _idCtrl;
  late final TextEditingController _titleCtrl;
  late final TextEditingController _titleNpCtrl;
  late final TextEditingController _orgCtrl;
  late final TextEditingController _levelCtrl;
  late final TextEditingController _descCtrl;
  late final TextEditingController _schemeCtrl;
  late final TextEditingController _topicsCtrl;

  late String _category;
  late bool _isComingSoon;
  bool _saving = false;

  bool get _isEdit => widget.exam != null;

  @override
  void initState() {
    super.initState();
    final ex = widget.exam;
    _idCtrl = TextEditingController(
      text: ex?.id ?? 'psc_exam_${DateTime.now().millisecondsSinceEpoch % 10000}',
    );
    _titleCtrl = TextEditingController(text: ex?.title ?? '');
    _titleNpCtrl = TextEditingController(text: ex?.titleNepali ?? '');
    _orgCtrl = TextEditingController(text: ex?.organization ?? 'Public Service Commission (Lok Sewa Aayog)');
    _levelCtrl = TextEditingController(text: ex?.level ?? 'Level 5 / Non-Gazetted 1st Class');
    _descCtrl = TextEditingController(text: ex?.description ?? '');

    final schemes = ex?.examScheme ?? [
      'Paper I: General Studies & IQ (Objective 100 Marks)',
      'Paper II: Service-Related Technical (Subjective 100 Marks)',
    ];
    _schemeCtrl = TextEditingController(text: schemes.join('\n'));

    final topics = ex?.syllabusSections.isNotEmpty ?? false
        ? ex!.syllabusSections.map((s) => '${s.title}:\n${s.topics.map((t) => '- $t').join('\n')}').join('\n\n')
        : 'Unit 1: Constitution & Legal Framework\nUnit 2: Office Management & Public Administration\nUnit 3: Professional & Technical Knowledge';
    _topicsCtrl = TextEditingController(text: topics);

    _category = ex?.category ?? 'Civil Service';
    _isComingSoon = ex?.isComingSoon ?? false;
  }

  @override
  void dispose() {
    _idCtrl.dispose();
    _titleCtrl.dispose();
    _titleNpCtrl.dispose();
    _orgCtrl.dispose();
    _levelCtrl.dispose();
    _descCtrl.dispose();
    _schemeCtrl.dispose();
    _topicsCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    final title = _titleCtrl.text.trim();
    final id = _idCtrl.text.trim();
    if (id.isEmpty || title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Exam ID and English Title are required.'),
          backgroundColor: AppTheme.iconRed,
        ),
      );
      return;
    }

    setState(() => _saving = true);
    final qp = context.read<QuestionProvider>();
    final token = context.read<AuthProvider>().adminToken ?? '';

    final schemeList = _schemeCtrl.text
        .split('\n')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    final topicList = _topicsCtrl.text
        .split('\n')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    final payload = <String, dynamic>{
      'id': id,
      'title': title,
      'title_nepali': _titleNpCtrl.text.trim().isEmpty ? title : _titleNpCtrl.text.trim(),
      'category': _category,
      'organization': _orgCtrl.text.trim(),
      'level': _levelCtrl.text.trim(),
      'description': _descCtrl.text.trim(),
      'is_coming_soon': _isComingSoon,
      'exam_scheme': schemeList,
      'syllabus_sections': [
        {
          'title': 'Official Exam Curriculum & Core Units',
          'topics': topicList,
        }
      ],
    };

    bool success;
    if (_isEdit) {
      success = await qp.updateExamInMongo(id, payload, token);
    } else {
      success = await qp.addExamToMongo(payload, token);
    }

    if (mounted) {
      setState(() => _saving = false);
      if (success) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isEdit ? 'Exam course updated in MongoDB Atlas!' : 'Exam course created in MongoDB Atlas!'),
            backgroundColor: AppTheme.primaryColor,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isEdit ? 'Failed to update exam' : 'Failed to create exam'),
            backgroundColor: AppTheme.iconRed,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 620;

    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppTheme.divider),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: isNarrow ? 12 : 36, vertical: 20),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.iconRedLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _isEdit ? Icons.edit_note_rounded : Icons.library_add_rounded,
              color: AppTheme.iconRed,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              _isEdit ? 'Edit Exam Course (${widget.exam!.title})' : 'Add New Lok Sewa Exam Course',
              style: const TextStyle(fontSize: 16.5, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: 640,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isNarrow) ...[
                TextField(
                  controller: _idCtrl,
                  enabled: !_isEdit,
                  decoration: const InputDecoration(labelText: 'Unique ID (e.g. rbb_it_5, psc_nasu) *'),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _category,
                  decoration: const InputDecoration(labelText: 'Exam Category *'),
                  items: const [
                    DropdownMenuItem(value: 'Civil Service', child: Text('Civil Service (निजामती)')),
                    DropdownMenuItem(value: 'Banking', child: Text('Banking (बैंकिङ)')),
                    DropdownMenuItem(value: 'IT & Technical', child: Text('IT & Technical (प्राविधिक)')),
                    DropdownMenuItem(value: 'Sansthan', child: Text('Sansthan (संस्थान)')),
                  ],
                  onChanged: (v) => setState(() => _category = v!),
                ),
              ] else
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _idCtrl,
                        enabled: !_isEdit,
                        decoration: const InputDecoration(labelText: 'Unique ID (e.g. rbb_it_5, psc_nasu) *'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _category,
                        decoration: const InputDecoration(labelText: 'Exam Category *'),
                        items: const [
                          DropdownMenuItem(value: 'Civil Service', child: Text('Civil Service (निजामती)')),
                          DropdownMenuItem(value: 'Banking', child: Text('Banking (बैंकिङ)')),
                          DropdownMenuItem(value: 'IT & Technical', child: Text('IT & Technical (प्राविधिक)')),
                          DropdownMenuItem(value: 'Sansthan', child: Text('Sansthan (संस्थान)')),
                        ],
                        onChanged: (v) => setState(() => _category = v!),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 14),

              TextField(
                controller: _titleCtrl,
                decoration: const InputDecoration(labelText: 'Post / Exam Title (English) *'),
              ),
              const SizedBox(height: 14),

              TextField(
                controller: _titleNpCtrl,
                decoration: const InputDecoration(labelText: 'Post / Exam Title (नेपाली नाम) *'),
              ),
              const SizedBox(height: 14),

              if (isNarrow) ...[
                TextField(
                  controller: _orgCtrl,
                  decoration: const InputDecoration(labelText: 'Conducting Body / Bank'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _levelCtrl,
                  decoration: const InputDecoration(labelText: 'Post Level / Grade'),
                ),
              ] else
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _orgCtrl,
                        decoration: const InputDecoration(labelText: 'Conducting Body / Bank'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _levelCtrl,
                        decoration: const InputDecoration(labelText: 'Post Level / Grade'),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 14),

              TextField(
                controller: _descCtrl,
                maxLines: 2,
                decoration: const InputDecoration(labelText: 'Course Description & Overview'),
              ),
              const SizedBox(height: 14),

              TextField(
                controller: _schemeCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Exam Scheme (1 line per stage/paper)',
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 14),

              TextField(
                controller: _topicsCtrl,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Syllabus Units & Topics (1 line per unit or topic)',
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 14),

              Container(
                decoration: BoxDecoration(
                  color: AppTheme.bgSurface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.divider),
                ),
                child: SwitchListTile(
                  activeColor: AppTheme.iconRed,
                  title: const Text('Status: Coming Soon (Locked)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                  subtitle: Text(
                    _isComingSoon
                        ? 'Exam displays a locked "COMING SOON" badge and candidates cannot open it yet.'
                        : 'Exam is LIVE and immediately accessible to candidate enrollments.',
                    style: const TextStyle(fontSize: 11.5, color: AppTheme.textMuted),
                  ),
                  value: _isComingSoon,
                  onChanged: (v) => setState(() => _isComingSoon = v),
                ),
              ),
            ],
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.pop(context, false),
          child: const Text('Cancel', style: TextStyle(color: AppTheme.textMuted)),
        ),
        FilledButton.icon(
          onPressed: _saving ? null : _handleSave,
          icon: _saving
              ? const SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
              : const Icon(Icons.cloud_upload_outlined, size: 17, color: Colors.white),
          label: Text(_saving ? 'Saving...' : (_isEdit ? 'Save Changes' : 'Create Exam')),
          style: FilledButton.styleFrom(backgroundColor: AppTheme.iconRed, foregroundColor: Colors.white),
        ),
      ],
    );
  }
}
