import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';
import '../../data/repositories/providers.dart';

import 'widgets/exam_edit_dialog.dart';
import 'widgets/exams_manager_tab.dart';
import 'widgets/overview_tab.dart';
import 'widgets/question_edit_dialog.dart';
import 'widgets/questions_manager_tab.dart';
import 'widgets/settings_tab.dart';
import 'widgets/users_manager_tab.dart';
import 'widgets/verifications_tab.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _currentTab = 0;
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

  Future<void> _fetchAdminStats({bool silent = false}) async {
    final token = context.read<AuthProvider>().adminToken;
    if (token == null || token.isEmpty) {
      if (mounted) setState(() => _loadingStats = false);
      return;
    }
    if (!silent) {
      setState(() {
        _loadingStats = true;
        _statsFetchedOnce = true;
      });
    } else {
      _statsFetchedOnce = true;
    }
    try {
      final res = await http.get(
        Uri.parse('${AppConstants.apiBaseUrl}/admin/stats'),
        headers: {'Authorization': 'Bearer $token'},
      ).timeout(const Duration(seconds: 35));
      if (res.statusCode == 200 && mounted) {
        setState(() {
          _liveStats = jsonDecode(res.body) as Map<String, dynamic>;
          _loadingStats = false;
        });
        return;
      } else {
        debugPrint('Admin stats fetch returned ${res.statusCode}: ${res.body}');
      }
    } catch (e) {
      debugPrint('Admin stats fetch error: $e');
    }
    if (mounted) {
      setState(() {
        _liveStats ??= {};
        _loadingStats = false;
      });
    }
  }

  Future<void> _updateUserPlan(String userId, String newPlan, Map<String, dynamic>? expiry) async {
    final token = context.read<AuthProvider>().adminToken;
    if (token == null) return;

    try {
      final res = await http.put(
        Uri.parse('${AppConstants.apiBaseUrl}/admin/users/$userId/plan'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'plan': newPlan,
          if (expiry != null) ...expiry,
        }),
      );
      if (res.statusCode == 200 && mounted) {
        final label = newPlan == 'free' ? 'FREE' : 'PRO (रू 199)';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Candidate plan updated to $label in MongoDB Atlas!'),
            backgroundColor: AppTheme.primaryColor,
          ),
        );
        _fetchAdminStats(silent: true);
      }
    } catch (_) {}
  }

  Future<void> _verifyPayment(String paymentId, String action, Map<String, dynamic>? expiry) async {
    final token = context.read<AuthProvider>().adminToken;
    if (token == null) return;

    try {
      final res = await http.put(
        Uri.parse('${AppConstants.apiBaseUrl}/admin/payments/$paymentId/verify'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'action': action,
          if (expiry != null) ...expiry,
        }),
      );
      if (res.statusCode == 200 && mounted) {
        final data = jsonDecode(res.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              data['message']?.toString() ??
                  (action == 'approve' ? 'Payment verified & candidate Pro plan activated!' : 'Payment request rejected.'),
            ),
            backgroundColor: action == 'approve' ? AppTheme.primaryColor : AppTheme.iconRed,
          ),
        );
        _fetchAdminStats(silent: true);
      }
    } catch (_) {}
  }

  Future<void> _verifyDonation(String donationId, String action) async {
    final token = context.read<AuthProvider>().adminToken;
    if (token == null) return;

    try {
      final res = await http.put(
        Uri.parse('${AppConstants.apiBaseUrl}/admin/donations/$donationId/verify'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'action': action}),
      );
      if (res.statusCode == 200 && mounted) {
        final data = jsonDecode(res.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              data['message']?.toString() ??
                  (action == 'approve' ? 'Question verified & published to Question Bank!' : 'Donated question rejected.'),
            ),
            backgroundColor: action == 'approve' ? AppTheme.primaryColor : AppTheme.iconRed,
          ),
        );
        context.read<QuestionProvider>().loadAll(forceRefresh: true);
        _fetchAdminStats(silent: true);
      }
    } catch (_) {}
  }

  Future<void> _deleteUser(String userId, String userName) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Delete Candidate Account?'),
        content: Text(
          'Are you sure you want to permanently delete "$userName"? This action cannot be undone.',
          style: const TextStyle(fontSize: 13.5),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppTheme.iconRed),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete User'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    final token = context.read<AuthProvider>().adminToken;
    // Immediately remove user locally for zero flicker
    if (_liveStats != null) {
      setState(() {
        final users = List<dynamic>.from(_liveStats!['users'] ?? []);
        users.removeWhere((u) => (u['uid']?.toString() ?? '') == userId);
        _liveStats!['users'] = users;
        _liveStats!['totalUsers'] = users.length;
      });
    }

    try {
      final res = await http.delete(
        Uri.parse('${AppConstants.apiBaseUrl}/admin/users/$userId'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (mounted) {
        final data = jsonDecode(res.body);
        if (res.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Deleted user "$userName" successfully.'),
              backgroundColor: AppTheme.primaryColor,
              duration: const Duration(seconds: 2),
            ),
          );
          _fetchAdminStats(silent: true);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['error']?.toString() ?? 'Failed to delete user'), backgroundColor: AppTheme.iconRed),
          );
          _fetchAdminStats(silent: true);
        }
      }
    } catch (_) {
      if (mounted) _fetchAdminStats(silent: true);
    }
  }

  Future<void> _deletePayment(String paymentId, [String? detail]) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Delete Transaction Record?'),
        content: Text(
          detail != null && detail.isNotEmpty
              ? 'Are you sure you want to permanently delete transaction for "$detail"? This will clear fake or test transaction data from MongoDB and recalculate total revenue.'
              : 'Are you sure you want to permanently delete this transaction record? This will clear fake or test records from the database.',
          style: const TextStyle(fontSize: 13.5),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppTheme.iconRed),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete Transaction'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    final token = context.read<AuthProvider>().adminToken;
    if (token == null) return;

    // Immediately remove item locally (Smooth, zero screen reload/flicker)
    if (_liveStats != null) {
      setState(() {
        final pending = List<dynamic>.from(_liveStats!['pendingPayments'] ?? []);
        final recent = List<dynamic>.from(_liveStats!['recentPayments'] ?? []);

        final deletedItem = recent.firstWhere(
          (p) => (p['_id']?.toString() ?? '') == paymentId,
          orElse: () => null,
        );
        if (deletedItem != null && deletedItem['status'] == 'completed') {
          final amt = int.tryParse(deletedItem['amount']?.toString() ?? '0') ?? 0;
          final currRev = (_liveStats!['totalRevenue'] as num?)?.toInt() ?? 0;
          _liveStats!['totalRevenue'] = (currRev - amt).clamp(0, 9999999);
        }

        pending.removeWhere((p) => (p['_id']?.toString() ?? '') == paymentId);
        recent.removeWhere((p) => (p['_id']?.toString() ?? '') == paymentId);
        _liveStats!['pendingPayments'] = pending;
        _liveStats!['recentPayments'] = recent;
        _liveStats!['pendingCount'] = pending.length;
      });
    }

    try {
      final res = await http.delete(
        Uri.parse('${AppConstants.apiBaseUrl}/admin/payments/$paymentId'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (mounted) {
        if (res.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Transaction record deleted successfully.'),
              backgroundColor: AppTheme.primaryColor,
              duration: Duration(seconds: 2),
            ),
          );
          _fetchAdminStats(silent: true);
        } else {
          final data = jsonDecode(res.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(data['error']?.toString() ?? 'Failed to delete transaction record'),
              backgroundColor: AppTheme.iconRed,
            ),
          );
          _fetchAdminStats(silent: true);
        }
      }
    } catch (_) {
      if (mounted) _fetchAdminStats(silent: true);
    }
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

    if (!auth.isAdminLoggedIn) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.lock_outline_rounded, size: 56, color: AppTheme.iconRed),
                const SizedBox(height: 16),
                const Text('Administrator Authentication Required', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                const Text(
                  'Please sign in via the dedicated Admin Portal (/admin/adminlogin).',
                  style: TextStyle(color: AppTheme.textMuted),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: () => context.go(AppConstants.routeAdminLogin),
                  icon: const Icon(Icons.admin_panel_settings_outlined, size: 18, color: Colors.white),
                  label: const Text('Go to Admin Login'),
                  style: FilledButton.styleFrom(backgroundColor: AppTheme.iconRed, foregroundColor: Colors.white),
                ),
              ],
            ),
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

    final isMobile = MediaQuery.of(context).size.width < 750;
    final pendingPayments = (_liveStats?['pendingPayments'] as List<dynamic>?) ?? [];
    final pendingDonations = (_liveStats?['pendingDonations'] as List<dynamic>?) ?? [];
    final totalPending = pendingPayments.length + pendingDonations.length;

    final tabContent = (_loadingStats && _liveStats == null)
        ? const Center(child: CircularProgressIndicator(color: AppTheme.iconRed))
        : IndexedStack(
            index: _currentTab,
            children: [
              AdminOverviewTab(
                stats: _liveStats,
                onAddExam: () => ExamEditDialog.show(context),
                onAddQuestion: () => QuestionEditDialog.show(context),
                onNavigateToPayments: () => setState(() => _currentTab = 4),
                onNavigateToQuestions: () => setState(() => _currentTab = 1),
                onNavigateToSettings: () => setState(() => _currentTab = 5),
                onVerifyPayment: _verifyPayment,
                onVerifyDonation: _verifyDonation,
                onDeletePayment: _deletePayment,
              ),
              QuestionsManagerTab(
                onAddQuestion: () => QuestionEditDialog.show(context),
              ),
              ExamsManagerTab(
                onAddExam: () => ExamEditDialog.show(context),
              ),
              UsersManagerTab(
                stats: _liveStats,
                onUpdatePlan: _updateUserPlan,
                onDeleteUser: _deleteUser,
              ),
              VerificationsTab(
                stats: _liveStats,
                onVerifyPayment: _verifyPayment,
                onVerifyDonation: _verifyDonation,
                onDeletePayment: _deletePayment,
              ),
              const SettingsTab(),
            ],
          );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.iconRed,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text('ADMIN', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 0.5)),
            ),
            const SizedBox(width: 10),
            Text(
              isMobile ? 'LoksewaHero CMS' : 'LoksewaHero Admin Command Center',
              style: TextStyle(fontSize: isMobile ? 15 : 17, fontWeight: FontWeight.w800),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: AppTheme.iconRed),
            tooltip: 'Sync MongoDB Atlas',
            onPressed: () {
              context.read<QuestionProvider>().loadAll(forceRefresh: true);
              _fetchAdminStats();
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: AppTheme.iconRed, size: 20),
            tooltip: 'Logout Admin Session',
            onPressed: () async {
              await context.read<AuthProvider>().logoutAdmin();
              if (context.mounted) {
                context.go(AppConstants.routeAdminLogin);
              }
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: isMobile
          ? tabContent
          : Row(
              children: [
                NavigationRail(
                  selectedIndex: _currentTab,
                  onDestinationSelected: (i) => setState(() => _currentTab = i),
                  labelType: NavigationRailLabelType.all,
                  minWidth: 84,
                  destinations: [
                    const NavigationRailDestination(
                      icon: Icon(Icons.dashboard_outlined),
                      selectedIcon: Icon(Icons.dashboard_rounded),
                      label: Text('Overview'),
                    ),
                    const NavigationRailDestination(
                      icon: Icon(Icons.quiz_outlined),
                      selectedIcon: Icon(Icons.quiz_rounded),
                      label: Text('Questions'),
                    ),
                    const NavigationRailDestination(
                      icon: Icon(Icons.school_outlined),
                      selectedIcon: Icon(Icons.school_rounded),
                      label: Text('Exams'),
                    ),
                    const NavigationRailDestination(
                      icon: Icon(Icons.people_alt_outlined),
                      selectedIcon: Icon(Icons.people_alt_rounded),
                      label: Text('Users'),
                    ),
                    NavigationRailDestination(
                      icon: Badge(
                        isLabelVisible: totalPending > 0,
                        label: Text('$totalPending'),
                        backgroundColor: AppTheme.iconRed,
                        child: const Icon(Icons.verified_user_outlined),
                      ),
                      selectedIcon: Badge(
                        isLabelVisible: totalPending > 0,
                        label: Text('$totalPending'),
                        backgroundColor: AppTheme.iconRed,
                        child: const Icon(Icons.verified_user_rounded),
                      ),
                      label: const Text('Approvals'),
                    ),
                    const NavigationRailDestination(
                      icon: Icon(Icons.qr_code_2_rounded),
                      selectedIcon: Icon(Icons.qr_code_2_rounded),
                      label: Text('Settings'),
                    ),
                  ],
                ),
                const VerticalDivider(width: 1, color: AppTheme.divider),
                Expanded(child: tabContent),
              ],
            ),
      bottomNavigationBar: isMobile
          ? NavigationBar(
              selectedIndex: _currentTab,
              onDestinationSelected: (i) => setState(() => _currentTab = i),
              backgroundColor: Colors.white,
              indicatorColor: AppTheme.iconRedLight,
              destinations: [
                const NavigationDestination(
                  icon: Icon(Icons.dashboard_outlined),
                  selectedIcon: Icon(Icons.dashboard_rounded, color: AppTheme.iconRed),
                  label: 'Overview',
                ),
                const NavigationDestination(
                  icon: Icon(Icons.quiz_outlined),
                  selectedIcon: Icon(Icons.quiz_rounded, color: AppTheme.iconRed),
                  label: 'Questions',
                ),
                const NavigationDestination(
                  icon: Icon(Icons.school_outlined),
                  selectedIcon: Icon(Icons.school_rounded, color: AppTheme.iconRed),
                  label: 'Exams',
                ),
                const NavigationDestination(
                  icon: Icon(Icons.people_alt_outlined),
                  selectedIcon: Icon(Icons.people_alt_rounded, color: AppTheme.iconRed),
                  label: 'Users',
                ),
                NavigationDestination(
                  icon: Badge(
                    isLabelVisible: totalPending > 0,
                    label: Text('$totalPending'),
                    backgroundColor: AppTheme.iconRed,
                    child: const Icon(Icons.verified_user_outlined),
                  ),
                  selectedIcon: Badge(
                    isLabelVisible: totalPending > 0,
                    label: Text('$totalPending'),
                    backgroundColor: AppTheme.iconRed,
                    child: const Icon(Icons.verified_user_rounded, color: AppTheme.iconRed),
                  ),
                  label: 'Approvals',
                ),
                const NavigationDestination(
                  icon: Icon(Icons.qr_code_2_rounded),
                  selectedIcon: Icon(Icons.qr_code_2_rounded, color: AppTheme.iconRed),
                  label: 'Settings',
                ),
              ],
            )
          : null,
    );
  }
}
