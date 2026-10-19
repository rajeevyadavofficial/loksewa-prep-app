import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import 'expiry_duration_dialog.dart';

class UsersManagerTab extends StatefulWidget {
  final Map<String, dynamic>? stats;
  final Future<void> Function(String userId, String newPlan, Map<String, dynamic>? expiry) onUpdatePlan;
  final Future<void> Function(String userId, String userName) onDeleteUser;

  const UsersManagerTab({
    super.key,
    required this.stats,
    required this.onUpdatePlan,
    required this.onDeleteUser,
  });

  @override
  State<UsersManagerTab> createState() => _UsersManagerTabState();
}

class _UsersManagerTabState extends State<UsersManagerTab> {
  final _searchCtrl = TextEditingController();
  String _planFilter = 'all';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final users = (widget.stats?['users'] as List<dynamic>?) ?? [];
    final isMobile = MediaQuery.of(context).size.width < 750;

    final query = _searchCtrl.text.trim().toLowerCase();
    final filtered = users.where((u) {
      final plan = u['plan']?.toString() ?? 'free';
      if (_planFilter == 'free' && plan != 'free') return false;
      if (_planFilter == 'premium' && plan == 'free') return false;

      if (query.isNotEmpty) {
        final name = (u['name'] ?? '').toString().toLowerCase();
        final email = (u['email'] ?? '').toString().toLowerCase();
        if (!name.contains(query) && !email.contains(query)) return false;
      }
      return true;
    }).toList();

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
                    'Registered Candidates & Subscriptions (${users.length})',
                    style: TextStyle(fontSize: isMobile ? 18 : 21, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    'Search users, adjust subscription plans (Free/Pro), set expiry dates, or delete accounts.',
                    style: TextStyle(color: AppTheme.textMuted, fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Search & Filter
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.divider),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchCtrl,
                    decoration: InputDecoration(
                      hintText: 'Search candidates by name or email address...',
                      prefixIcon: const Icon(Icons.search_rounded, size: 20),
                      suffixIcon: _searchCtrl.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear_rounded, size: 18),
                              onPressed: () => setState(() => _searchCtrl.clear()),
                            )
                          : null,
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: _planFilter,
                  items: const [
                    DropdownMenuItem(value: 'all', child: Text('All Users')),
                    DropdownMenuItem(value: 'premium', child: Text('Pro Subscribers Only')),
                    DropdownMenuItem(value: 'free', child: Text('Free Tier Only')),
                  ],
                  onChanged: (v) {
                    if (v != null) setState(() => _planFilter = v);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          if (widget.stats == null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.divider),
              ),
              child: const Center(
                child: CircularProgressIndicator(color: AppTheme.iconRed),
              ),
            )
          else if (filtered.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.divider),
              ),
              child: Center(
                child: Column(
                  children: [
                    const Icon(Icons.people_outline_rounded, size: 36, color: AppTheme.textMuted),
                    const SizedBox(height: 10),
                    Text(
                      users.isEmpty
                          ? 'No users returned from server (click Refresh in top right).'
                          : 'No users match your search/filter criteria.',
                      style: const TextStyle(color: AppTheme.textMuted),
                    ),
                  ],
                ),
              ),
            )
          else
            ...filtered.map((u) {
              final uid = u['uid']?.toString() ?? '';
              final uName = u['name']?.toString() ?? 'Candidate';
              final uEmail = u['email']?.toString() ?? '';
              final isAdminUser = u['isAdmin'] == true;
              final currentPlan = u['plan']?.toString() ?? 'free';
              final isPro = currentPlan != 'free';
              final rawExpiry = u['planExpiresAt']?.toString();

              String? expiryText;
              bool isExpired = false;
              if (!isAdminUser && isPro && rawExpiry != null && rawExpiry.isNotEmpty) {
                try {
                  final dt = DateTime.parse(rawExpiry).toLocal();
                  isExpired = dt.isBefore(DateTime.now());
                  expiryText = '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
                } catch (_) {}
              }

              return Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
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
                            color: isAdminUser ? AppTheme.bgSurface : (isPro ? AppTheme.iconRedLight : AppTheme.bgSurface),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            isAdminUser ? Icons.admin_panel_settings_rounded : (isPro ? Icons.star_rounded : Icons.person_rounded),
                            color: isAdminUser ? AppTheme.primaryColor : (isPro ? AppTheme.iconRed : AppTheme.textMuted),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                  uName,
                                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: AppTheme.textPrimary),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: isAdminUser ? AppTheme.primaryColor : (isPro ? AppTheme.iconRedLight : AppTheme.bgSurface),
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: isAdminUser ? AppTheme.primaryColor : (isPro ? AppTheme.iconRed.withOpacity(0.3) : AppTheme.divider),
                                    ),
                                  ),
                                  child: Text(
                                    isAdminUser ? 'ADMINISTRATOR' : (isPro ? 'PRO PLAN (रू 199)' : 'FREE PLAN'),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                      color: isAdminUser ? Colors.white : (isPro ? AppTheme.iconRedDark : AppTheme.textMuted),
                                    ),
                                  ),
                                ),
                                if (isAdminUser)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade50,
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(color: Colors.green.shade200),
                                    ),
                                    child: Text(
                                      'LIFETIME FULL ACCESS',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.green.shade800,
                                      ),
                                    ),
                                  )
                                else if (expiryText != null)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: isExpired ? AppTheme.iconRedLight : AppTheme.bgSurface,
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(color: AppTheme.divider),
                                    ),
                                    child: Text(
                                      isExpired ? 'Expired: $expiryText' : 'Active till: $expiryText',
                                      style: TextStyle(
                                        fontSize: 10.5,
                                        fontWeight: FontWeight.w700,
                                        color: isExpired ? AppTheme.iconRed : AppTheme.textBody,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 3),
                            Text(uEmail, style: const TextStyle(fontSize: 12.5, color: AppTheme.textMuted)),
                          ],
                        ),
                      ],
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        if (!isAdminUser) ...[
                          DropdownButton<String>(
                            value: isPro ? 'premium' : 'free',
                            items: const [
                              DropdownMenuItem(value: 'free', child: Text('Free Tier')),
                              DropdownMenuItem(value: 'premium', child: Text('Pro Plan (रू 199)')),
                            ],
                            onChanged: (val) async {
                              if (val != null && val != (isPro ? 'premium' : 'free')) {
                                Map<String, dynamic>? expiry;
                                if (val != 'free') {
                                  expiry = await ExpiryDurationDialog.show(
                                    context,
                                    title: 'Activate Pro Plan for $uName',
                                  );
                                  if (expiry == null) return;
                                }
                                widget.onUpdatePlan(uid, val, expiry);
                              }
                            },
                          ),
                          if (isPro)
                            OutlinedButton.icon(
                              icon: const Icon(Icons.event_available_rounded, size: 14),
                              label: const Text('Change Expiry', style: TextStyle(fontSize: 12)),
                              onPressed: () async {
                                final expiry = await ExpiryDurationDialog.show(
                                  context,
                                  title: 'Adjust Pro Expiry for $uName',
                                );
                                if (expiry != null) {
                                  widget.onUpdatePlan(uid, 'premium', expiry);
                                }
                              },
                            ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline_rounded, size: 18, color: AppTheme.iconRed),
                            tooltip: 'Delete User Account',
                            onPressed: () => widget.onDeleteUser(uid, uName),
                          ),
                        ] else
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppTheme.bgSurface,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text('Protected Root Admin', style: TextStyle(fontSize: 11.5, color: AppTheme.textMuted, fontWeight: FontWeight.w700)),
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
