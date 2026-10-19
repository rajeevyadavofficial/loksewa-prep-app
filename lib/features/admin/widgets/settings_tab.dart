// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../data/models/models.dart';
import '../../../../data/repositories/providers.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
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
      _populateFields(qp.settings);
      qp.fetchSettingsFromBackend().then((s) {
        if (mounted && !_uploadingPaymentQr && !_uploadingWhatsappQr && !_saving) {
          setState(() => _populateFields(s));
        }
      });
    }
  }

  void _populateFields(AppSettings s) {
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

        final token = context.read<AuthProvider>().adminToken ?? '';
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
                  ? 'QR image uploaded to Cloudinary & saved to MongoDB Atlas!'
                  : 'Failed to upload QR image to Cloudinary',
            ),
            backgroundColor: uploadedUrl != null ? AppTheme.primaryColor : AppTheme.iconRed,
          ),
        );
      });
    });
  }

  Future<void> _handleSave() async {
    setState(() => _saving = true);
    final token = context.read<AuthProvider>().adminToken ?? '';
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
          ok ? 'Payment QR & Contact settings saved to MongoDB Atlas!' : 'Saved settings locally',
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
                    'Payment QR, Wallets & System Settings',
                    style: TextStyle(fontSize: isMobile ? 18 : 21, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    'Manage official payment QR codes, digital wallets, bank transfer details, and candidate verification instructions.',
                    style: TextStyle(color: AppTheme.textMuted, fontSize: 13),
                  ),
                ],
              ),
              FilledButton.icon(
                onPressed: _saving ? null : _handleSave,
                icon: _saving
                    ? const SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Icon(Icons.cloud_upload_outlined, size: 17, color: Colors.white),
                label: const Text('Save Changes to MongoDB'),
                style: FilledButton.styleFrom(backgroundColor: AppTheme.iconRed, foregroundColor: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Two live QR Cards side by side
          if (isMobile) ...[
            _buildQrCard(
              title: '1. Official Payment QR Code (FonePay / eSewa / Bank)',
              urlCtrl: _paymentQrCtrl,
              isUploading: _uploadingPaymentQr,
              onUpload: () => _pickAndUploadToCloudinary(
                targetField: 'paymentQrUrl',
                controller: _paymentQrCtrl,
                isPaymentQr: true,
              ),
            ),
            const SizedBox(height: 14),
            _buildWhatsappCard(),
          ] else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildQrCard(
                    title: '1. Official Payment QR Code (FonePay / eSewa)',
                    urlCtrl: _paymentQrCtrl,
                    isUploading: _uploadingPaymentQr,
                    onUpload: () => _pickAndUploadToCloudinary(
                      targetField: 'paymentQrUrl',
                      controller: _paymentQrCtrl,
                      isPaymentQr: true,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(child: _buildWhatsappCard()),
              ],
            ),
          const SizedBox(height: 20),

          // Digital Wallets & Bank Account Form
          Container(
            padding: const EdgeInsets.all(18),
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
                    Icon(Icons.account_balance_rounded, color: AppTheme.iconRed, size: 20),
                    SizedBox(width: 8),
                    Text('Digital Wallets & Bank Account Details', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                  ],
                ),
                const Divider(height: 20),
                if (isMobile) ...[
                  TextField(controller: _esewaCtrl, decoration: const InputDecoration(labelText: 'eSewa ID / Number')),
                  const SizedBox(height: 12),
                  TextField(controller: _khaltiCtrl, decoration: const InputDecoration(labelText: 'Khalti ID / Number')),
                  const SizedBox(height: 12),
                  TextField(controller: _fonepayCtrl, decoration: const InputDecoration(labelText: 'FonePay Merchant Name')),
                  const SizedBox(height: 12),
                  TextField(controller: _bankNameCtrl, decoration: const InputDecoration(labelText: 'Bank Name')),
                  const SizedBox(height: 12),
                  TextField(controller: _bankAccNameCtrl, decoration: const InputDecoration(labelText: 'Bank Account Name')),
                  const SizedBox(height: 12),
                  TextField(controller: _bankAccNumCtrl, decoration: const InputDecoration(labelText: 'Bank Account Number')),
                  const SizedBox(height: 12),
                  TextField(controller: _bankBranchCtrl, decoration: const InputDecoration(labelText: 'Bank Branch')),
                ] else ...[
                  Row(
                    children: [
                      Expanded(child: TextField(controller: _esewaCtrl, decoration: const InputDecoration(labelText: 'eSewa ID / Number'))),
                      const SizedBox(width: 12),
                      Expanded(child: TextField(controller: _khaltiCtrl, decoration: const InputDecoration(labelText: 'Khalti ID / Number'))),
                      const SizedBox(width: 12),
                      Expanded(child: TextField(controller: _fonepayCtrl, decoration: const InputDecoration(labelText: 'FonePay Merchant Name'))),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(child: TextField(controller: _bankNameCtrl, decoration: const InputDecoration(labelText: 'Bank Name'))),
                      const SizedBox(width: 12),
                      Expanded(child: TextField(controller: _bankAccNameCtrl, decoration: const InputDecoration(labelText: 'Bank Account Name'))),
                      const SizedBox(width: 12),
                      Expanded(child: TextField(controller: _bankAccNumCtrl, decoration: const InputDecoration(labelText: 'Bank Account Number'))),
                      const SizedBox(width: 12),
                      Expanded(child: TextField(controller: _bankBranchCtrl, decoration: const InputDecoration(labelText: 'Bank Branch'))),
                    ],
                  ),
                ],
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Icon(Icons.headset_mic_rounded, color: AppTheme.primaryColor, size: 19),
                    SizedBox(width: 8),
                    Text('Support Contacts & Address', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                  ],
                ),
                const Divider(height: 20),
                if (isMobile) ...[
                  TextField(controller: _emailCtrl, decoration: const InputDecoration(labelText: 'Support Email Address')),
                  const SizedBox(height: 12),
                  TextField(controller: _phoneCtrl, decoration: const InputDecoration(labelText: 'Support Phone / Helpline')),
                  const SizedBox(height: 12),
                  TextField(controller: _addressCtrl, decoration: const InputDecoration(labelText: 'Office Location / Address')),
                ] else
                  Row(
                    children: [
                      Expanded(child: TextField(controller: _emailCtrl, decoration: const InputDecoration(labelText: 'Support Email Address'))),
                      const SizedBox(width: 12),
                      Expanded(child: TextField(controller: _phoneCtrl, decoration: const InputDecoration(labelText: 'Support Phone / Helpline'))),
                      const SizedBox(width: 12),
                      Expanded(child: TextField(controller: _addressCtrl, decoration: const InputDecoration(labelText: 'Office Location / Address'))),
                    ],
                  ),
                const SizedBox(height: 16),
                TextField(
                  controller: _noteCtrl,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Candidate Payment Verification Instructions (shown on paywall modal)',
                    alignLabelWithHint: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrCard({
    required String title,
    required TextEditingController urlCtrl,
    required bool isUploading,
    required VoidCallback onUpload,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13.5)),
              ),
              FilledButton.icon(
                onPressed: isUploading ? null : onUpload,
                icon: isUploading
                    ? const SizedBox(width: 12, height: 12, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Icon(Icons.cloud_upload_rounded, size: 14),
                label: const Text('Upload Image', style: TextStyle(fontSize: 11)),
                style: FilledButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                ),
              ),
            ],
          ),
          const Divider(height: 16),
          Row(
            children: [
              Container(
                width: 100,
                height: 100,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppTheme.bgSurface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.divider),
                ),
                child: Image.network(
                  urlCtrl.text,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Center(
                    child: Icon(Icons.qr_code_2_rounded, size: 44, color: AppTheme.textMuted),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: urlCtrl,
                  decoration: const InputDecoration(labelText: 'Direct Image URL (Cloudinary / CDN)'),
                  onChanged: (_) => setState(() {}),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWhatsappCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.iconRed.withOpacity(0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text('2. Official WhatsApp Verification QR', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13.5)),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton.icon(
                    onPressed: _autoGenerateWhatsappQr,
                    icon: const Icon(Icons.auto_fix_high_rounded, size: 14, color: AppTheme.iconRed),
                    label: const Text('Auto-QR', style: TextStyle(fontSize: 11, color: AppTheme.iconRed, fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(width: 4),
                  FilledButton.icon(
                    onPressed: _uploadingWhatsappQr
                        ? null
                        : () => _pickAndUploadToCloudinary(
                              targetField: 'whatsappQrUrl',
                              controller: _whatsappQrCtrl,
                              isPaymentQr: false,
                            ),
                    icon: _uploadingWhatsappQr
                        ? const SizedBox(width: 12, height: 12, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : const Icon(Icons.cloud_upload_rounded, size: 14),
                    label: const Text('Upload', style: TextStyle(fontSize: 11)),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppTheme.iconRed,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(height: 16),
          Row(
            children: [
              Container(
                width: 100,
                height: 100,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppTheme.bgSurface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.divider),
                ),
                child: Image.network(
                  _whatsappQrCtrl.text,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Center(
                    child: Icon(Icons.qr_code_rounded, size: 44, color: AppTheme.iconRed),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  children: [
                    TextField(
                      controller: _whatsappNumCtrl,
                      decoration: const InputDecoration(labelText: 'WhatsApp Number (e.g. +977-9705419699)'),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _whatsappQrCtrl,
                      decoration: const InputDecoration(labelText: 'WhatsApp QR URL'),
                      onChanged: (_) => setState(() {}),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
