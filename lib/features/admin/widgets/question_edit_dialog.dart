import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../data/models/models.dart';
import '../../../../data/repositories/providers.dart';

class QuestionEditDialog extends StatefulWidget {
  final Question? question; // null if creating new
  final String? defaultExamId;

  const QuestionEditDialog({
    super.key,
    this.question,
    this.defaultExamId,
  });

  static Future<bool?> show(
    BuildContext context, {
    Question? question,
    String? defaultExamId,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => QuestionEditDialog(question: question, defaultExamId: defaultExamId),
    );
  }

  @override
  State<QuestionEditDialog> createState() => _QuestionEditDialogState();
}

class _QuestionEditDialogState extends State<QuestionEditDialog> {
  late final TextEditingController _idCtrl;
  late final TextEditingController _unitNumCtrl;
  late final TextEditingController _unitTitleCtrl;
  late final TextEditingController _yearCtrl;
  late final TextEditingController _qNpCtrl;
  late final TextEditingController _qEnCtrl;
  late final TextEditingController _ansNpCtrl;
  late final TextEditingController _ansEnCtrl;
  late final TextEditingController _optACtrl;
  late final TextEditingController _optBCtrl;
  late final TextEditingController _optCCtrl;
  late final TextEditingController _optDCtrl;
  late final TextEditingController _expCtrl;

  late String _selectedExamId;
  late String _qType;
  late String _paper;
  late String _section;
  late int _marks;
  late int _correctIdx;
  late bool _isPremium;
  bool _saving = false;

  bool get _isEdit => widget.question != null;

  @override
  void initState() {
    super.initState();
    final q = widget.question;
    final qp = context.read<QuestionProvider>();
    final fallbackExam = widget.defaultExamId ??
        (qp.selectedExamId == 'all'
            ? (qp.exams.isNotEmpty ? qp.exams.first.id : 'rbb_it_5')
            : qp.selectedExamId);

    _selectedExamId = q?.examId ?? fallbackExam;
    _qType = q != null ? (q.type == QuestionType.mcq ? 'mcq' : 'subjective') : 'subjective';
    _paper = q != null ? (q.paper == PaperType.paper2 ? 'paper2' : 'paper1') : 'paper1';
    _section = q != null ? (q.section == SectionType.sectionB ? 'sectionB' : 'sectionA') : 'sectionA';
    _marks = q?.marks ?? (_qType == 'mcq' ? 1 : 5);
    _correctIdx = q?.correctOptionIndex ?? 0;
    _isPremium = q?.isPremium ?? true;

    _idCtrl = TextEditingController(text: q?.id ?? 'q_${DateTime.now().millisecondsSinceEpoch % 100000}');
    _unitNumCtrl = TextEditingController(text: '${q?.unitNumber ?? 1}');
    _unitTitleCtrl = TextEditingController(text: q?.unitTitle ?? 'Unit 1: Core Syllabus Topic');
    _yearCtrl = TextEditingController(text: (q?.yearsAsked.isNotEmpty ?? false) ? q!.yearsAsked.join(', ') : '2082 BS');
    _qNpCtrl = TextEditingController(text: q?.questionNepali ?? '');
    _qEnCtrl = TextEditingController(text: q?.questionEnglish ?? '');
    _ansNpCtrl = TextEditingController(text: q?.answerNepali ?? '');
    _ansEnCtrl = TextEditingController(text: q?.answerEnglish ?? '');

    final opts = q?.options ?? [];
    _optACtrl = TextEditingController(text: opts.isNotEmpty ? opts[0] : '');
    _optBCtrl = TextEditingController(text: opts.length > 1 ? opts[1] : '');
    _optCCtrl = TextEditingController(text: opts.length > 2 ? opts[2] : '');
    _optDCtrl = TextEditingController(text: opts.length > 3 ? opts[3] : '');
    _expCtrl = TextEditingController(text: q?.explanation ?? '');
  }

  @override
  void dispose() {
    _idCtrl.dispose();
    _unitNumCtrl.dispose();
    _unitTitleCtrl.dispose();
    _yearCtrl.dispose();
    _qNpCtrl.dispose();
    _qEnCtrl.dispose();
    _ansNpCtrl.dispose();
    _ansEnCtrl.dispose();
    _optACtrl.dispose();
    _optBCtrl.dispose();
    _optCCtrl.dispose();
    _optDCtrl.dispose();
    _expCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    final qp = context.read<QuestionProvider>();
    final token = context.read<AuthProvider>().adminToken ?? '';

    final id = _idCtrl.text.trim();
    final qNp = _qNpCtrl.text.trim();
    final qEn = _qEnCtrl.text.trim();

    if (id.isEmpty || qNp.isEmpty || qEn.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Question ID, Nepali Question, and English Question are required.'),
          backgroundColor: AppTheme.iconRed,
        ),
      );
      return;
    }

    setState(() => _saving = true);

    final years = _yearCtrl.text
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    final payload = <String, dynamic>{
      'id': id,
      'exam_id': _selectedExamId,
      'paper': _paper,
      'section': _section,
      'unit_number': int.tryParse(_unitNumCtrl.text.trim()) ?? 1,
      'unit_title': _unitTitleCtrl.text.trim(),
      'marks': _marks,
      'type': _qType,
      'years_asked': years.isEmpty ? ['2082 BS'] : years,
      'question_nepali': qNp,
      'question_english': qEn,
      'is_premium': _isPremium,
    };

    if (_qType == 'subjective') {
      payload['answer_nepali'] = _ansNpCtrl.text.trim();
      payload['answer_english'] = _ansEnCtrl.text.trim();
      payload['options'] = null;
      payload['correct_option_index'] = null;
      payload['explanation'] = null;
    } else {
      payload['answer_nepali'] = null;
      payload['answer_english'] = null;
      payload['options'] = [
        _optACtrl.text.trim(),
        _optBCtrl.text.trim(),
        _optCCtrl.text.trim(),
        _optDCtrl.text.trim(),
      ];
      payload['correct_option_index'] = _correctIdx;
      payload['explanation'] = _expCtrl.text.trim();
    }

    bool success;
    if (_isEdit) {
      success = await qp.updateQuestionInMongo(id, payload, token);
    } else {
      success = await qp.addQuestionToMongo(payload, token);
    }

    if (mounted) {
      setState(() => _saving = false);
      if (success) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isEdit ? 'Question updated in MongoDB Atlas!' : 'Question published to Question Bank!'),
            backgroundColor: AppTheme.primaryColor,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isEdit ? 'Failed to update question' : 'Failed to publish question'),
            backgroundColor: AppTheme.iconRed,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final qp = context.watch<QuestionProvider>();
    final exams = qp.exams;
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
              _isEdit ? Icons.edit_note_rounded : Icons.post_add_rounded,
              color: AppTheme.iconRed,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              _isEdit ? 'Edit Question (${widget.question!.id})' : 'Create New Question (MongoDB)',
              style: const TextStyle(fontSize: 16.5, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: 680,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Target Exam
              DropdownButtonFormField<String>(
                isExpanded: true,
                value: exams.any((e) => e.id == _selectedExamId)
                    ? _selectedExamId
                    : (exams.isNotEmpty ? exams.first.id : 'rbb_it_5'),
                decoration: const InputDecoration(labelText: 'Target Lok Sewa Exam *'),
                items: exams
                    .map((e) => DropdownMenuItem(
                          value: e.id,
                          child: Text('${e.title} (${e.category})', overflow: TextOverflow.ellipsis),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => _selectedExamId = v!),
              ),
              const SizedBox(height: 14),

              // Question Type, Paper, Section
              if (isNarrow) ...[
                DropdownButtonFormField<String>(
                  value: _qType,
                  decoration: const InputDecoration(labelText: 'Question Format'),
                  items: const [
                    DropdownMenuItem(value: 'subjective', child: Text('Subjective (Written Q&A)')),
                    DropdownMenuItem(value: 'mcq', child: Text('Objective MCQ (4 Options)')),
                  ],
                  onChanged: (v) => setState(() {
                    _qType = v!;
                    _marks = _qType == 'mcq' ? 1 : 5;
                  }),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _paper,
                        decoration: const InputDecoration(labelText: 'Paper'),
                        items: const [
                          DropdownMenuItem(value: 'paper1', child: Text('Paper I')),
                          DropdownMenuItem(value: 'paper2', child: Text('Paper II')),
                        ],
                        onChanged: (v) => setState(() => _paper = v!),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _section,
                        decoration: const InputDecoration(labelText: 'Section'),
                        items: const [
                          DropdownMenuItem(value: 'sectionA', child: Text('Section A')),
                          DropdownMenuItem(value: 'sectionB', child: Text('Section B')),
                        ],
                        onChanged: (v) => setState(() => _section = v!),
                      ),
                    ),
                  ],
                ),
              ] else
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: DropdownButtonFormField<String>(
                        value: _qType,
                        decoration: const InputDecoration(labelText: 'Question Format'),
                        items: const [
                          DropdownMenuItem(value: 'subjective', child: Text('Subjective (Written Q&A)')),
                          DropdownMenuItem(value: 'mcq', child: Text('Objective MCQ (4 Options)')),
                        ],
                        onChanged: (v) => setState(() {
                          _qType = v!;
                          _marks = _qType == 'mcq' ? 1 : 5;
                        }),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _paper,
                        decoration: const InputDecoration(labelText: 'Paper'),
                        items: const [
                          DropdownMenuItem(value: 'paper1', child: Text('Paper I')),
                          DropdownMenuItem(value: 'paper2', child: Text('Paper II')),
                        ],
                        onChanged: (v) => setState(() => _paper = v!),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _section,
                        decoration: const InputDecoration(labelText: 'Section'),
                        items: const [
                          DropdownMenuItem(value: 'sectionA', child: Text('Section A')),
                          DropdownMenuItem(value: 'sectionB', child: Text('Section B')),
                        ],
                        onChanged: (v) => setState(() => _section = v!),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 14),

              // Unit number, Marks, Year Asked
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _unitNumCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Unit No.', prefixText: 'Unit '),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      value: _marks,
                      decoration: const InputDecoration(labelText: 'Marks'),
                      items: const [
                        DropdownMenuItem(value: 1, child: Text('1 Mark')),
                        DropdownMenuItem(value: 2, child: Text('2 Marks')),
                        DropdownMenuItem(value: 5, child: Text('5 Marks')),
                        DropdownMenuItem(value: 10, child: Text('10 Marks')),
                        DropdownMenuItem(value: 15, child: Text('15 Marks')),
                        DropdownMenuItem(value: 20, child: Text('20 Marks')),
                      ],
                      onChanged: (v) => setState(() => _marks = v!),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: isNarrow ? 1 : 2,
                    child: TextField(
                      controller: _yearCtrl,
                      decoration: const InputDecoration(labelText: 'Years Asked (comma-sep)'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Unit Title
              TextField(
                controller: _unitTitleCtrl,
                decoration: const InputDecoration(labelText: 'Unit / Topic Title *'),
              ),
              const SizedBox(height: 14),

              // Nepali Question
              TextField(
                controller: _qNpCtrl,
                maxLines: 2,
                decoration: const InputDecoration(labelText: 'Question in Nepali (नेपाली प्रश्न) *'),
              ),
              const SizedBox(height: 14),

              // English Question
              TextField(
                controller: _qEnCtrl,
                maxLines: 2,
                decoration: const InputDecoration(labelText: 'Question in English *'),
              ),
              const SizedBox(height: 14),

              // Format specific: Subjective vs MCQ
              if (_qType == 'subjective') ...[
                TextField(
                  controller: _ansNpCtrl,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'High-Scoring Model Answer (Nepali — परिचय, मुख्य बुँदाहरू, निष्कर्ष)',
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _ansEnCtrl,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Model Answer (English)',
                    alignLabelWithHint: true,
                  ),
                ),
              ] else ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.bgSurface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppTheme.divider),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('MCQ Options & Correct Answer',
                          style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppTheme.textPrimary)),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Radio<int>(
                            value: 0,
                            groupValue: _correctIdx,
                            activeColor: AppTheme.iconRed,
                            onChanged: (v) => setState(() => _correctIdx = v!),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _optACtrl,
                              decoration: const InputDecoration(labelText: 'Option A (Correct?)'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Radio<int>(
                            value: 1,
                            groupValue: _correctIdx,
                            activeColor: AppTheme.iconRed,
                            onChanged: (v) => setState(() => _correctIdx = v!),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _optBCtrl,
                              decoration: const InputDecoration(labelText: 'Option B (Correct?)'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Radio<int>(
                            value: 2,
                            groupValue: _correctIdx,
                            activeColor: AppTheme.iconRed,
                            onChanged: (v) => setState(() => _correctIdx = v!),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _optCCtrl,
                              decoration: const InputDecoration(labelText: 'Option C (Correct?)'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Radio<int>(
                            value: 3,
                            groupValue: _correctIdx,
                            activeColor: AppTheme.iconRed,
                            onChanged: (v) => setState(() => _correctIdx = v!),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _optDCtrl,
                              decoration: const InputDecoration(labelText: 'Option D (Correct?)'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _expCtrl,
                        maxLines: 2,
                        decoration: const InputDecoration(labelText: 'Answer Explanation / Rationale'),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 14),

              // Require Pro switch
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.bgSurface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.divider),
                ),
                child: SwitchListTile(
                  activeColor: AppTheme.iconRed,
                  title: const Text('Require Paid Pro Plan (रू 199)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                  subtitle: Text(
                    _isPremium ? 'Only Pro subscribers see complete model answer / explanation.' : 'Free candidates can view this question & answer.',
                    style: const TextStyle(fontSize: 11.5, color: AppTheme.textMuted),
                  ),
                  value: _isPremium,
                  onChanged: (v) => setState(() => _isPremium = v),
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
          label: Text(_saving ? 'Saving...' : (_isEdit ? 'Save Changes' : 'Publish Question')),
          style: FilledButton.styleFrom(backgroundColor: AppTheme.iconRed, foregroundColor: Colors.white),
        ),
      ],
    );
  }
}
