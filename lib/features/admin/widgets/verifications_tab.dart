import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import 'expiry_duration_dialog.dart';
import 'photo_preview_dialog.dart';

class VerificationsTab extends StatefulWidget {
  final Map<String, dynamic>? stats;
  final Future<void> Function(String paymentId, String action, Map<String, dynamic>? expiry) onVerifyPayment;
  final Future<void> Function(String donationId, String action) onVerifyDonation;
  final Future<void> Function(String paymentId, [String? detail])? onDeletePayment;

  const VerificationsTab({
    super.key,
    required this.stats,
    required this.onVerifyPayment,
    required this.onVerifyDonation,
    this.onDeletePayment,
  });

  @override
  State<VerificationsTab> createState() => _VerificationsTabState();
}

class _VerificationsTabState extends State<VerificationsTab> {
  int _paymentSubFilter = 0; // 0: Pending Verifications, 1: All Transaction Records

  @override
  Widget build(BuildContext context) {
    final pendingPayments = (widget.stats?['pendingPayments'] as List<dynamic>?) ?? [];
    final recentPayments = (widget.stats?['recentPayments'] as List<dynamic>?) ?? [];
    final pendingDonations = (widget.stats?['pendingDonations'] as List<dynamic>?) ?? [];
    final isMobile = MediaQuery.of(context).size.width < 750;

    return DefaultTabController(
      length: 2,
      child: Padding(
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
                      'Verification & Approvals Hub',
                      style: TextStyle(
                        fontSize: isMobile ? 18 : 21,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      'Review WhatsApp payment screenshots to activate candidate accounts, manage transactions, and inspect contributed questions.',
                      style: TextStyle(color: AppTheme.textMuted, fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Tab bar
            Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: AppTheme.divider, width: 1)),
              ),
              child: TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                labelColor: AppTheme.iconRed,
                unselectedLabelColor: AppTheme.textMuted,
                indicatorColor: AppTheme.iconRed,
                labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                tabs: [
                  Tab(
                    child: Row(
                      children: [
                        const Text('Payments & Transactions'),
                        const SizedBox(width: 8),
                        if (pendingPayments.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
                            decoration: BoxDecoration(
                              color: AppTheme.iconRed,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '${pendingPayments.length}',
                              style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      children: [
                        const Text('Candidate Question Submissions'),
                        const SizedBox(width: 8),
                        if (pendingDonations.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '${pendingDonations.length}',
                              style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: TabBarView(
                children: [
                  // Payments View with Sub-Filter
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Sub filter selector
                      Wrap(
                        spacing: 8,
                        children: [
                          ChoiceChip(
                            label: Text('Pending Approval (${pendingPayments.length})'),
                            selected: _paymentSubFilter == 0,
                            selectedColor: AppTheme.iconRedLight,
                            labelStyle: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: _paymentSubFilter == 0 ? AppTheme.iconRedDark : AppTheme.textBody,
                            ),
                            onSelected: (val) {
                              if (val) setState(() => _paymentSubFilter = 0);
                            },
                          ),
                          ChoiceChip(
                            label: Text('All Transaction Logs (${recentPayments.length})'),
                            selected: _paymentSubFilter == 1,
                            selectedColor: AppTheme.iconRedLight,
                            labelStyle: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: _paymentSubFilter == 1 ? AppTheme.iconRedDark : AppTheme.textBody,
                            ),
                            onSelected: (val) {
                              if (val) setState(() => _paymentSubFilter = 1);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: _paymentSubFilter == 0
                            ? (pendingPayments.isEmpty
                                ? _buildEmptyState('No pending payment verifications at this time.')
                                : ListView.builder(
                                    itemCount: pendingPayments.length,
                                    itemBuilder: (ctx, i) => _buildPaymentItem(context, pendingPayments[i]),
                                  ))
                            : (recentPayments.isEmpty
                                ? _buildEmptyState('No payment transaction records found.')
                                : ListView.builder(
                                    itemCount: recentPayments.length,
                                    itemBuilder: (ctx, i) => _buildPaymentItem(context, recentPayments[i]),
                                  )),
                      ),
                    ],
                  ),

                  // Donations View
                  pendingDonations.isEmpty
                      ? _buildEmptyState('No pending candidate question submissions to review.')
                      : ListView.builder(
                          itemCount: pendingDonations.length,
                          itemBuilder: (ctx, i) => _buildDonationItem(context, pendingDonations[i]),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(String msg) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.divider),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle_outline_rounded, color: Colors.green, size: 40),
          const SizedBox(height: 10),
          Text(msg, style: const TextStyle(fontWeight: FontWeight.w700, color: AppTheme.textBody)),
        ],
      ),
    );
  }

  Widget _buildPaymentItem(BuildContext context, dynamic p) {
    final payId = p['_id']?.toString() ?? '';
    final plan = (p['plan']?.toString() ?? 'pro').toUpperCase();
    final status = p['status']?.toString() ?? 'pending';
    final isPending = status == 'pending';
    final isCompleted = status == 'completed';
    final isRejected = status == 'rejected';
    final userName = p['userName']?.toString() ?? 'Candidate';
    final userEmail = p['userEmail']?.toString() ?? '';
    final amount = p['amount']?.toString() ?? '0';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isPending ? AppTheme.iconRed.withOpacity(0.4) : AppTheme.divider,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '$userName ($userEmail)',
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    margin: const EdgeInsets.only(right: 6),
                    decoration: BoxDecoration(
                      color: isPending
                          ? AppTheme.iconRedLight
                          : (isRejected ? Colors.grey.shade200 : Colors.green.shade50),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      status.toUpperCase(),
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        color: isPending
                            ? AppTheme.iconRedDark
                            : (isRejected ? Colors.grey.shade700 : Colors.green.shade800),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppTheme.iconRedLight,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'PLAN: $plan (रू $amount)',
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppTheme.iconRedDark),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Method: ${p['method']?.toString().toUpperCase()} • Transaction Ref: "${p['transactionRef']}"',
            style: const TextStyle(fontSize: 12.5, color: AppTheme.textMuted),
          ),
          const SizedBox(height: 12),
          if (isPending)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.delete_outline_rounded, color: AppTheme.iconRed, size: 20),
                  tooltip: 'Delete Fake/Test Transaction',
                  onPressed: () => widget.onDeletePayment?.call(payId, '$userName (रू $amount)'),
                ),
                const SizedBox(width: 4),
                OutlinedButton(
                  onPressed: () => widget.onVerifyPayment(payId, 'reject', null),
                  child: const Text('Reject', style: TextStyle(color: AppTheme.iconRed)),
                ),
                const SizedBox(width: 8),
                FilledButton.icon(
                  onPressed: () async {
                    final expiry = await ExpiryDurationDialog.show(
                      context,
                      title: 'Verify Payment & Activate Pro Plan',
                    );
                    if (expiry != null) {
                      widget.onVerifyPayment(payId, 'approve', expiry);
                    }
                  },
                  icon: const Icon(Icons.check_circle_outline_rounded, size: 16),
                  label: const Text('Approve & Activate Pro Plan'),
                  style: FilledButton.styleFrom(backgroundColor: AppTheme.iconRed),
                ),
              ],
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      isCompleted ? Icons.check_circle_rounded : Icons.cancel_outlined,
                      size: 16,
                      color: isCompleted ? Colors.green : Colors.grey,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      isCompleted ? 'Payment Verified & Pro Plan Active' : 'Payment Submission Rejected',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: isCompleted ? Colors.green.shade700 : AppTheme.textMuted,
                      ),
                    ),
                  ],
                ),
                Tooltip(
                  message: 'Permanently remove fake/test transaction and adjust total revenue',
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.iconRed,
                      side: const BorderSide(color: AppTheme.iconRed),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    icon: const Icon(Icons.delete_outline_rounded, size: 16),
                    label: const Text('Delete Fake Record', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                    onPressed: () => widget.onDeletePayment?.call(payId, '$userName (रू $amount)'),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildDonationItem(BuildContext context, dynamic d) {
    final donId = d['_id']?.toString() ?? '';
    final qPhoto = (d['question_photo_url'] ?? '').toString();
    final aPhoto = (d['answer_photo_url'] ?? '').toString();
    final qText = (d['question_english']?.toString().isNotEmpty == true) ? d['question_english'] : (d['question_nepali'] ?? '');
    final ansPreview = d['type'] == 'mcq'
        ? 'Options: ${(d['options'] as List<dynamic>? ?? []).join(" | ")}'
        : ((d['answer_english']?.toString().isNotEmpty == true) ? d['answer_english'] : (d['answer_nepali'] ?? ''));

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${d['userName']} (${d['userEmail']})',
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppTheme.bgSurface,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  '${d['exam_id']} • ${d['type']?.toString().toUpperCase()} • ${d['marks'] ?? 5}M',
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text('Question: $qText', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)),
          if (ansPreview.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              'Model Answer: $ansPreview',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12.5, color: AppTheme.textMuted),
            ),
          ],
          if (qPhoto.isNotEmpty || aPhoto.isNotEmpty) ...[
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: [
                if (qPhoto.isNotEmpty)
                  OutlinedButton.icon(
                    onPressed: () => PhotoPreviewDialog.show(context, title: 'Question Photo', imageUrl: qPhoto),
                    icon: const Icon(Icons.image_outlined, size: 15, color: AppTheme.iconRed),
                    label: const Text(
                      'Inspect Question Photo',
                      style: TextStyle(fontSize: 12, color: AppTheme.iconRed, fontWeight: FontWeight.w700),
                    ),
                  ),
                if (aPhoto.isNotEmpty)
                  OutlinedButton.icon(
                    onPressed: () => PhotoPreviewDialog.show(context, title: 'Model Answer Photo', imageUrl: aPhoto),
                    icon: const Icon(Icons.fact_check_outlined, size: 15),
                    label: const Text('Inspect Answer Photo', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                  ),
              ],
            ),
          ],
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: () => widget.onVerifyDonation(donId, 'reject'),
                child: const Text('Reject', style: TextStyle(color: AppTheme.iconRed)),
              ),
              const SizedBox(width: 8),
              FilledButton.icon(
                onPressed: () => widget.onVerifyDonation(donId, 'approve'),
                icon: const Icon(Icons.check_circle_outline_rounded, size: 16),
                label: const Text('Publish & Credit Candidate (+रू 0.05)'),
                style: FilledButton.styleFrom(backgroundColor: AppTheme.iconRed),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
