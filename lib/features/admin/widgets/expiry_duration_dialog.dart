import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class ExpiryDurationDialog extends StatefulWidget {
  final String title;
  final int initialDays;

  const ExpiryDurationDialog({
    super.key,
    required this.title,
    this.initialDays = 30,
  });

  static Future<Map<String, dynamic>?> show(
    BuildContext context, {
    required String title,
    int initialDays = 30,
  }) {
    return showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) => ExpiryDurationDialog(title: title, initialDays: initialDays),
    );
  }

  @override
  State<ExpiryDurationDialog> createState() => _ExpiryDurationDialogState();
}

class _ExpiryDurationDialogState extends State<ExpiryDurationDialog> {
  late int _selectedDays;
  DateTime? _customDate;
  late final TextEditingController _daysCtrl;

  @override
  void initState() {
    super.initState();
    _selectedDays = widget.initialDays;
    _daysCtrl = TextEditingController(text: '$_selectedDays');
  }

  @override
  void dispose() {
    _daysCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 520;
    final previewDate = _customDate ?? DateTime.now().add(Duration(days: _selectedDays));
    final previewStr = previewDate.toLocal().toString().split(' ').first;

    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppTheme.divider),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: isNarrow ? 14 : 40, vertical: 20),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.iconRedLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.timer_outlined, color: AppTheme.iconRed, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              widget.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: 460,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select how long the candidate\'s Pro Plan (रू 199) should remain active before expiring:',
                style: TextStyle(fontSize: 13, color: AppTheme.textMuted),
              ),
              const SizedBox(height: 16),
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
                  final isSelected = _customDate == null && _selectedDays == preset.$1;
                  return ChoiceChip(
                    label: Text(preset.$2),
                    selected: isSelected,
                    selectedColor: AppTheme.iconRedLight,
                    backgroundColor: Colors.white,
                    side: BorderSide(
                      color: isSelected ? AppTheme.iconRed : AppTheme.divider,
                    ),
                    labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? AppTheme.iconRedDark : AppTheme.textPrimary,
                    ),
                    onSelected: (_) {
                      setState(() {
                        _customDate = null;
                        _selectedDays = preset.$1;
                        _daysCtrl.text = '${preset.$1}';
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 10,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  SizedBox(
                    width: isNarrow ? double.infinity : 220,
                    child: TextField(
                      controller: _daysCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Custom Days',
                        suffixText: 'days',
                      ),
                      onChanged: (v) {
                        final parsed = int.tryParse(v.trim());
                        if (parsed != null && parsed > 0) {
                          setState(() {
                            _customDate = null;
                            _selectedDays = parsed;
                          });
                        }
                      },
                    ),
                  ),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.calendar_month_outlined, size: 16, color: AppTheme.iconRed),
                    label: const Text('Pick Exact Date', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700)),
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: previewDate,
                        firstDate: DateTime.now().add(const Duration(days: 1)),
                        lastDate: DateTime.now().add(const Duration(days: 3650)),
                      );
                      if (picked != null) {
                        setState(() {
                          _customDate = DateTime(picked.year, picked.month, picked.day, 23, 59, 59);
                        });
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: AppTheme.bgSurface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppTheme.divider),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.event_available_rounded, size: 18, color: AppTheme.iconRed),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Active Until:',
                            style: TextStyle(fontSize: 11, color: AppTheme.textMuted, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            previewStr,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: const Text('Cancel', style: TextStyle(color: AppTheme.textMuted)),
        ),
        FilledButton.icon(
          style: FilledButton.styleFrom(backgroundColor: AppTheme.iconRed, foregroundColor: Colors.white),
          icon: const Icon(Icons.check_circle_outline_rounded, size: 16, color: Colors.white),
          label: Text('Activate Until $previewStr'),
          onPressed: () {
            Navigator.pop(context, {
              'durationDays': _selectedDays,
              'expiresAt': previewDate.toIso8601String(),
            });
          },
        ),
      ],
    );
  }
}
