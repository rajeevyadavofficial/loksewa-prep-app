import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';
import '../../data/models/models.dart';
import '../../data/repositories/providers.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  bool _sidebarCollapsed = false;

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
    if (auth.initializing) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator(color: AppTheme.iconRed)),
      );
    }
    final user = auth.user;
    if (user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => context.go(AppConstants.routeLogin));
      return const SizedBox.shrink();
    }

    final w = MediaQuery.of(context).size.width;
    final isWide = w > 1050;

    return Scaffold(
      backgroundColor: Colors.white,
      body: isWide
          ? Row(
              children: [
                _SideNav(
                  selectedIndex: _selectedIndex,
                  isCollapsed: _sidebarCollapsed,
                  onToggleCollapse: () => setState(() => _sidebarCollapsed = !_sidebarCollapsed),
                  onTap: (i) => setState(() => _selectedIndex = i),
                ),
                Expanded(child: _buildBody(user, isWide: true)),
              ],
            )
          : Column(
              children: [
                Expanded(child: _buildBody(user, isWide: false)),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(color: AppTheme.divider, width: 1)),
                  ),
                  child: NavigationBar(
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: (i) => setState(() => _selectedIndex = i),
                    destinations: const [
                      NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: 'Exams & Home'),
                      NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book), label: 'Q&A Bank'),
                      NavigationDestination(icon: Icon(Icons.timer_outlined), selectedIcon: Icon(Icons.timer), label: 'Mock Test'),
                      NavigationDestination(icon: Icon(Icons.description_outlined), selectedIcon: Icon(Icons.description), label: 'Syllabus'),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildBody(AppUser user, {required bool isWide}) {
    return Column(
      children: [
        _TopBar(
          user: user,
          showSidebarToggle: isWide,
          isSidebarCollapsed: _sidebarCollapsed,
          onToggleSidebar: () => setState(() => _sidebarCollapsed = !_sidebarCollapsed),
        ),
        Expanded(
          child: IndexedStack(
            index: _selectedIndex,
            children: [
              _HomeTab(user: user, onGoToTab: (t) => setState(() => _selectedIndex = t)),
              QuestionsTab(onGoToExams: () => setState(() => _selectedIndex = 0)),
              MockTestTab(onGoToExams: () => setState(() => _selectedIndex = 0)),
              SyllabusTab(onGoToExams: () => setState(() => _selectedIndex = 0)),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Pure White Collapsible Chakra UI / MUI Side Navigation ───
class _SideNav extends StatelessWidget {
  final int selectedIndex;
  final bool isCollapsed;
  final VoidCallback onToggleCollapse;
  final ValueChanged<int> onTap;

  const _SideNav({
    required this.selectedIndex,
    required this.isCollapsed,
    required this.onToggleCollapse,
    required this.onTap,
  });

  static const items = [
    (Icons.dashboard_outlined, Icons.dashboard_rounded, 'Exams & Overview'),
    (Icons.menu_book_outlined, Icons.menu_book_rounded, 'Question Bank'),
    (Icons.timer_outlined, Icons.timer_rounded, 'Timed Mock Test'),
    (Icons.description_outlined, Icons.description_rounded, 'Exam Syllabus'),
  ];

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final user = auth.user!;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      width: isCollapsed ? 76 : 260,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: AppTheme.divider, width: 1)),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isCollapsed ? 10 : 16, vertical: 16),
            child: isCollapsed
                ? Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.iconRedLight,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppTheme.iconRed.withOpacity(0.25)),
                        ),
                        child: const Icon(Icons.menu_book_rounded, color: AppTheme.iconRed, size: 20),
                      ),
                      const SizedBox(height: 8),
                      Tooltip(
                        message: 'Expand Sidebar',
                        child: InkWell(
                          onTap: onToggleCollapse,
                          borderRadius: BorderRadius.circular(6),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF4F4F5),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: AppTheme.divider),
                            ),
                            child: const Icon(Icons.keyboard_double_arrow_right_rounded, size: 16, color: AppTheme.textPrimary),
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.iconRedLight,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppTheme.iconRed.withOpacity(0.25)),
                        ),
                        child: const Icon(Icons.menu_book_rounded, color: AppTheme.iconRed, size: 20),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'LokSewa Prep',
                              style: TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.w800, fontSize: 15.5, letterSpacing: -0.3),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Multi-Exam Portal',
                              style: TextStyle(color: AppTheme.textMuted, fontSize: 11),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Tooltip(
                        message: 'Collapse Sidebar',
                        child: InkWell(
                          onTap: onToggleCollapse,
                          borderRadius: BorderRadius.circular(7),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF4F4F5),
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: AppTheme.divider),
                            ),
                            child: const Icon(Icons.keyboard_double_arrow_left_rounded, size: 17, color: AppTheme.textPrimary),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          const Divider(color: AppTheme.divider, height: 1),
          const SizedBox(height: 12),
          ...items.asMap().entries.map((entry) {
            final idx = entry.key;
            final item = entry.value;
            final active = idx == selectedIndex;

            final navItem = InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => onTap(idx),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: isCollapsed ? 0 : 12, vertical: 11),
                decoration: BoxDecoration(
                  color: active ? AppTheme.iconRedLight : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: active ? AppTheme.iconRed.withOpacity(0.3) : Colors.transparent,
                  ),
                ),
                child: isCollapsed
                    ? Center(
                        child: Icon(
                          active ? item.$2 : item.$1,
                          color: active ? AppTheme.iconRed : AppTheme.primaryColor,
                          size: 21,
                        ),
                      )
                    : Row(
                        children: [
                          Icon(
                            active ? item.$2 : item.$1,
                            color: active ? AppTheme.iconRed : AppTheme.primaryColor,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              item.$3,
                              style: TextStyle(
                                color: active ? AppTheme.iconRedDark : AppTheme.textPrimary,
                                fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                                fontSize: 13.5,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
              ),
            );

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: isCollapsed ? 12 : 12, vertical: 3),
              child: isCollapsed ? Tooltip(message: item.$3, child: navItem) : navItem,
            );
          }),
          const Spacer(),
          const Divider(color: AppTheme.divider, height: 1),
          Padding(
            padding: EdgeInsets.all(isCollapsed ? 10 : 16),
            child: isCollapsed
                ? Column(
                    children: [
                      if (user.plan == SubscriptionPlan.free) ...[
                        Tooltip(
                          message: 'Upgrade Plan',
                          child: InkWell(
                            onTap: () => GoRouter.of(context).go(AppConstants.routeSubscription),
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              width: 42,
                              height: 36,
                              decoration: BoxDecoration(
                                color: AppTheme.iconRed,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.bolt_rounded, size: 18, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                      Tooltip(
                        message: '${user.name} (${user.email})',
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4F4F5),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppTheme.divider),
                          ),
                          child: Center(
                            child: Text(
                              user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                              style: const TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.w800, fontSize: 13),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      IconButton(
                        icon: const Icon(Icons.logout_rounded, color: AppTheme.iconRed, size: 18),
                        tooltip: 'Logout',
                        onPressed: () async {
                          await auth.logout();
                          if (context.mounted) context.go(AppConstants.routeHome);
                        },
                      ),
                    ],
                  )
                : Column(
                    children: [
                      _PlanBadgeWidget(plan: user.plan),
                      if (user.plan == SubscriptionPlan.free) ...[
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            onPressed: () => GoRouter.of(context).go(AppConstants.routeSubscription),
                            icon: const Icon(Icons.bolt_rounded, size: 16, color: Colors.white),
                            label: const Text('Upgrade Plan', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                            style: FilledButton.styleFrom(
                              backgroundColor: AppTheme.iconRed,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF4F4F5),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppTheme.divider),
                            ),
                            child: Center(
                              child: Text(
                                user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                                style: const TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.w800, fontSize: 13),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name,
                                  style: const TextStyle(color: AppTheme.textPrimary, fontSize: 12.5, fontWeight: FontWeight.w700),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  user.email,
                                  style: const TextStyle(color: AppTheme.textMuted, fontSize: 10.5),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.logout_rounded, color: AppTheme.iconRed, size: 18),
                            tooltip: 'Logout',
                            onPressed: () async {
                              await auth.logout();
                              if (context.mounted) context.go(AppConstants.routeHome);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _PlanBadgeWidget extends StatelessWidget {
  final SubscriptionPlan plan;
  const _PlanBadgeWidget({required this.plan});

  @override
  Widget build(BuildContext context) {
    final (label, isRed) = switch (plan) {
      SubscriptionPlan.premium => ('PRO PLAN (रू 299)', true),
      SubscriptionPlan.basic => ('PRO PLAN (रू 299)', true),
      SubscriptionPlan.free => ('FREE STARTER PLAN', false),
    };
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: isRed ? AppTheme.iconRedLight : const Color(0xFFF4F4F5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isRed ? AppTheme.iconRed.withOpacity(0.35) : AppTheme.divider),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isRed ? Icons.verified_rounded : Icons.check_circle_outline_rounded,
            size: 14,
            color: isRed ? AppTheme.iconRed : AppTheme.primaryColor,
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isRed ? AppTheme.iconRedDark : AppTheme.textPrimary,
                fontWeight: FontWeight.w800,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Pure White Top Bar with Sidebar Toggle & Exam Switcher ───
class _TopBar extends StatelessWidget {
  final AppUser user;
  final bool showSidebarToggle;
  final bool isSidebarCollapsed;
  final VoidCallback? onToggleSidebar;

  const _TopBar({
    required this.user,
    this.showSidebarToggle = false,
    this.isSidebarCollapsed = false,
    this.onToggleSidebar,
  });

  @override
  Widget build(BuildContext context) {
    final qp = context.watch<QuestionProvider>();
    final exams = qp.exams;
    final enrolledExams = user.isAdmin
        ? exams.where((e) => !e.isComingSoon).toList()
        : exams.where((e) => !e.isComingSoon && user.isEnrolledIn(e.id)).toList();

    // Ensure selectedExamId matches one of the user's enrolled exams
    if (!user.isAdmin && user.enrolledExams.isNotEmpty && !user.enrolledExams.contains(qp.selectedExamId)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        qp.ensureEnrolledExamSelected(user.enrolledExams);
      });
    }

    final currentExamId = qp.selectedExamId;
    final activeEnrolledExam = enrolledExams.where((e) => e.id == currentExamId).firstOrNull ?? enrolledExams.firstOrNull;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppTheme.divider, width: 1)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Wrap(
        spacing: 16,
        runSpacing: 10,
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showSidebarToggle && onToggleSidebar != null) ...[
                Tooltip(
                  message: isSidebarCollapsed ? 'Expand Sidebar' : 'Collapse Sidebar',
                  child: InkWell(
                    onTap: onToggleSidebar,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppTheme.divider),
                      ),
                      child: Icon(
                        isSidebarCollapsed ? Icons.menu_open_rounded : Icons.view_sidebar_outlined,
                        size: 18,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.divider),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.menu_book_rounded, size: 17, color: AppTheme.iconRed),
                    const SizedBox(width: 8),
                    const Text(
                      'Enrolled Exam:',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.textMuted),
                    ),
                    const SizedBox(width: 8),
                    if (enrolledExams.isEmpty)
                      const Text(
                        'Not Enrolled Yet (Select an exam below)',
                        style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppTheme.iconRed),
                      )
                    else if (enrolledExams.length == 1)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${activeEnrolledExam!.title} (${activeEnrolledExam.category})',
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppTheme.textPrimary),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppTheme.iconRedLight,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'ENROLLED',
                              style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: AppTheme.iconRedDark),
                            ),
                          ),
                        ],
                      )
                    else
                      DropdownButton<String>(
                        value: activeEnrolledExam?.id ?? enrolledExams.first.id,
                        underline: const SizedBox.shrink(),
                        isDense: true,
                        dropdownColor: Colors.white,
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5, color: AppTheme.textPrimary),
                        items: enrolledExams.map((e) {
                          return DropdownMenuItem<String>(
                            value: e.id,
                            child: Text(
                              '${e.title} (${e.category})',
                              style: const TextStyle(
                                color: AppTheme.textPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            qp.selectExam(val);
                          }
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (user.isAdmin)
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.admin_panel_settings_outlined, size: 17, color: AppTheme.iconRed),
                    label: const Text('Admin CMS'),
                    onPressed: () => GoRouter.of(context).go(AppConstants.routeAdmin),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.textPrimary,
                      side: const BorderSide(color: AppTheme.divider),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    ),
                  ),
                ),
              OutlinedButton.icon(
                onPressed: () => GoRouter.of(context).go(AppConstants.routeSubscription),
                icon: const Icon(Icons.workspace_premium_outlined, size: 16, color: AppTheme.iconRed),
                label: Text(user.planDisplayName.toUpperCase()),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.textPrimary,
                  side: const BorderSide(color: AppTheme.divider),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Home & Multi-Exam Catalog Tab ────────────────────────────
class _HomeTab extends StatefulWidget {
  final AppUser user;
  final ValueChanged<int> onGoToTab;
  const _HomeTab({required this.user, required this.onGoToTab});

  @override
  State<_HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<_HomeTab> {
  String _catFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final qp = context.watch<QuestionProvider>();
    final auth = context.watch<AuthProvider>();
    final user = widget.user;
    final allExams = qp.exams;
    final filteredExams = _catFilter == 'All'
        ? allExams
        : allExams.where((e) => e.category == _catFilter).toList();

    final hasEnrollment = user.isAdmin || user.enrolledExams.isNotEmpty;
    final enrolledExam = hasEnrollment ? qp.selectedExam : null;
    final enrolledQuestionsCount = hasEnrollment && enrolledExam != null
        ? qp.countForExam(enrolledExam.id)
        : 0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (user.plan == SubscriptionPlan.free) _UpgradeBanner(),

          // ── Enrolled Exam Active Card OR Prompt to Enroll ──
          if (hasEnrollment && enrolledExam != null)
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.divider, width: 1.2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.iconRedLight,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.verified_rounded, size: 13, color: AppTheme.iconRed),
                            const SizedBox(width: 5),
                            Text(
                              'MY ENROLLED EXAM • ${enrolledExam.category.toUpperCase()}',
                              style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w800, color: AppTheme.iconRedDark),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Text(
                        enrolledExam.organization,
                        style: const TextStyle(color: AppTheme.textMuted, fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    enrolledExam.title,
                    style: const TextStyle(color: AppTheme.textPrimary, fontSize: 21, fontWeight: FontWeight.w800, letterSpacing: -0.4),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    enrolledExam.titleNepali,
                    style: const TextStyle(color: AppTheme.textBody, fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    enrolledExam.description,
                    style: const TextStyle(color: AppTheme.textMuted, fontSize: 13, height: 1.5),
                  ),
                  const SizedBox(height: 18),
                  Wrap(
                    spacing: 12,
                    runSpacing: 10,
                    children: [
                      FilledButton.icon(
                        onPressed: () => widget.onGoToTab(1),
                        icon: const Icon(Icons.menu_book_rounded, size: 17, color: Colors.white),
                        label: Text('Study Q&A Bank ($enrolledQuestionsCount)'),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppTheme.iconRed,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: () => widget.onGoToTab(2),
                        icon: const Icon(Icons.timer_outlined, size: 17, color: AppTheme.primaryColor),
                        label: const Text('Start Mock Test'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.primaryColor,
                          side: const BorderSide(color: AppTheme.divider, width: 1.2),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: () => widget.onGoToTab(3),
                        icon: const Icon(Icons.description_outlined, size: 17, color: AppTheme.primaryColor),
                        label: const Text('View Official Syllabus'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.primaryColor,
                          side: const BorderSide(color: AppTheme.divider, width: 1.2),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          else
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.iconRed.withOpacity(0.45), width: 1.4),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppTheme.iconRedLight,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.school_outlined, color: AppTheme.iconRed, size: 28),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select & Enroll in Your Target Exam Below',
                          style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Enroll in an exam course below to unlock its dedicated Question Bank, Mock Tests, and Official Syllabus. Other exam materials are hidden so your study stays 100% focused.',
                          style: TextStyle(fontSize: 13, color: AppTheme.textMuted, height: 1.45),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 20),
          _StatsGrid(user: user),
          const SizedBox(height: 28),
          Row(
            children: [
              const Text(
                'Enroll in a Lok Sewa Exam Course',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
              ),
              const Spacer(),
              if (user.isAdmin)
                TextButton.icon(
                  onPressed: () => GoRouter.of(context).go(AppConstants.routeAdmin),
                  icon: const Icon(Icons.add_circle_outline_rounded, size: 16, color: AppTheme.iconRed),
                  label: const Text('Add Exam in Admin CMS', style: TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.w600)),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ['All', 'Civil Service', 'Banking', 'IT & Technical', 'Sansthan'].map((cat) {
              final active = _catFilter == cat;
              return FilterChip(
                selected: active,
                label: Text(cat),
                selectedColor: AppTheme.primaryColor,
                checkmarkColor: Colors.white,
                backgroundColor: Colors.white,
                side: BorderSide(color: active ? AppTheme.primaryColor : AppTheme.divider),
                labelStyle: TextStyle(
                  color: active ? Colors.white : AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.5,
                ),
                onSelected: (_) => setState(() => _catFilter = cat),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 1100
                  ? 3
                  : (MediaQuery.of(context).size.width > 700 ? 2 : 1),
              childAspectRatio: 1.42,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: filteredExams.length,
            itemBuilder: (ctx, i) {
              final exam = filteredExams[i];
              final isComingSoon = exam.isComingSoon;
              final isEnrolled = !isComingSoon && (user.isAdmin || user.isEnrolledIn(exam.id));
              final isActive = isEnrolled && qp.selectedExamId == exam.id;
              final qCount = qp.countForExam(exam.id);

              return Opacity(
                opacity: isComingSoon ? 0.65 : 1.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isEnrolled ? AppTheme.iconRed : AppTheme.divider,
                      width: isEnrolled ? 1.8 : 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: isComingSoon
                                    ? const Color(0xFFF4F4F5)
                                    : (isEnrolled ? AppTheme.iconRedLight : const Color(0xFFF4F4F5)),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                exam.category,
                                style: TextStyle(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w700,
                                  color: isComingSoon
                                      ? AppTheme.textMuted
                                      : (isEnrolled ? AppTheme.iconRedDark : AppTheme.textPrimary),
                                ),
                              ),
                            ),
                            const Spacer(),
                            if (isComingSoon)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF4F4F5),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(color: AppTheme.divider),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.lock_clock_outlined, size: 11, color: AppTheme.textMuted),
                                    SizedBox(width: 4),
                                    Text(
                                      'COMING SOON',
                                      style: TextStyle(color: AppTheme.textMuted, fontSize: 10, fontWeight: FontWeight.w800),
                                    ),
                                  ],
                                ),
                              )
                            else if (isEnrolled)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: AppTheme.iconRedLight,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  isActive ? '✓ Enrolled & Active' : '✓ Enrolled',
                                  style: const TextStyle(color: AppTheme.iconRed, fontSize: 11, fontWeight: FontWeight.w800),
                                ),
                              )
                            else
                              Text(
                                '$qCount Q&As',
                                style: const TextStyle(fontSize: 11, color: AppTheme.textMuted, fontWeight: FontWeight.w600),
                              ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          exam.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 14.5,
                            color: isComingSoon ? AppTheme.textMuted : AppTheme.textPrimary,
                          ),
                        ),
                        Text(
                          exam.titleNepali,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: isComingSoon ? AppTheme.textMuted : AppTheme.textBody,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${exam.organization} • ${exam.level}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 11, color: AppTheme.textMuted),
                        ),
                        const Spacer(),
                        const Divider(height: 14, color: AppTheme.divider),
                        if (isComingSoon)
                          const Row(
                            children: [
                              Icon(Icons.schedule_rounded, size: 14, color: AppTheme.textMuted),
                              SizedBox(width: 5),
                              Text(
                                'Launching Soon',
                                style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: AppTheme.textMuted),
                              ),
                              Spacer(),
                              Icon(Icons.lock_outline_rounded, size: 14, color: AppTheme.textMuted),
                            ],
                          )
                        else if (isEnrolled)
                          Row(
                            children: [
                              FilledButton.icon(
                                onPressed: () {
                                  qp.selectExam(exam.id);
                                  widget.onGoToTab(1);
                                },
                                icon: const Icon(Icons.menu_book_outlined, size: 14, color: Colors.white),
                                label: const Text('Study Q&As', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700)),
                                style: FilledButton.styleFrom(
                                  backgroundColor: AppTheme.iconRed,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  minimumSize: Size.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                              ),
                              const SizedBox(width: 8),
                              OutlinedButton(
                                onPressed: () {
                                  qp.selectExam(exam.id);
                                  widget.onGoToTab(3);
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppTheme.textPrimary,
                                  side: const BorderSide(color: AppTheme.divider),
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                  minimumSize: Size.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Text('Syllabus', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600)),
                              ),
                              const Spacer(),
                              if (!user.isAdmin)
                                Tooltip(
                                  message: 'Unenroll from this exam',
                                  child: InkWell(
                                    onTap: () async {
                                      await auth.enrollInExam(exam.id, action: 'unenroll');
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Unenrolled from ${exam.title}'),
                                            duration: const Duration(seconds: 2),
                                          ),
                                        );
                                      }
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(4),
                                      child: Icon(Icons.close_rounded, size: 16, color: AppTheme.textMuted),
                                    ),
                                  ),
                                ),
                            ],
                          )
                        else
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton.icon(
                              onPressed: () async {
                                // Set this exam as the user's enrolled exam so only its materials are shown
                                await auth.enrollInExam(exam.id, action: 'set_single');
                                qp.selectExam(exam.id);
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Enrolled in ${exam.title}! Showing only its study materials.'),
                                      backgroundColor: AppTheme.primaryColor,
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                }
                              },
                              icon: const Icon(Icons.how_to_reg_rounded, size: 15, color: Colors.white),
                              label: const Text('Enroll in Exam', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                              style: FilledButton.styleFrom(
                                backgroundColor: AppTheme.primaryColor,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 9),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _UpgradeBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.iconRed.withOpacity(0.4), width: 1.2),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.iconRedLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.lock_open_rounded, color: AppTheme.iconRed, size: 22),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Unlock All Lok Sewa Model Answers with Pro',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: AppTheme.textPrimary),
                ),
                SizedBox(height: 2),
                Text(
                  'Get full access to Paper I, Paper II & Paper III model answers — रू 299/month',
                  style: TextStyle(color: AppTheme.textMuted, fontSize: 12),
                ),
              ],
            ),
          ),
          FilledButton(
            onPressed: () => GoRouter.of(context).go(AppConstants.routeSubscription),
            style: FilledButton.styleFrom(
              backgroundColor: AppTheme.iconRed,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Upgrade Now'),
          ),
        ],
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  final AppUser user;
  const _StatsGrid({required this.user});

  @override
  Widget build(BuildContext context) {
    final qp = context.watch<QuestionProvider>();
    final hasEnrollment = user.isAdmin || user.enrolledExams.isNotEmpty;
    final enrolledQuestions = qp.getAccessible(
      user.plan,
      enrolledExams: user.enrolledExams,
      isAdmin: user.isAdmin,
    );
    return GridView.count(
      crossAxisCount: MediaQuery.of(context).size.width > 700 ? 4 : 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.75,
      children: [
        _StatCard('Enrolled Exams', user.isAdmin ? '${qp.exams.length}' : '${user.enrolledExams.length}', Icons.how_to_reg_outlined, true),
        _StatCard('Enrolled Q&A Bank', hasEnrollment ? '${enrolledQuestions.length}' : '0', Icons.menu_book_outlined, false),
        _StatCard('Available Courses', '${qp.exams.where((e) => !e.isComingSoon).length}', Icons.library_books_outlined, true),
        _StatCard('Your Plan', user.planDisplayName.toUpperCase(), Icons.verified_outlined, false),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label, value;
  final IconData icon;
  final bool isRed;
  const _StatCard(this.label, this.value, this.icon, this.isRed);

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
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
          ),
          Text(label, style: const TextStyle(color: AppTheme.textMuted, fontSize: 11.5)),
        ],
      ),
    );
  }
}

// ─── Clean Focused Question Bank ─────────────────────────────
class QuestionsTab extends StatefulWidget {
  final VoidCallback? onGoToExams;
  const QuestionsTab({super.key, this.onGoToExams});
  @override
  State<QuestionsTab> createState() => _QuestionsTabState();
}

class _QuestionsTabState extends State<QuestionsTab> {
  Question? _selected;
  String _lang = 'nepali';
  double _fontSize = 15.0;
  final Set<String> _studiedIds = {};
  final TextEditingController _searchCtrl = TextEditingController();
  bool _listCollapsed = false;

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _go(List<Question> list, int delta) {
    if (_selected == null) return;
    final idx = list.indexWhere((q) => q.id == _selected!.id);
    final next = idx + delta;
    if (next >= 0 && next < list.length) {
      setState(() => _selected = list[next]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final qp = context.watch<QuestionProvider>();
    final auth = context.watch<AuthProvider>();
    final user = auth.user!;
    final isWide = MediaQuery.of(context).size.width > 860;

    final isEnrolled = user.isAdmin || user.enrolledExams.isNotEmpty;
    if (!isEnrolled) {
      return _NotEnrolledPrompt(onGoToExams: widget.onGoToExams);
    }

    final accessible = qp.getAccessible(
      user.plan,
      enrolledExams: user.enrolledExams,
      isAdmin: user.isAdmin,
    );

    // Auto-select first question on wide screens when nothing is selected
    if (isWide && _selected == null && accessible.isNotEmpty) {
      _selected = accessible.first;
    }
    // If filters changed and selected question no longer exists, reset to first
    if (_selected != null && accessible.isNotEmpty) {
      final stillValid = accessible.any((q) => q.id == _selected!.id);
      if (!stillValid) _selected = accessible.first;
    }

    final selectedId = _selected?.id;
    final currentIdx = selectedId != null
        ? accessible.indexWhere((q) => q.id == selectedId)
        : -1;

    return Column(
      children: [
        // ── Single Clean Toolbar ────────────────────────────────
        _QBankToolbar(
          searchCtrl: _searchCtrl,
          lang: _lang,
          fontSize: _fontSize,
          studiedCount: _studiedIds.length,
          total: accessible.length,
          currentIdx: currentIdx,
          isWide: isWide,
          isListCollapsed: _listCollapsed,
          onLangChanged: (l) => setState(() => _lang = l),
          onFontDec: () => setState(() => _fontSize = (_fontSize - 1).clamp(13, 22)),
          onFontInc: () => setState(() => _fontSize = (_fontSize + 1).clamp(13, 22)),
          onSearch: (v) { qp.setFilters(query: v); setState(() {}); },
          onClearSearch: () { _searchCtrl.clear(); qp.setFilters(query: ''); setState(() {}); },
          onPrev: currentIdx > 0 ? () => _go(accessible, -1) : null,
          onNext: currentIdx >= 0 && currentIdx < accessible.length - 1 ? () => _go(accessible, 1) : null,
          onToggleList: () => setState(() => _listCollapsed = !_listCollapsed),
          paperFilter: qp.paperFilter,
          typeFilter: qp.typeFilter,
          onFilterChanged: (paper, type) {
            if (paper == null && type == null) {
              qp.clearFilters();
            } else {
              qp.setFilters(
                paper: paper,
                clearPaper: paper == null,
                type: type,
                clearType: type == null,
                clearSection: true,
              );
            }
          },
        ),
        // ── Main Layout ─────────────────────────────────────────
        Expanded(
          child: qp.loading
              ? const Center(child: CircularProgressIndicator(color: AppTheme.iconRed, strokeWidth: 2))
              : accessible.isEmpty
                  ? _EmptyState(onReset: () {
                      _searchCtrl.clear();
                      qp.clearFilters();
                      setState(() {});
                    })
                  : isWide
                      ? Row(
                          children: [
                            if (!_listCollapsed)
                              SizedBox(
                                width: 320,
                                child: _QuestionIndex(
                                  questions: accessible,
                                  selectedId: selectedId,
                                  lang: _lang,
                                  user: user,
                                  studiedIds: _studiedIds,
                                  onSelect: (q) => setState(() => _selected = q),
                                  onToggleStudied: (id) => setState(() {
                                    _studiedIds.contains(id) ? _studiedIds.remove(id) : _studiedIds.add(id);
                                  }),
                                ),
                              ),
                            if (!_listCollapsed)
                              Container(width: 1, color: AppTheme.divider),
                            Expanded(
                              child: _selected == null
                                  ? _EmptyReader()
                                  : _StudyReader(
                                      key: ValueKey(_selected!.id),
                                      question: _selected!,
                                      lang: _lang,
                                      fontSize: _fontSize,
                                      isStudied: _studiedIds.contains(_selected!.id),
                                      onToggleStudied: () => setState(() {
                                        final id = _selected!.id;
                                        _studiedIds.contains(id) ? _studiedIds.remove(id) : _studiedIds.add(id);
                                      }),
                                    ),
                            ),
                          ],
                        )
                      // Narrow: show list or reader
                      : _selected == null
                          ? _QuestionIndex(
                              questions: accessible,
                              selectedId: null,
                              lang: _lang,
                              user: user,
                              studiedIds: _studiedIds,
                              onSelect: (q) => setState(() => _selected = q),
                              onToggleStudied: (id) => setState(() {
                                _studiedIds.contains(id) ? _studiedIds.remove(id) : _studiedIds.add(id);
                              }),
                            )
                          : _StudyReader(
                              key: ValueKey(_selected!.id),
                              question: _selected!,
                              lang: _lang,
                              fontSize: _fontSize,
                              isStudied: _studiedIds.contains(_selected!.id),
                              onToggleStudied: () => setState(() {
                                final id = _selected!.id;
                                _studiedIds.contains(id) ? _studiedIds.remove(id) : _studiedIds.add(id);
                              }),
                              onBack: () => setState(() => _selected = null),
                            ),
        ),
      ],
    );
  }
}

// ── Single Slim Toolbar ─────────────────────────────────────────
class _QBankToolbar extends StatelessWidget {
  final TextEditingController searchCtrl;
  final String lang;
  final double fontSize;
  final int studiedCount;
  final int total;
  final int currentIdx;
  final bool isWide;
  final bool isListCollapsed;
  final ValueChanged<String> onLangChanged;
  final VoidCallback onFontDec;
  final VoidCallback onFontInc;
  final ValueChanged<String> onSearch;
  final VoidCallback onClearSearch;
  final VoidCallback? onPrev;
  final VoidCallback? onNext;
  final VoidCallback onToggleList;
  final PaperType? paperFilter;
  final QuestionType? typeFilter;
  final void Function(PaperType? paper, QuestionType? type) onFilterChanged;

  const _QBankToolbar({
    required this.searchCtrl,
    required this.lang,
    required this.fontSize,
    required this.studiedCount,
    required this.total,
    required this.currentIdx,
    required this.isWide,
    required this.isListCollapsed,
    required this.onLangChanged,
    required this.onFontDec,
    required this.onFontInc,
    required this.onSearch,
    required this.onClearSearch,
    required this.onPrev,
    required this.onNext,
    required this.onToggleList,
    required this.paperFilter,
    required this.typeFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppTheme.divider)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Row 1: Search + Lang + Font + Nav
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
            child: Wrap(
              spacing: 10,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isWide) ...[
                      // Toggle list button
                      _ToolBtn(
                        tooltip: isListCollapsed ? 'Show Question List' : 'Focus Mode',
                        icon: isListCollapsed ? Icons.view_list_rounded : Icons.chrome_reader_mode_outlined,
                        active: isListCollapsed,
                        onTap: onToggleList,
                      ),
                      const SizedBox(width: 8),
                    ],
                    // Search field
                    SizedBox(
                      width: 230,
                      height: 34,
                      child: TextField(
                        controller: searchCtrl,
                        style: const TextStyle(fontSize: 13),
                        decoration: InputDecoration(
                          hintText: 'Search questions...',
                          hintStyle: const TextStyle(fontSize: 12.5, color: AppTheme.textMuted),
                          prefixIcon: const Icon(Icons.search_rounded, size: 17, color: AppTheme.primaryColor),
                          suffixIcon: searchCtrl.text.isNotEmpty
                              ? InkWell(
                                  onTap: onClearSearch,
                                  child: const Icon(Icons.close_rounded, size: 15, color: AppTheme.textMuted),
                                )
                              : null,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(vertical: 9),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(color: AppTheme.divider),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(color: AppTheme.divider),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide(color: AppTheme.iconRed.withOpacity(0.5)),
                          ),
                        ),
                        onChanged: onSearch,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Lang toggle
                    _SegToggle(
                      options: const ['नेपाली', 'English'],
                      values: const ['nepali', 'english'],
                      selected: lang,
                      onChanged: onLangChanged,
                    ),
                    const SizedBox(width: 10),
                    // Font size
                    _FontControl(
                      size: fontSize,
                      onDec: onFontDec,
                      onInc: onFontInc,
                    ),
                    const SizedBox(width: 10),
                    // Progress pill
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F4F5),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppTheme.divider),
                      ),
                      child: Text(
                        '✓ $studiedCount / $total',
                        style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ),
                    if (isWide && currentIdx >= 0) ...[
                      const SizedBox(width: 10),
                      // Prev / Next
                      _NavControl(
                        currentIdx: currentIdx,
                        total: total,
                        onPrev: onPrev,
                        onNext: onNext,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          // Row 2: Filter chips
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 8, 14, 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _Chip(
                    label: 'All',
                    active: paperFilter == null && typeFilter == null,
                    onTap: () => onFilterChanged(null, null),
                  ),
                  const SizedBox(width: 6),
                  _Chip(
                    label: 'Paper I',
                    active: paperFilter == PaperType.paper1,
                    onTap: () => onFilterChanged(
                      paperFilter == PaperType.paper1 ? null : PaperType.paper1,
                      typeFilter,
                    ),
                  ),
                  const SizedBox(width: 6),
                  _Chip(
                    label: 'Paper II',
                    active: paperFilter == PaperType.paper2,
                    onTap: () => onFilterChanged(
                      paperFilter == PaperType.paper2 ? null : PaperType.paper2,
                      typeFilter,
                    ),
                  ),
                  const SizedBox(width: 6),
                  _Chip(
                    label: 'Subjective',
                    active: typeFilter == QuestionType.subjective,
                    onTap: () => onFilterChanged(
                      paperFilter,
                      typeFilter == QuestionType.subjective ? null : QuestionType.subjective,
                    ),
                  ),
                  const SizedBox(width: 6),
                  _Chip(
                    label: 'MCQ',
                    active: typeFilter == QuestionType.mcq,
                    onTap: () => onFilterChanged(
                      paperFilter,
                      typeFilter == QuestionType.mcq ? null : QuestionType.mcq,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Small reusable toolbar widgets ─────────────────────────────
class _ToolBtn extends StatelessWidget {
  final String tooltip;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;
  const _ToolBtn({required this.tooltip, required this.icon, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) => Tooltip(
    message: tooltip,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: active ? AppTheme.iconRedLight : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: active ? AppTheme.iconRed.withOpacity(0.35) : AppTheme.divider),
        ),
        child: Icon(icon, size: 16, color: active ? AppTheme.iconRed : AppTheme.primaryColor),
      ),
    ),
  );
}

class _SegToggle extends StatelessWidget {
  final List<String> options;
  final List<String> values;
  final String selected;
  final ValueChanged<String> onChanged;
  const _SegToggle({required this.options, required this.values, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F5),
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: AppTheme.divider),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(options.length, (i) {
          final isActive = values[i] == selected;
          return GestureDetector(
            onTap: () => onChanged(values[i]),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: isActive ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(5),
                boxShadow: isActive
                    ? [BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 4, offset: const Offset(0, 1))]
                    : null,
              ),
              child: Text(
                options[i],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  color: isActive ? AppTheme.textPrimary : AppTheme.textMuted,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _FontControl extends StatelessWidget {
  final double size;
  final VoidCallback onDec;
  final VoidCallback onInc;
  const _FontControl({required this.size, required this.onDec, required this.onInc});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.divider),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onDec,
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(5)),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 9, vertical: 5),
              child: Text('A−', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppTheme.textPrimary)),
            ),
          ),
          Container(width: 1, height: 16, color: AppTheme.divider),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: Text('${size.toInt()}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.textMuted)),
          ),
          Container(width: 1, height: 16, color: AppTheme.divider),
          InkWell(
            onTap: onInc,
            borderRadius: const BorderRadius.horizontal(right: Radius.circular(5)),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 9, vertical: 5),
              child: Text('A+', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppTheme.textPrimary)),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavControl extends StatelessWidget {
  final int currentIdx;
  final int total;
  final VoidCallback? onPrev;
  final VoidCallback? onNext;
  const _NavControl({required this.currentIdx, required this.total, this.onPrev, this.onNext});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Tooltip(
          message: 'Previous (${currentIdx > 0 ? currentIdx : "–"})',
          child: InkWell(
            onTap: onPrev,
            borderRadius: BorderRadius.circular(5),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppTheme.divider),
              ),
              child: Icon(Icons.chevron_left_rounded, size: 16,
                  color: onPrev != null ? AppTheme.textPrimary : AppTheme.divider),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            '${currentIdx + 1} / $total',
            style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ),
        Tooltip(
          message: 'Next (${currentIdx < total - 1 ? currentIdx + 2 : "–"})',
          child: InkWell(
            onTap: onNext,
            borderRadius: BorderRadius.circular(5),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: onNext != null ? AppTheme.iconRed : Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: onNext != null ? AppTheme.iconRed : AppTheme.divider),
              ),
              child: Icon(Icons.chevron_right_rounded, size: 16,
                  color: onNext != null ? Colors.white : AppTheme.divider),
            ),
          ),
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _Chip({required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 140),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: active ? AppTheme.iconRedLight : Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: active ? AppTheme.iconRed.withOpacity(0.4) : AppTheme.divider),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
            color: active ? AppTheme.iconRedDark : AppTheme.textPrimary,
          ),
        ),
      ),
    );
  }
}

// ── Question Index (Left Panel) ─────────────────────────────────
class _QuestionIndex extends StatelessWidget {
  final List<Question> questions;
  final String? selectedId;
  final String lang;
  final AppUser user;
  final Set<String> studiedIds;
  final ValueChanged<Question> onSelect;
  final ValueChanged<String> onToggleStudied;

  const _QuestionIndex({
    required this.questions,
    required this.selectedId,
    required this.lang,
    required this.user,
    required this.studiedIds,
    required this.onSelect,
    required this.onToggleStudied,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFAFAFA),
      child: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (ctx, i) {
          final q = questions[i];
          final active = q.id == selectedId;
          final studied = studiedIds.contains(q.id);
          final isMcq = q.type == QuestionType.mcq;
          final locked = q.isPremium && !user.isPremium;

          return InkWell(
            onTap: () => onSelect(q),
            child: Container(
              decoration: BoxDecoration(
                color: active ? Colors.white : Colors.transparent,
                border: Border(
                  left: BorderSide(
                    color: active ? AppTheme.iconRed : Colors.transparent,
                    width: 3,
                  ),
                  bottom: const BorderSide(color: AppTheme.divider, width: 0.5),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(14, 11, 12, 11),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Number badge
                  SizedBox(
                    width: 36,
                    child: Column(
                      children: [
                        Container(
                          width: 32,
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          decoration: BoxDecoration(
                            color: active
                                ? AppTheme.iconRed
                                : (isMcq ? const Color(0xFFEEEEEE) : AppTheme.iconRedLight),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${i + 1}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: active ? Colors.white : (isMcq ? AppTheme.textMuted : AppTheme.iconRedDark),
                                ),
                              ),
                              Text(
                                isMcq ? 'MCQ' : '${q.marks}M',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  color: active ? Colors.white.withOpacity(0.85) : (isMcq ? AppTheme.textMuted : AppTheme.iconRed),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lang == 'english' ? q.questionEnglish : q.questionNepali,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.5,
                            height: 1.4,
                            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                            color: active ? AppTheme.textPrimary : const Color(0xFF3F3F46),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'P${q.paper == PaperType.paper1 ? "1" : "2"} · U${q.unitNumber}${q.yearsAsked.isNotEmpty ? " · ${q.yearsAsked.first}" : ""}',
                          style: const TextStyle(fontSize: 10.5, color: AppTheme.textMuted),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 4),
                  Column(
                    children: [
                      if (locked)
                        const Icon(Icons.lock_outline_rounded, size: 13, color: AppTheme.textMuted),
                      const SizedBox(height: 2),
                      GestureDetector(
                        onTap: () => onToggleStudied(q.id),
                        child: Icon(
                          studied ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                          size: 16,
                          color: studied ? AppTheme.iconRed : const Color(0xFFD4D4D8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── Empty states ────────────────────────────────────────────────
class _EmptyReader extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    color: Colors.white,
    child: const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.menu_book_outlined, size: 40, color: AppTheme.divider),
          SizedBox(height: 12),
          Text(
            'Select a question to begin studying',
            style: TextStyle(fontSize: 14, color: AppTheme.textMuted),
          ),
        ],
      ),
    ),
  );
}

class _EmptyState extends StatelessWidget {
  final VoidCallback onReset;
  const _EmptyState({required this.onReset});

  @override
  Widget build(BuildContext context) => Container(
    color: Colors.white,
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.search_off_rounded, size: 36, color: AppTheme.textMuted),
          const SizedBox(height: 12),
          const Text('No questions match your filter', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textPrimary)),
          const SizedBox(height: 6),
          const Text('Try a different search term or filter chip', style: TextStyle(color: AppTheme.textMuted, fontSize: 13)),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: onReset,
            style: OutlinedButton.styleFrom(foregroundColor: AppTheme.iconRed, side: const BorderSide(color: AppTheme.iconRed)),
            child: const Text('Reset Filters'),
          ),
        ],
      ),
    ),
  );
}

// ── The Study Reader (Right Pane) ───────────────────────────────
class _StudyReader extends StatefulWidget {
  final Question question;
  final String lang;
  final double fontSize;
  final bool isStudied;
  final VoidCallback onToggleStudied;
  final VoidCallback? onBack;

  const _StudyReader({
    super.key,
    required this.question,
    required this.lang,
    required this.fontSize,
    required this.isStudied,
    required this.onToggleStudied,
    this.onBack,
  });

  @override
  State<_StudyReader> createState() => _StudyReaderState();
}

class _StudyReaderState extends State<_StudyReader> {
  final _scroll = ScrollController();

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final plan = auth.user?.plan ?? SubscriptionPlan.free;
    final locked = plan == SubscriptionPlan.free && widget.question.isPremium;

    final questionText = widget.lang == 'english'
        ? widget.question.questionEnglish
        : widget.question.questionNepali;

    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        controller: _scroll,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 820),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Back button (mobile) ──
                if (widget.onBack != null) ...[
                  GestureDetector(
                    onTap: widget.onBack,
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.arrow_back_rounded, size: 15, color: AppTheme.textMuted),
                        SizedBox(width: 4),
                        Text('Back', style: TextStyle(fontSize: 13, color: AppTheme.textMuted)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],

                // ── Meta row ──
                Row(
                  children: [
                    _MetaBadge(
                      widget.question.paper == PaperType.paper1 ? 'Paper I' : 'Paper II',
                      red: true,
                    ),
                    const SizedBox(width: 6),
                    _MetaBadge('Unit ${widget.question.unitNumber}'),
                    const SizedBox(width: 6),
                    if (widget.question.type == QuestionType.mcq)
                      const _MetaBadge('MCQ')
                    else
                      _MetaBadge('${widget.question.marks} Marks', red: true),
                    if (widget.question.yearsAsked.isNotEmpty) ...[
                      const SizedBox(width: 6),
                      _MetaBadge(widget.question.yearsAsked.join(' · ')),
                    ],
                    const Spacer(),
                    // Studied toggle
                    GestureDetector(
                      onTap: widget.onToggleStudied,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: widget.isStudied ? AppTheme.iconRedLight : Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: widget.isStudied ? AppTheme.iconRed.withOpacity(0.4) : AppTheme.divider,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              widget.isStudied ? Icons.check_circle_rounded : Icons.check_circle_outline_rounded,
                              size: 14,
                              color: widget.isStudied ? AppTheme.iconRed : AppTheme.textMuted,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              widget.isStudied ? 'Revised' : 'Mark Revised',
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                                color: widget.isStudied ? AppTheme.iconRedDark : AppTheme.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // ── Question Text ──
                SelectableText(
                  questionText,
                  style: TextStyle(
                    fontSize: widget.fontSize + 2,
                    fontWeight: FontWeight.w700,
                    height: 1.6,
                    color: AppTheme.textPrimary,
                    letterSpacing: -0.2,
                  ),
                ),

                const SizedBox(height: 28),

                // ── Divider ──
                const Divider(color: AppTheme.divider, height: 1),
                const SizedBox(height: 24),

                // ── Answer Area ──
                if (widget.question.type == QuestionType.mcq)
                  _MCQView(question: widget.question, fontSize: widget.fontSize)
                else if (locked)
                  _PaywallCard()
                else
                  _SubjectiveView(
                    question: widget.question,
                    lang: widget.lang,
                    fontSize: widget.fontSize,
                  ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MetaBadge extends StatelessWidget {
  final String text;
  final bool red;
  const _MetaBadge(this.text, {this.red = false});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
    decoration: BoxDecoration(
      color: red ? AppTheme.iconRedLight : const Color(0xFFF4F4F5),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: red ? AppTheme.iconRed.withOpacity(0.3) : AppTheme.divider),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: red ? AppTheme.iconRedDark : AppTheme.textPrimary,
      ),
    ),
  );
}

// ── MCQ Interactive Practice ────────────────────────────────────
class _MCQView extends StatefulWidget {
  final Question question;
  final double fontSize;
  const _MCQView({required this.question, required this.fontSize});
  @override
  State<_MCQView> createState() => _MCQViewState();
}

class _MCQViewState extends State<_MCQView> {
  int? _chosen;
  bool _revealed = false;

  @override
  void didUpdateWidget(_MCQView old) {
    super.didUpdateWidget(old);
    if (old.question.id != widget.question.id) {
      _chosen = null;
      _revealed = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final opts = widget.question.options ?? [];
    final correct = widget.question.correctOptionIndex ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Choose an option to test yourself',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textMuted),
            ),
            const Spacer(),
            if (_revealed || _chosen != null)
              TextButton(
                onPressed: () => setState(() { _chosen = null; _revealed = false; }),
                style: TextButton.styleFrom(foregroundColor: AppTheme.textMuted),
                child: const Text('Reset', style: TextStyle(fontSize: 12)),
              ),
          ],
        ),
        const SizedBox(height: 14),
        ...opts.asMap().entries.map((e) {
          final idx = e.key;
          final label = String.fromCharCode(65 + idx);
          Color bg = Colors.white;
          Color border = AppTheme.divider;
          Color textColor = AppTheme.textPrimary;

          if (_revealed) {
            if (idx == correct) {
              bg = const Color(0xFFF4F4F5);
              border = AppTheme.primaryColor;
              textColor = AppTheme.textPrimary;
            } else if (idx == _chosen) {
              bg = AppTheme.iconRedLight;
              border = AppTheme.iconRed;
              textColor = AppTheme.iconRedDark;
            }
          } else if (idx == _chosen) {
            bg = const Color(0xFFF4F4F5);
            border = AppTheme.primaryColor;
          }

          return GestureDetector(
            onTap: () => setState(() { _chosen = idx; _revealed = true; }),
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: border, width: border == AppTheme.divider ? 1 : 1.5),
              ),
              child: Row(
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: border == AppTheme.divider ? const Color(0xFFF4F4F5) : border,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        label,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: border == AppTheme.divider ? AppTheme.textPrimary : Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      e.value,
                      style: TextStyle(
                        fontSize: widget.fontSize,
                        fontWeight: _revealed && idx == correct ? FontWeight.w700 : FontWeight.w400,
                        color: textColor,
                        height: 1.45,
                      ),
                    ),
                  ),
                  if (_revealed && idx == correct)
                    const Icon(Icons.check_circle_rounded, color: AppTheme.primaryColor, size: 18),
                  if (_revealed && idx == _chosen && idx != correct)
                    const Icon(Icons.cancel_rounded, color: AppTheme.iconRed, size: 18),
                ],
              ),
            ),
          );
        }),
        if (_revealed && widget.question.explanation != null) ...[
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.divider),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.lightbulb_outline_rounded, size: 15, color: AppTheme.iconRed),
                    SizedBox(width: 6),
                    Text('Explanation', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppTheme.textPrimary)),
                  ],
                ),
                const SizedBox(height: 8),
                _AnswerBody.richText(
                  widget.question.explanation!,
                  baseStyle: TextStyle(fontSize: widget.fontSize - 0.5, height: 1.7, color: AppTheme.textBody),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

// ── Subjective Model Answer ─────────────────────────────────────
class _SubjectiveView extends StatelessWidget {
  final Question question;
  final String lang;
  final double fontSize;
  const _SubjectiveView({required this.question, required this.lang, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    final nepaliText = question.answerNepali ?? 'उत्तर उपलब्ध छैन।';
    final englishText = question.answerEnglish ?? 'Answer not available.';
    final activeText = lang == 'english' ? englishText : nepaliText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row
        Row(
          children: [
            const Icon(Icons.verified_rounded, size: 15, color: AppTheme.iconRed),
            const SizedBox(width: 6),
            Text(
              'MODEL ANSWER · ${question.marks} MARKS',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
                color: AppTheme.textMuted,
              ),
            ),
            const Spacer(),
            // Copy
            InkWell(
              onTap: () {
                final cleanCopy = activeText.replaceAll('**', '');
                Clipboard.setData(ClipboardData(text: '${lang == "english" ? question.questionEnglish : question.questionNepali}\n\n$cleanCopy'));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Copied to clipboard'), duration: Duration(seconds: 2)),
                );
              },
              borderRadius: BorderRadius.circular(5),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.copy_outlined, size: 13, color: AppTheme.textMuted),
                    SizedBox(width: 4),
                    Text('Copy', style: TextStyle(fontSize: 12, color: AppTheme.textMuted)),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        // Answer body
        _AnswerBody(content: activeText, fontSize: fontSize),
        const SizedBox(height: 24),
        // Writing tip
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: AppTheme.divider),
          ),
          child: Text(
            question.marks >= 10
                ? '📝 Exam Tip: Write a 3-tier answer — Definition/Context → Core Points with headings → Way Forward/Conclusion. Aim for ${question.marks == 10 ? "400–500 words" : "600–700 words"}.'
                : '📝 Exam Tip: Open directly with the concept → ${question.marks == 5 ? "5–6 crisp bullets" : "2–3 well-developed points"} → Brief conclusion. Aim for ${question.marks * 45}–${question.marks * 55} words.',
            style: const TextStyle(fontSize: 12.5, color: AppTheme.textBody, height: 1.55),
          ),
        ),
      ],
    );
  }
}

class _AnswerBody extends StatelessWidget {
  final String content;
  final double fontSize;
  const _AnswerBody({required this.content, required this.fontSize});

  /// Parses inline `**bold**` markers into [TextSpan] children and renders with [SelectableText.rich].
  static Widget richText(String raw, {required TextStyle baseStyle}) {
    final spans = <TextSpan>[];
    final regex = RegExp(r'\*\*(.+?)\*\*');
    int lastEnd = 0;
    for (final match in regex.allMatches(raw)) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(text: raw.substring(lastEnd, match.start)));
      }
      spans.add(
        TextSpan(
          text: match.group(1),
          style: baseStyle.copyWith(fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
        ),
      );
      lastEnd = match.end;
    }
    if (lastEnd < raw.length) {
      spans.add(TextSpan(text: raw.substring(lastEnd).replaceAll('**', '')));
    }
    if (spans.isEmpty) {
      return SelectableText(raw.replaceAll('**', ''), style: baseStyle);
    }
    return SelectableText.rich(TextSpan(style: baseStyle, children: spans));
  }

  @override
  Widget build(BuildContext context) {
    final blocks = content.split('\n\n').where((b) => b.trim().isNotEmpty).toList();
    if (blocks.isEmpty) {
      return richText(content, baseStyle: TextStyle(fontSize: fontSize, height: 1.85, color: AppTheme.textPrimary));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: blocks.map((block) {
        final lines = block.split('\n').where((l) => l.trim().isNotEmpty).toList();
        return Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: lines.map((line) {
              final t = line.trim();
              final cleanForCheck = t.replaceAll('**', '').trim();
              final isFullBoldLine = t.startsWith('**') && t.endsWith('**') && cleanForCheck.length < 90;
              final isHeading = isFullBoldLine ||
                  (cleanForCheck.endsWith(':') && cleanForCheck.length < 80 && !t.startsWith('•') && !t.startsWith('-') && !t.startsWith('* ')) ||
                  RegExp(r'^[१२३४५६७८९1-9][.।]').hasMatch(cleanForCheck) ||
                  cleanForCheck.startsWith('Introduction') || cleanForCheck.startsWith('Conclusion') ||
                  cleanForCheck.startsWith('Way Forward') || cleanForCheck.startsWith('परिचय') || cleanForCheck.startsWith('निष्कर्ष');
              final isBullet = t.startsWith('•') || t.startsWith('-') || (t.startsWith('*') && !t.startsWith('**'));

              if (isHeading) {
                return Container(
                  margin: const EdgeInsets.only(top: 8, bottom: 6),
                  padding: const EdgeInsets.only(left: 12),
                  decoration: const BoxDecoration(
                    border: Border(left: BorderSide(color: AppTheme.iconRed, width: 2.5)),
                  ),
                  child: SelectableText(
                    cleanForCheck,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w800,
                      height: 1.55,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                );
              }

              if (isBullet) {
                final bulletContent = t.replaceFirst(RegExp(r'^[•\-\*]\s*'), '');
                return Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: fontSize * 0.42, right: 10),
                        child: Container(
                          width: 5, height: 5,
                          decoration: BoxDecoration(
                            color: AppTheme.iconRed.withOpacity(0.6),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Expanded(
                        child: richText(
                          bulletContent,
                          baseStyle: TextStyle(fontSize: fontSize, height: 1.8, color: AppTheme.textPrimary),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: richText(
                  t,
                  baseStyle: TextStyle(fontSize: fontSize, height: 1.85, color: AppTheme.textPrimary),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}

class _PaywallCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.iconRed.withOpacity(0.35), width: 1.2),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: AppTheme.iconRedLight, borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.lock_outline_rounded, size: 32, color: AppTheme.iconRed),
          ),
          const SizedBox(height: 14),
          const Text(
            'Pro Model Answer Locked',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
          ),
          const SizedBox(height: 8),
          const Text(
            'Upgrade to Pro Plan (रू 299/month) to unlock all Paper I, Paper II & Paper III model answers.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppTheme.textMuted, fontSize: 13, height: 1.5),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () => GoRouter.of(context).go(AppConstants.routeSubscription),
            icon: const Icon(Icons.lock_open_rounded, size: 16, color: Colors.white),
            label: const Text('Unlock All Answers'),
            style: FilledButton.styleFrom(
              backgroundColor: AppTheme.iconRed,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotEnrolledPrompt extends StatelessWidget {
  final VoidCallback? onGoToExams;
  const _NotEnrolledPrompt({this.onGoToExams});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.divider),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.iconRedLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.how_to_reg_rounded, size: 36, color: AppTheme.iconRed),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Enroll in an Exam Course First',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'To keep your study focused and distraction-free, only questions, mock tests, and syllabus from your enrolled exam course are displayed here.',
                  style: TextStyle(fontSize: 13, color: AppTheme.textMuted, height: 1.5),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: onGoToExams,
                  icon: const Icon(Icons.library_books_outlined, size: 17, color: Colors.white),
                  label: const Text('Browse & Enroll in an Exam'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppTheme.iconRed,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 13),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Mock Test Tab ────────────────────────────────────────────
class MockTestTab extends StatelessWidget {
  final VoidCallback? onGoToExams;
  const MockTestTab({super.key, this.onGoToExams});

  @override
  Widget build(BuildContext context) {
    final mt = context.watch<MockTestProvider>();
    final qp = context.watch<QuestionProvider>();
    final auth = context.watch<AuthProvider>();
    final user = auth.user;

    final isEnrolled = (user?.isAdmin ?? false) || (user?.enrolledExams.isNotEmpty ?? false);
    if (!isEnrolled) {
      return _NotEnrolledPrompt(onGoToExams: onGoToExams);
    }

    if (!mt.isStarted && mt.lastResult == null) {
      return _TestStartScreen(
        onStart: () {
          final mcqs = qp.getMCQs(
            premiumAllowed: user?.isBasicOrAbove ?? false,
            enrolledExams: (user?.isAdmin ?? false) ? const [] : (user?.enrolledExams ?? const []),
          );
          mt.startTest(mcqs);
        },
      );
    }

    if (mt.lastResult != null) {
      return _TestResultView(result: mt.lastResult!, questions: mt.questions, onRetry: mt.reset);
    }

    return _ActiveTestView();
  }
}

class _TestStartScreen extends StatelessWidget {
  final VoidCallback onStart;
  const _TestStartScreen({required this.onStart});

  @override
  Widget build(BuildContext context) {
    final qp = context.watch<QuestionProvider>();
    final examTitle = qp.selectedExam?.title ?? 'Lok Sewa Objective Exam';
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppTheme.divider),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(color: AppTheme.iconRedLight, borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.timer_outlined, size: 42, color: AppTheme.iconRed),
              ),
              const SizedBox(height: 20),
              const Text('Timed MCQ Mock Test', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppTheme.textPrimary)),
              const SizedBox(height: 6),
              Text(examTitle, style: const TextStyle(color: AppTheme.textMuted, fontSize: 13), textAlign: TextAlign.center),
              const SizedBox(height: 24),
              _rule(Icons.timer_outlined, '45 Minutes Time Limit', true),
              _rule(Icons.quiz_outlined, 'Multiple Choice Questions (MCQs)', false),
              _rule(Icons.check_circle_outline_rounded, '1 or 2 Marks per Correct Answer', true),
              _rule(Icons.analytics_outlined, 'Instant Score & Detailed Explanation', false),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: onStart,
                  icon: const Icon(Icons.play_arrow_rounded, color: Colors.white),
                  label: const Text('Start Mock Test', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppTheme.iconRed,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _rule(IconData icon, String text, bool isRed) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Icon(icon, size: 18, color: isRed ? AppTheme.iconRed : AppTheme.primaryColor),
        const SizedBox(width: 10),
        Text(text, style: const TextStyle(fontSize: 13.5, color: AppTheme.textBody)),
      ],
    ),
  );
}

class _ActiveTestView extends StatefulWidget {
  @override
  State<_ActiveTestView> createState() => _ActiveTestViewState();
}

class _ActiveTestViewState extends State<_ActiveTestView> {
  Timer? _timer;
  DateTime? _startTime;

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      final elapsed = DateTime.now().difference(_startTime!);
      context.read<MockTestProvider>().updateElapsed(elapsed);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mt = context.watch<MockTestProvider>();
    final q = mt.currentQuestion;
    if (q == null) return const SizedBox.shrink();
    final remaining = mt.remaining;

    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: AppTheme.divider, width: 1)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              const Icon(Icons.timer_outlined, color: AppTheme.iconRed, size: 20),
              const SizedBox(width: 8),
              Text(
                '${remaining.inMinutes.toString().padLeft(2, '0')}:${(remaining.inSeconds % 60).toString().padLeft(2, '0')}',
                style: const TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.w800, fontSize: 18),
              ),
              const Spacer(),
              Text(
                'Question ${mt.currentIndex + 1} of ${mt.questions.length}',
                style: const TextStyle(color: AppTheme.textMuted, fontSize: 13, fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 16),
              FilledButton(
                onPressed: () {
                  _timer?.cancel();
                  context.read<MockTestProvider>().submitTest();
                },
                style: FilledButton.styleFrom(
                  backgroundColor: AppTheme.iconRed,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Submit Test', style: TextStyle(fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ),
        LinearProgressIndicator(
          value: (mt.currentIndex + 1) / mt.questions.length,
          backgroundColor: AppTheme.divider,
          color: AppTheme.iconRed,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Question ${mt.currentIndex + 1}', style: const TextStyle(color: AppTheme.iconRed, fontSize: 12, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  Text(q.questionEnglish, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, height: 1.5, color: AppTheme.textPrimary)),
                  const SizedBox(height: 6),
                  Text(q.questionNepali, style: const TextStyle(fontSize: 14, color: AppTheme.textMuted, height: 1.5)),
                  const SizedBox(height: 24),
                  ...(q.options ?? []).asMap().entries.map((e) {
                    final idx = e.key;
                    final opt = e.value;
                    final chosen = mt.answers[q.id] == idx;
                    return GestureDetector(
                      onTap: () => mt.answerQuestion(q.id, idx),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: chosen ? AppTheme.iconRedLight.withOpacity(0.5) : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: chosen ? AppTheme.iconRed : AppTheme.divider,
                            width: chosen ? 1.6 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: chosen ? AppTheme.iconRed : const Color(0xFFF4F4F5),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  String.fromCharCode(65 + idx),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: chosen ? Colors.white : AppTheme.textPrimary,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(child: Text(opt, style: const TextStyle(fontSize: 14, color: AppTheme.textPrimary))),
                          ],
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      if (mt.currentIndex > 0)
                        OutlinedButton.icon(
                          onPressed: () => mt.jumpTo(mt.currentIndex - 1),
                          icon: const Icon(Icons.arrow_back_rounded, size: 16),
                          label: const Text('Previous'),
                        ),
                      const Spacer(),
                      if (mt.currentIndex < mt.questions.length - 1)
                        FilledButton.icon(
                          onPressed: () => mt.jumpTo(mt.currentIndex + 1),
                          icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                          label: const Text('Next'),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TestResultView extends StatelessWidget {
  final MockTestResult result;
  final List<Question> questions;
  final VoidCallback onRetry;
  const _TestResultView({required this.result, required this.questions, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppTheme.divider, width: 1.5),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppTheme.iconRedLight,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        result.isPassing ? Icons.emoji_events_outlined : Icons.flag_outlined,
                        color: AppTheme.iconRed,
                        size: 44,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      result.isPassing ? 'Passed!' : 'Keep Practicing!',
                      style: const TextStyle(color: AppTheme.textPrimary, fontSize: 22, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Score: ${result.correct}/${result.totalQuestions} (${result.percentage.toStringAsFixed(1)}%)',
                      style: const TextStyle(color: AppTheme.textBody, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded, color: Colors.white),
                label: const Text('Take Another Test'),
                style: FilledButton.styleFrom(backgroundColor: AppTheme.iconRed, foregroundColor: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Dynamic Syllabus Tab ─────────────────────────────────────
class SyllabusTab extends StatelessWidget {
  final VoidCallback? onGoToExams;
  const SyllabusTab({super.key, this.onGoToExams});

  @override
  Widget build(BuildContext context) {
    final qp = context.watch<QuestionProvider>();
    final auth = context.watch<AuthProvider>();
    final user = auth.user;

    final isEnrolled = (user?.isAdmin ?? false) || (user?.enrolledExams.isNotEmpty ?? false);
    if (!isEnrolled) {
      return _NotEnrolledPrompt(onGoToExams: onGoToExams);
    }

    final exam = qp.selectedExam;

    if (exam == null) {
      return const Center(child: CircularProgressIndicator(color: AppTheme.iconRed));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
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
                    const Icon(Icons.account_balance_outlined, size: 16, color: AppTheme.iconRed),
                    const SizedBox(width: 6),
                    Text(
                      '${exam.organization} • ${exam.level}',
                      style: const TextStyle(color: AppTheme.iconRedDark, fontSize: 12, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  exam.title,
                  style: const TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.w800, fontSize: 20),
                ),
                const SizedBox(height: 4),
                Text(
                  exam.titleNepali,
                  style: const TextStyle(color: AppTheme.textMuted, fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          if (exam.examScheme.isNotEmpty) ...[
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
                  const Row(
                    children: [
                      Icon(Icons.assignment_turned_in_outlined, color: AppTheme.iconRed, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Examination Scheme (परीक्षा योजना)',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
                      ),
                    ],
                  ),
                  const Divider(height: 20, color: AppTheme.divider),
                  ...exam.examScheme.map((s) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.check_circle_outline_rounded, size: 16, color: AppTheme.iconRed),
                        const SizedBox(width: 8),
                        Expanded(child: Text(s, style: const TextStyle(fontSize: 13.5, height: 1.4, color: AppTheme.textBody))),
                      ],
                    ),
                  )),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
          ...exam.syllabusSections.map((sec) => Container(
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.divider),
            ),
            child: ExpansionTile(
              initiallyExpanded: true,
              iconColor: AppTheme.iconRed,
              collapsedIconColor: AppTheme.primaryColor,
              title: Text(sec.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: AppTheme.textPrimary)),
              children: sec.topics.map((t) => ListTile(
                dense: true,
                leading: const Icon(Icons.chevron_right_rounded, color: AppTheme.iconRed, size: 18),
                title: Text(t, style: const TextStyle(fontSize: 13.5, color: AppTheme.textBody)),
              )).toList(),
            ),
          )),
        ],
      ),
    );
  }
}
