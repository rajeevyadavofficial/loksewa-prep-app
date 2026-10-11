import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';
import '../../data/models/models.dart';
import '../../data/repositories/providers.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuestionProvider>().loadAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final qp = context.watch<QuestionProvider>();
    final settings = qp.settings;
    final user = auth.user;
    final w = MediaQuery.of(context).size.width;
    final isNarrow = w < 850;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Choose Your Lok Sewa Pass'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppTheme.primaryColor),
          onPressed: () => context.go(AppConstants.routeDashboard),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: AppTheme.divider, width: 1)),
              ),
              padding: EdgeInsets.symmetric(vertical: isNarrow ? 28 : 40, horizontal: isNarrow ? 16 : 24),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppTheme.iconRedLight,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.workspace_premium_outlined, color: AppTheme.iconRed, size: 26),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'One Pass for All Lok Sewa Exams',
                    style: TextStyle(color: AppTheme.textPrimary, fontSize: isNarrow ? 22 : 28, fontWeight: FontWeight.w800, letterSpacing: -0.5),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Pay via QR / eSewa / Khalti / Bank & send screenshot to our Official WhatsApp. Admin will verify your screenshot and activate your plan.',
                    style: TextStyle(color: AppTheme.textMuted, fontSize: isNarrow ? 13.5 : 15),
                    textAlign: TextAlign.center,
                  ),
                  if (user != null) ...[
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 10,
                      runSpacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: user.plan == SubscriptionPlan.free ? AppTheme.bgSurface : AppTheme.iconRedLight,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: user.plan == SubscriptionPlan.free ? AppTheme.divider : AppTheme.iconRed.withOpacity(0.35),
                            ),
                          ),
                          child: Text(
                            user.plan == SubscriptionPlan.free
                                ? 'Active Plan: FREE'
                                : 'Active Plan: PRO (रू 199)${user.planExpiresAt != null ? " • Expires: ${user.planExpiresAt!.toLocal().toString().split(' ').first}" : ""}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: user.plan == SubscriptionPlan.free ? AppTheme.textPrimary : AppTheme.iconRedDark,
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        OutlinedButton.icon(
                          onPressed: () async {
                            await context.read<AuthProvider>().refreshUserProfile();
                            if (context.mounted) {
                              final updatedUser = context.read<AuthProvider>().user;
                              final updatedPlan = (updatedUser == null || updatedUser.plan == SubscriptionPlan.free) ? 'FREE' : 'PRO';
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Synced latest plan from server: $updatedPlan'),
                                  backgroundColor: AppTheme.primaryColor,
                                ),
                              );
                            }
                          },
                          icon: const Icon(Icons.sync_rounded, size: 15, color: AppTheme.iconRed),
                          label: const Text('Check Verification Status', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isNarrow ? 14 : 60, vertical: isNarrow ? 24 : 40),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 960),
                child: Column(
                  children: [
                    isNarrow
                        ? Column(children: _buildPlans(context, user, settings))
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _buildPlans(context, user, settings).map((w) => w is SizedBox ? w : Expanded(child: w)).toList(),
                          ),
                    const SizedBox(height: 36),
                    _PaymentAndWhatsAppVerificationHub(settings: settings, isNarrow: isNarrow),
                    const SizedBox(height: 32),
                    _ComparisonTable(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPlans(BuildContext context, AppUser? user, AppSettings settings) {
    final isProUser = user != null && user.plan != SubscriptionPlan.free;
    return [
      _FullPlanCard(
        plan: SubscriptionPlan.free,
        name: 'Free Starter',
        price: 'नि:शुल्क',
        priceSub: 'Forever free',
        monthlyPrice: 0,
        features: const [
          ('Enroll in Your Target Lok Sewa Exam', true),
          ('Official Syllabus Access', true),
          ('Free Preview Model Answers', true),
          ('1 Timed Mock Test', true),
          ('Paper I Complete Access', false),
          ('Paper II & III Complete Access', false),
          ('All Questions Unlocked', false),
        ],
        isCurrentPlan: user?.plan == SubscriptionPlan.free,
        isPopular: false,
        onSelect: (_) {},
      ),
      const SizedBox(width: 24, height: 20),
      _FullPlanCard(
        plan: SubscriptionPlan.premium,
        name: 'Pro Plan',
        price: 'रू १९९',
        priceSub: 'full exam pass',
        monthlyPrice: 199,
        features: const [
          ('Full Access to Your Enrolled Exam', true),
          ('Paper I + Paper II + Paper III Unlocked', true),
          ('All Questions Unlocked', true),
          ('Unlimited Timed Mock Tests', true),
          ('Detailed Score Analytics', true),
          ('Syllabus Deep Dive', true),
          ('Priority WhatsApp Support', true),
        ],
        isCurrentPlan: isProUser,
        isPopular: true,
        onSelect: (plan) => _onUpgrade(context, plan, user, settings),
      ),
    ];
  }

  void _onUpgrade(BuildContext context, SubscriptionPlan plan, AppUser? user, AppSettings settings) {
    if (user == null) {
      GoRouter.of(context).go(AppConstants.routeLogin);
      return;
    }
    showDialog(
      context: context,
      builder: (_) => _PaymentVerificationDialog(plan: plan, settings: settings, user: user),
    );
  }
}

class _FullPlanCard extends StatelessWidget {
  final SubscriptionPlan plan;
  final String name, price, priceSub;
  final double monthlyPrice;
  final List<(String, bool)> features;
  final bool isCurrentPlan, isPopular;
  final ValueChanged<SubscriptionPlan> onSelect;

  const _FullPlanCard({
    required this.plan, required this.name, required this.price, required this.priceSub,
    required this.monthlyPrice, required this.features, required this.isCurrentPlan,
    required this.isPopular, required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isPopular ? AppTheme.iconRed : AppTheme.divider,
          width: isPopular ? 1.8 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color: isPopular ? AppTheme.iconRed : AppTheme.textPrimary,
                ),
              ),
              const Spacer(),
              if (isPopular)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.iconRedLight,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text('Most Popular', style: TextStyle(color: AppTheme.iconRed, fontWeight: FontWeight.w800, fontSize: 10.5)),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            price,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
          ),
          Text(priceSub, style: const TextStyle(color: AppTheme.textMuted, fontSize: 12)),
          const SizedBox(height: 20),
          ...features.map((f) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Icon(
                  f.$2 ? Icons.check_circle_outline_rounded : Icons.remove_circle_outline_rounded,
                  size: 16,
                  color: f.$2
                      ? (isPopular ? AppTheme.iconRed : AppTheme.primaryColor)
                      : AppTheme.divider,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    f.$1,
                    style: TextStyle(
                      fontSize: 13,
                      color: f.$2 ? AppTheme.textBody : AppTheme.textMuted,
                    ),
                  ),
                ),
              ],
            ),
          )),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: isCurrentPlan
                ? Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.divider),
                    ),
                    child: const Center(
                      child: Text('Current Plan ✓', style: TextStyle(color: AppTheme.textMuted, fontWeight: FontWeight.w700)),
                    ),
                  )
                : FilledButton.icon(
                    onPressed: plan == SubscriptionPlan.free ? null : () => onSelect(plan),
                    icon: const Icon(Icons.qr_code_scanner_rounded, size: 17, color: Colors.white),
                    label: Text(
                      plan == SubscriptionPlan.free ? 'Your Free Plan' : 'Pay & Verify via WhatsApp',
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: isPopular ? AppTheme.iconRed : AppTheme.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

// ─── Payment QR + WhatsApp Screenshot Verification Hub ────────
class _PaymentAndWhatsAppVerificationHub extends StatelessWidget {
  final AppSettings settings;
  final bool isNarrow;
  const _PaymentAndWhatsAppVerificationHub({required this.settings, required this.isNarrow});

  void _copy(BuildContext context, String label, String value) {
    Clipboard.setData(ClipboardData(text: value));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied $label: $value'),
        backgroundColor: AppTheme.primaryColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isNarrow ? 16 : 28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.divider, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.iconRedLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.verified_user_outlined, color: AppTheme.iconRed, size: 22),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment & WhatsApp Screenshot Verification',
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: AppTheme.textPrimary),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Step 1: Pay via Payment QR / Wallet / Bank  →  Step 2: Send Screenshot to WhatsApp Number or Scan WhatsApp QR',
                      style: TextStyle(fontSize: 12.5, color: AppTheme.textMuted),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 28, color: AppTheme.divider),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppTheme.iconRedLight.withOpacity(0.45),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.iconRed.withOpacity(0.3)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info_outline_rounded, color: AppTheme.iconRed, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    settings.verificationNote,
                    style: const TextStyle(fontSize: 13, height: 1.5, color: AppTheme.textPrimary, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          isNarrow
              ? Column(
                  children: [
                    _qrBox(
                      title: '1. Official Payment QR Code',
                      subtitle: 'Scan with eSewa, Khalti, FonePay or Mobile Banking',
                      qrUrl: settings.paymentQrUrl,
                      icon: Icons.qr_code_2_rounded,
                      isRed: false,
                    ),
                    const SizedBox(height: 16),
                    _qrBox(
                      title: '2. Official WhatsApp QR Code',
                      subtitle: 'Scan to connect & send your payment screenshot',
                      qrUrl: settings.whatsappQrUrl,
                      icon: Icons.chat_bubble_outline_rounded,
                      isRed: true,
                      badgeText: 'WhatsApp: ${settings.whatsappNumber}',
                    ),
                    const SizedBox(height: 16),
                    _detailsColumn(context),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: _qrBox(
                        title: '1. Official Payment QR Code',
                        subtitle: 'Scan with eSewa, Khalti, FonePay or Mobile Banking',
                        qrUrl: settings.paymentQrUrl,
                        icon: Icons.qr_code_2_rounded,
                        isRed: false,
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      flex: 4,
                      child: _qrBox(
                        title: '2. Official WhatsApp QR Code',
                        subtitle: 'Scan to connect & send your payment screenshot',
                        qrUrl: settings.whatsappQrUrl,
                        icon: Icons.chat_bubble_outline_rounded,
                        isRed: true,
                        badgeText: 'WhatsApp: ${settings.whatsappNumber}',
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(flex: 5, child: _detailsColumn(context)),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _qrBox({
    required String title,
    required String subtitle,
    required String qrUrl,
    required IconData icon,
    required bool isRed,
    String? badgeText,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isRed ? AppTheme.iconRed.withOpacity(0.45) : AppTheme.divider,
          width: isRed ? 1.4 : 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 17, color: isRed ? AppTheme.iconRed : AppTheme.primaryColor),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13.5, color: AppTheme.textPrimary),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 11.5, color: AppTheme.textMuted),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 14),
          Container(
            width: 175,
            height: 175,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.divider),
            ),
            child: qrUrl.isNotEmpty
                ? Image.network(
                    qrUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const Center(
                      child: Icon(Icons.qr_code_2_rounded, size: 96, color: AppTheme.primaryColor),
                    ),
                  )
                : const Center(
                    child: Icon(Icons.qr_code_2_rounded, size: 96, color: AppTheme.primaryColor),
                  ),
          ),
          if (badgeText != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppTheme.iconRedLight,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                badgeText,
                style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800, color: AppTheme.iconRedDark),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _detailsColumn(BuildContext context) {
    return Container(
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
              Icon(Icons.contact_phone_outlined, size: 17, color: AppTheme.iconRed),
              SizedBox(width: 8),
              Text('Account & Contact Details', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: AppTheme.textPrimary)),
            ],
          ),
          const Divider(height: 18, color: AppTheme.divider),
          _infoRow(context, Icons.chat_outlined, 'WhatsApp Verification No.', settings.whatsappNumber, isRed: true),
          _infoRow(context, Icons.link_rounded, 'WhatsApp Direct Link', settings.whatsappLink, isRed: false),
          _infoRow(context, Icons.phone_android_rounded, 'eSewa ID', settings.esewaId, isRed: true),
          _infoRow(context, Icons.account_balance_wallet_outlined, 'Khalti ID', settings.khaltiId, isRed: false),
          _infoRow(context, Icons.account_balance_outlined, settings.bankName, '${settings.bankAccountNumber} (${settings.bankAccountName})', isRed: true),
          _infoRow(context, Icons.email_outlined, 'Support Email', settings.supportEmail, isRed: false),
          _infoRow(context, Icons.call_outlined, 'Helpline / Office', '${settings.supportPhone} • ${settings.officeAddress}', isRed: false),
        ],
      ),
    );
  }

  Widget _infoRow(BuildContext context, IconData icon, String label, String value, {required bool isRed}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 15, color: isRed ? AppTheme.iconRed : AppTheme.primaryColor),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 11, color: AppTheme.textMuted, fontWeight: FontWeight.w600)),
                Text(value, style: const TextStyle(fontSize: 12.5, color: AppTheme.textPrimary, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.copy_rounded, size: 14, color: AppTheme.textMuted),
            tooltip: 'Copy $label',
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () => _copy(context, label, value),
          ),
        ],
      ),
    );
  }
}

// ─── Interactive Payment & WhatsApp Screenshot Dialog ─────────
class _PaymentVerificationDialog extends StatefulWidget {
  final SubscriptionPlan plan;
  final AppSettings settings;
  final AppUser user;

  const _PaymentVerificationDialog({
    required this.plan,
    required this.settings,
    required this.user,
  });

  @override
  State<_PaymentVerificationDialog> createState() => _PaymentVerificationDialogState();
}

class _PaymentVerificationDialogState extends State<_PaymentVerificationDialog> {
  String _selectedMethod = 'esewa';
  final _refCtrl = TextEditingController();

  @override
  void dispose() {
    _refCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.settings;
    const price = 'रू 199';
    final isMobile = MediaQuery.of(context).size.width < 580;

    final qrStep1 = Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.divider),
      ),
      child: Column(
        children: [
          const Text('Step 1: Payment QR', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
          const SizedBox(height: 8),
          SizedBox(
            height: 130,
            width: 130,
            child: Image.network(
              s.paymentQrUrl,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Icon(Icons.qr_code_2_rounded, size: 80),
            ),
          ),
          const SizedBox(height: 6),
          Text('eSewa: ${s.esewaId}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
        ],
      ),
    );

    final qrStep2 = Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.iconRed.withOpacity(0.45)),
      ),
      child: Column(
        children: [
          const Text('Step 2: WhatsApp QR', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12, color: AppTheme.iconRed)),
          const SizedBox(height: 8),
          SizedBox(
            height: 130,
            width: 130,
            child: Image.network(
              s.whatsappQrUrl,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Icon(Icons.qr_code_rounded, size: 80, color: AppTheme.iconRed),
            ),
          ),
          const SizedBox(height: 6),
          Text('WA: ${s.whatsappNumber}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppTheme.iconRedDark)),
        ],
      ),
    );

    final methodDropdown = DropdownButtonFormField<String>(
      value: _selectedMethod,
      decoration: const InputDecoration(labelText: 'Payment Method Used'),
      items: const [
        DropdownMenuItem(value: 'esewa', child: Text('eSewa Wallet')),
        DropdownMenuItem(value: 'khalti', child: Text('Khalti Wallet')),
        DropdownMenuItem(value: 'fonepay', child: Text('FonePay QR')),
        DropdownMenuItem(value: 'bank', child: Text('Bank Transfer')),
      ],
      onChanged: (v) => setState(() => _selectedMethod = v!),
    );

    final refField = TextField(
      controller: _refCtrl,
      decoration: const InputDecoration(
        labelText: 'Transaction Code / WhatsApp Sent Note',
        hintText: 'e.g. Sent screenshot on WhatsApp',
      ),
    );

    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: isMobile ? 14 : 40, vertical: 20),
      title: const Row(
        children: [
          Icon(Icons.verified_outlined, color: AppTheme.iconRed, size: 22),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Upgrade to PRO Plan ($price)',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16.5),
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: 560,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.iconRedLight,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.iconRed.withOpacity(0.35)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.chat_bubble_outline_rounded, size: 15, color: AppTheme.iconRed),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            'WhatsApp Screenshot Verification Required',
                            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12.5, color: AppTheme.iconRedDark),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '1. Scan the Payment QR (or transfer रू 199 to eSewa: ${s.esewaId} / Khalti: ${s.khaltiId})\n'
                      '2. Send your payment screenshot + your email (${widget.user.email}) to WhatsApp: ${s.whatsappNumber} or scan the WhatsApp QR below.',
                      style: const TextStyle(fontSize: 12, color: AppTheme.textPrimary, height: 1.45),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              if (isMobile)
                Column(
                  children: [
                    qrStep1,
                    const SizedBox(height: 12),
                    qrStep2,
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(child: qrStep1),
                    const SizedBox(width: 12),
                    Expanded(child: qrStep2),
                  ],
                ),
              const SizedBox(height: 16),
              if (isMobile)
                Column(
                  children: [
                    methodDropdown,
                    const SizedBox(height: 12),
                    refField,
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(child: methodDropdown),
                    const SizedBox(width: 12),
                    Expanded(child: refField),
                  ],
                ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.copy_rounded, size: 14, color: AppTheme.iconRed),
                  const SizedBox(width: 6),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: s.whatsappNumber));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Copied WhatsApp Number: ${s.whatsappNumber}')),
                        );
                      },
                      child: Text(
                        'Click to Copy WhatsApp Number (${s.whatsappNumber})',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppTheme.iconRed, decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel', style: TextStyle(color: AppTheme.textMuted)),
        ),
        FilledButton.icon(
          style: FilledButton.styleFrom(backgroundColor: AppTheme.iconRed, foregroundColor: Colors.white),
          icon: const Icon(Icons.send_rounded, size: 16, color: Colors.white),
          label: Text(isMobile ? 'Submit Verification Request' : 'I Sent Screenshot on WhatsApp — Request Verification'),
          onPressed: () async {
            final submitted = await context.read<AuthProvider>().upgradePlan(
                  SubscriptionPlan.premium,
                  method: _selectedMethod,
                  transactionRef: _refCtrl.text.trim(),
                );
            if (mounted) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 5),
                  content: Text(
                    submitted
                        ? 'Verification request submitted! Admin will verify your WhatsApp screenshot and activate your PRO Plan (रू 199).'
                        : 'Please log in first to submit a payment verification request.',
                  ),
                  backgroundColor: submitted ? AppTheme.primaryColor : AppTheme.iconRed,
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

class _ComparisonTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Free vs Pro Plan Comparison', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppTheme.textPrimary)),
        const SizedBox(height: 16),
        Table(
          border: TableBorder.all(color: AppTheme.divider),
          columnWidths: const {0: FlexColumnWidth(3), 1: FlexColumnWidth(1.2), 2: FlexColumnWidth(1.2)},
          children: [
            TableRow(
              decoration: const BoxDecoration(color: Color(0xFFF4F4F5)),
              children: ['Feature', 'Free Starter', 'Pro Plan (रू १९९)'].map((h) =>
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(h, style: const TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.w800, fontSize: 12.5)),
                ),
              ).toList(),
            ),
            ...[
              ('Enrolled Exam Materials', 'Included', 'Included'),
              ('Model Answers', 'Free Previews', 'All Questions Unlocked'),
              ('Mock Tests', '1 Test', 'Unlimited'),
              ('Paper I Access', 'Preview', 'Full Access'),
              ('Paper II & III Access', 'Locked', 'Full Access'),
              ('Bilingual (Nepali/EN)', 'Included', 'Included'),
              ('Official Syllabus', 'Included', 'Included'),
              ('Price', 'Free', 'रू १९९'),
            ].map((row) => TableRow(
              decoration: const BoxDecoration(color: Colors.white),
              children: [row.$1, row.$2, row.$3].map((c) =>
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Text(c, style: const TextStyle(fontSize: 12.5, color: AppTheme.textBody)),
                ),
              ).toList(),
            )),
          ],
        ),
      ],
    );
  }
}
