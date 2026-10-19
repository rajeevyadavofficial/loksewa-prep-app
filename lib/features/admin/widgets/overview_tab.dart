import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import 'expiry_duration_dialog.dart';
import 'photo_preview_dialog.dart';

class AdminOverviewTab extends StatelessWidget {
  final Map<String, dynamic>? stats;
  final VoidCallback onAddExam;
  final VoidCallback onAddQuestion;
  final VoidCallback onNavigateToPayments;
  final VoidCallback onNavigateToQuestions;
  final VoidCallback onNavigateToSettings;
  final Future<void> Function(String paymentId, String action, Map<String, dynamic>? expiry) onVerifyPayment;
  final Future<void> Function(String donationId, String action) onVerifyDonation;
  final Future<void> Function(String paymentId, [String? detail])? onDeletePayment;

  const AdminOverviewTab({
    super.key,
    required this.stats,
    required this.onAddExam,
    required this.onAddQuestion,
    required this.onNavigateToPayments,
    required this.onNavigateToQuestions,
    required this.onNavigateToSettings,
    required this.onVerifyPayment,
    required this.onVerifyDonation,
    this.onDeletePayment,
  });

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final isMobile = screenW < 700;

    final dbMode = stats?['databaseMode'] ?? 'MongoDB Atlas Cloud';
    final totalUsers = stats?['totalUsers'] ?? 0;
    final freeCount = stats?['freeCount'] ?? 0;
    final premiumCount = stats?['premiumCount'] ?? 0;
    final totalRevenue = stats?['totalRevenue'] ?? 0;
    final totalExams = stats?['totalExams'] ?? 0;
    final totalQuestions = stats?['totalQuestions'] ?? 0;

    final pendingPayments = (stats?['pendingPayments'] as List<dynamic>?) ?? [];
    final pendingDonations = (stats?['pendingDonations'] as List<dynamic>?) ?? [];
    final recentPayments = (stats?['recentPayments'] as List<dynamic>?) ?? [];

    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 14 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top bar with database status & quick actions
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.divider),
            ),
            child: Wrap(
              spacing: 12,
              runSpacing: 10,
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppTheme.iconRedLight,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(Icons.cloud_done_rounded, color: AppTheme.iconRed, size: 18),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Database Engine', style: TextStyle(fontSize: 11, color: AppTheme.textMuted)),
                        Text(
                          '$dbMode',
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppTheme.textPrimary),
                        ),
                      ],
                    ),
                  ],
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    OutlinedButton.icon(
                      onPressed: onNavigateToSettings,
                      icon: const Icon(Icons.qr_code_2_rounded, size: 16, color: AppTheme.iconRed),
                      label: const Text('QR Setup'),
                    ),
                    OutlinedButton.icon(
                      onPressed: onAddExam,
                      icon: const Icon(Icons.add_rounded, size: 16, color: AppTheme.primaryColor),
                      label: const Text('Add Exam'),
                    ),
                    FilledButton.icon(
                      onPressed: onAddQuestion,
                      icon: const Icon(Icons.post_add_rounded, size: 16, color: Colors.white),
                      label: const Text('Add Question'),
                      style: FilledButton.styleFrom(backgroundColor: AppTheme.iconRed, foregroundColor: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 4 Metric Stat Cards
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: screenW > 900 ? 4 : (isMobile ? 2 : 2),
            childAspectRatio: isMobile ? 1.35 : 1.7,
            crossAxisSpacing: isMobile ? 10 : 16,
            mainAxisSpacing: isMobile ? 10 : 16,
            children: [
              _buildStatCard(
                title: 'Total Revenue',
                value: 'रू $totalRevenue',
                subtitle: 'Pro Subscriptions',
                icon: Icons.payments_rounded,
                isHighlight: true,
              ),
              _buildStatCard(
                title: 'Pending Reviews',
                value: '${pendingPayments.length + pendingDonations.length}',
                subtitle: '${pendingPayments.length} Pay • ${pendingDonations.length} Donate',
                icon: Icons.pending_actions_rounded,
                isHighlight: (pendingPayments.isNotEmpty || pendingDonations.isNotEmpty),
              ),
              _buildStatCard(
                title: 'Registered Users',
                value: '$totalUsers',
                subtitle: '$premiumCount Pro • $freeCount Free',
                icon: Icons.people_alt_rounded,
                isHighlight: false,
              ),
              _buildStatCard(
                title: 'Course Content',
                value: '$totalQuestions',
                subtitle: '$totalExams Loksewa Exams',
                icon: Icons.menu_book_rounded,
                isHighlight: false,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Action queue: Pending Payments
          if (pendingPayments.isNotEmpty) ...[
            _buildSectionHeader(
              title: 'Pending WhatsApp Payment Verifications',
              count: pendingPayments.length,
              icon: Icons.verified_user_rounded,
              color: AppTheme.iconRed,
            ),
            const SizedBox(height: 10),
            ...pendingPayments.map((p) => _buildPaymentCard(context, p)),
            const SizedBox(height: 20),
          ],

          // Action queue: Pending Question Donations
          if (pendingDonations.isNotEmpty) ...[
            _buildSectionHeader(
              title: 'Pending Contributed Questions (Donate & Earn)',
              count: pendingDonations.length,
              icon: Icons.volunteer_activism_rounded,
              color: AppTheme.primaryColor,
            ),
            const SizedBox(height: 10),
            ...pendingDonations.map((d) => _buildDonationCard(context, d)),
            const SizedBox(height: 20),
          ],

          // If no pending items
          if (pendingPayments.isEmpty && pendingDonations.isEmpty) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.divider),
              ),
              child: const Row(
                children: [
                  Icon(Icons.check_circle_outline_rounded, color: Colors.green, size: 28),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Everything is up to date!', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                        SizedBox(height: 2),
                        Text('No pending payments or candidate questions require verification.', style: TextStyle(color: AppTheme.textMuted, fontSize: 13)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],

          // Recent Payments History Table
          Container(
            padding: EdgeInsets.all(isMobile ? 14 : 20),
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
                    const Text('Recent Payment Records', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                    TextButton(
                      onPressed: onNavigateToPayments,
                      child: const Text('View All', style: TextStyle(color: AppTheme.iconRed, fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
                const Divider(height: 16),
                if (recentPayments.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Text('No payment logs available yet.', style: TextStyle(color: AppTheme.textMuted)),
                  )
                else
                  ...recentPayments.take(8).map((p) {
                    final status = p['status']?.toString() ?? 'completed';
                    final isPending = status == 'pending';
                    final isRejected = status == 'rejected';
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        isPending
                            ? Icons.hourglass_top_rounded
                            : (isRejected ? Icons.cancel_outlined : Icons.verified_rounded),
                        color: isPending || isRejected ? AppTheme.iconRed : Colors.green,
                      ),
                      title: Text(
                        '${p['userName']} • ${p['userEmail']}',
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5),
                      ),
                      subtitle: Text(
                        'Method: ${p['method']?.toString().toUpperCase()} • Ref: ${p['transactionRef']}',
                        style: const TextStyle(fontSize: 12, color: AppTheme.textMuted),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: isPending
                                  ? AppTheme.iconRedLight
                                  : (isRejected ? Colors.grey.shade200 : Colors.green.shade50),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              status.toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: isPending
                                    ? AppTheme.iconRedDark
                                    : (isRejected ? Colors.grey.shade700 : Colors.green.shade800),
                              ),
                            ),
                          ),
                          Text(
                            'रू ${p['amount']}',
                            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                          ),
                          const SizedBox(width: 4),
                          IconButton(
                            icon: const Icon(Icons.delete_outline_rounded, color: Colors.grey, size: 18),
                            hoverColor: AppTheme.iconRedLight,
                            tooltip: 'Delete Fake/Test Transaction',
                            onPressed: () {
                              final payId = p['_id']?.toString() ?? '';
                              if (payId.isNotEmpty) {
                                onDeletePayment?.call(payId, '${p['userName']} (रू ${p['amount']})');
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required bool isHighlight,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isHighlight ? AppTheme.iconRed : AppTheme.divider,
          width: isHighlight ? 1.5 : 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 12.5, color: AppTheme.textMuted, fontWeight: FontWeight.w600)),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: isHighlight ? AppTheme.iconRedLight : AppTheme.bgSurface,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(icon, color: isHighlight ? AppTheme.iconRed : AppTheme.primaryColor, size: 16),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
          ),
          const SizedBox(height: 2),
          Text(subtitle, style: const TextStyle(fontSize: 11.5, color: AppTheme.textMuted)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required int count,
    required IconData icon,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15.5)),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: AppTheme.iconRedLight,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            '$count Action Required',
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppTheme.iconRedDark),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentCard(BuildContext context, dynamic p) {
    final payId = p['_id']?.toString() ?? '';
    final planName = (p['plan']?.toString() ?? 'pro').toUpperCase();
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
              Text(
                '${p['userName']} (${p['userEmail']})',
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: AppTheme.textPrimary),
              ),
              const SizedBox(height: 3),
              Text(
                'Requested: $planName (रू ${p['amount']}) via ${p['method']?.toString().toUpperCase()} • Note: "${p['transactionRef']}"',
                style: const TextStyle(fontSize: 12, color: AppTheme.textMuted),
              ),
            ],
          ),
          Wrap(
            spacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded, color: AppTheme.iconRed, size: 20),
                tooltip: 'Delete Fake/Test Transaction',
                onPressed: () => onDeletePayment?.call(payId, '${p['userName']} (रू ${p['amount']})'),
              ),
              OutlinedButton(
                onPressed: () => onVerifyPayment(payId, 'reject', null),
                child: const Text('Reject', style: TextStyle(color: AppTheme.iconRed, fontSize: 12, fontWeight: FontWeight.w700)),
              ),
              FilledButton.icon(
                onPressed: () async {
                  final expiry = await ExpiryDurationDialog.show(
                    context,
                    title: 'Verify Payment & Activate Pro Plan',
                  );
                  if (expiry != null) {
                    onVerifyPayment(payId, 'approve', expiry);
                  }
                },
                icon: const Icon(Icons.check_circle_outline_rounded, size: 15, color: Colors.white),
                label: Text('Verify & Activate ($planName)', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                style: FilledButton.styleFrom(backgroundColor: AppTheme.iconRed, foregroundColor: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDonationCard(BuildContext context, dynamic d) {
    final donId = d['_id']?.toString() ?? '';
    final qPhoto = (d['question_photo_url'] ?? '').toString();
    final aPhoto = (d['answer_photo_url'] ?? '').toString();
    final qText = d['question_nepali'] ?? d['question_english'] ?? '';
    final ansPreview = d['type'] == 'mcq'
        ? 'Options: ${(d['options'] as List<dynamic>? ?? []).join(" | ")}'
        : (d['answer_nepali'] ?? d['answer_english'] ?? '');

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.bgSurface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${d['userName']} (${d['userEmail']})',
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13.5),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppTheme.iconRedLight,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${d['exam_id']} • ${d['type']?.toString().toUpperCase()} • ${d['marks'] ?? 5}M',
                  style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w800, color: AppTheme.iconRedDark),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text('Q: $qText', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
          if (ansPreview.isNotEmpty) ...[
            const SizedBox(height: 3),
            Text('Ans: $ansPreview', maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: AppTheme.textMuted)),
          ],
          if (qPhoto.isNotEmpty || aPhoto.isNotEmpty) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                if (qPhoto.isNotEmpty)
                  OutlinedButton.icon(
                    onPressed: () => PhotoPreviewDialog.show(context, title: 'Question Photo', imageUrl: qPhoto),
                    icon: const Icon(Icons.image_outlined, size: 14, color: AppTheme.iconRed),
                    label: const Text('Inspect Question Photo', style: TextStyle(fontSize: 11, color: AppTheme.iconRed, fontWeight: FontWeight.w700)),
                  ),
                if (aPhoto.isNotEmpty)
                  OutlinedButton.icon(
                    onPressed: () => PhotoPreviewDialog.show(context, title: 'Answer Photo', imageUrl: aPhoto),
                    icon: const Icon(Icons.fact_check_outlined, size: 14),
                    label: const Text('Inspect Answer Photo', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
                  ),
              ],
            ),
          ],
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: () => onVerifyDonation(donId, 'reject'),
                child: const Text('Reject', style: TextStyle(color: AppTheme.iconRed, fontSize: 12)),
              ),
              const SizedBox(width: 8),
              FilledButton.icon(
                onPressed: () => onVerifyDonation(donId, 'approve'),
                icon: const Icon(Icons.check_circle_outline_rounded, size: 15, color: Colors.white),
                label: const Text('Verify & Publish (+रू 0.05)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                style: FilledButton.styleFrom(backgroundColor: AppTheme.iconRed, foregroundColor: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
