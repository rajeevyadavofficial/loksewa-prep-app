import 'dart:async';
import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';
import '../../data/models/models.dart';
import '../../data/repositories/providers.dart';
import 'model_questions_tab.dart';
import 'study_notes_tab.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  bool _sidebarCollapsed = false;
  bool _isFullFocusMode = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuestionProvider>().loadAll();
    });
  }

  void _setTab(int i) {
    setState(() {
      _selectedIndex = i;
      if (i != 1) {
        _isFullFocusMode = false;
      }
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
    final isSmallMobile = w < 420;
    final hideChrome = _isFullFocusMode && _selectedIndex == 1;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: isWide
            ? Row(
                children: [
                  if (!hideChrome)
                    _SideNav(
                      selectedIndex: _selectedIndex,
                      isCollapsed: _sidebarCollapsed,
                      onToggleCollapse: () => setState(() => _sidebarCollapsed = !_sidebarCollapsed),
                      onTap: _setTab,
                    ),
                  Expanded(child: _buildBody(user, isWide: true, hideTopBar: hideChrome)),
                ],
              )
            : Column(
                children: [
                  Expanded(child: _buildBody(user, isWide: false, hideTopBar: hideChrome)),
                  if (!hideChrome)
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(top: BorderSide(color: AppTheme.divider, width: 1)),
                      ),
                      child: NavigationBar(
                        height: isSmallMobile ? 60 : 66,
                        selectedIndex: _selectedIndex,
                        onDestinationSelected: _setTab,
                        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                        destinations: [
                          const NavigationDestination(
                            icon: Icon(Icons.dashboard_outlined, size: 20),
                            selectedIcon: Icon(Icons.dashboard, size: 20),
                            label: 'Exams',
                          ),
                          NavigationDestination(
                            icon: const Icon(Icons.menu_book_outlined, size: 20),
                            selectedIcon: const Icon(Icons.menu_book, size: 20),
                            label: isSmallMobile ? 'Q&A' : 'Q&A Bank',
                          ),
                          NavigationDestination(
                            icon: const Icon(Icons.timer_outlined, size: 20),
                            selectedIcon: const Icon(Icons.timer, size: 20),
                            label: isSmallMobile ? 'Mock' : 'Mock Test',
                          ),
                          const NavigationDestination(
                            icon: Icon(Icons.description_outlined, size: 20),
                            selectedIcon: Icon(Icons.description, size: 20),
                            label: 'Syllabus',
                          ),
                          NavigationDestination(
                            icon: const Icon(Icons.volunteer_activism_outlined, size: 20),
                            selectedIcon: const Icon(Icons.volunteer_activism, size: 20),
                            label: isSmallMobile ? 'Earn' : 'Donate',
                          ),
                          NavigationDestination(
                            icon: const Icon(Icons.article_outlined, size: 20),
                            selectedIcon: const Icon(Icons.article, size: 20),
                            label: isSmallMobile ? 'Model' : 'Model Q',
                          ),
                          NavigationDestination(
                            icon: const Icon(Icons.auto_stories_outlined, size: 20),
                            selectedIcon: const Icon(Icons.auto_stories, size: 20),
                            label: isSmallMobile ? 'Notes' : 'Notes',
                          ),
                        ],
                      ),
                    ),
                ],
              ),
      ),
    );
  }

  Widget _buildBody(AppUser user, {required bool isWide, required bool hideTopBar}) {
    return Column(
      children: [
        if (!hideTopBar)
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
              _HomeTab(user: user, onGoToTab: _setTab),
              QuestionsTab(
                onGoToExams: () => _setTab(0),
                isFullFocusMode: _isFullFocusMode,
                onToggleFullFocusMode: (val) => setState(() => _isFullFocusMode = val),
              ),
              MockTestTab(onGoToExams: () => _setTab(0)),
              SyllabusTab(onGoToExams: () => _setTab(0)),
              DonateQuestionsTab(onGoToExams: () => _setTab(0)),
              ModelQuestionsTab(onGoToExams: () => _setTab(0)),
              StudyNotesTab(onGoToExams: () => _setTab(0)),
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
    (Icons.volunteer_activism_outlined, Icons.volunteer_activism_rounded, 'Donate & Earn (रू 5)'),
    (Icons.article_outlined, Icons.article_rounded, 'Model Questions'),
    (Icons.auto_stories_outlined, Icons.auto_stories_rounded, 'Study Notes'),
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
                              'LoksewaHero',
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
                      _PlanBadgeWidget(plan: user.plan, isAdmin: user.isAdmin),
                      if (user.plan == SubscriptionPlan.free && !user.isAdmin) ...[
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
  final bool isAdmin;
  const _PlanBadgeWidget({required this.plan, this.isAdmin = false});

  @override
  Widget build(BuildContext context) {
    if (isAdmin) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          color: AppTheme.bgSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppTheme.primaryColor),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.admin_panel_settings_rounded, size: 14, color: AppTheme.primaryColor),
            SizedBox(width: 6),
            Text(
              'ADMINISTRATOR (LIFETIME)',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w800,
                fontSize: 11,
              ),
            ),
          ],
        ),
      );
    }
    final (label, isRed) = switch (plan) {
      SubscriptionPlan.premium => ('PRO PLAN (रू 199)', true),
      SubscriptionPlan.basic => ('PRO PLAN (रू 199)', true),
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
    final auth = context.read<AuthProvider>();
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
    final screenW = MediaQuery.of(context).size.width;
    final isMobile = screenW < 650;
    final isTinyMobile = screenW < 375;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppTheme.divider, width: 1)),
      ),
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 10 : 20, vertical: isMobile ? 7 : 10),
      child: Row(
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
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 540),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 9 : 12, vertical: isMobile ? 5 : 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.divider),
                  ),
                  child: Row(
                    mainAxisSize: isMobile ? MainAxisSize.max : MainAxisSize.min,
                    children: [
                      const Icon(Icons.menu_book_rounded, size: 15, color: AppTheme.iconRed),
                      const SizedBox(width: 6),
                      if (!isMobile) ...[
                        const Text(
                          'Enrolled Exam:',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.textMuted),
                        ),
                        const SizedBox(width: 8),
                      ],
                      if (enrolledExams.isEmpty)
                        Expanded(
                          child: Text(
                            isMobile ? 'Select Exam Below' : 'Not Enrolled Yet (Select an exam below)',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: AppTheme.iconRed),
                          ),
                        )
                      else if (enrolledExams.length == 1)
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Text(
                                  isMobile
                                      ? activeEnrolledExam!.title
                                      : '${activeEnrolledExam!.title} (${activeEnrolledExam.category})',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: isMobile ? 12 : 12.5,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                              ),
                              if (!isTinyMobile) ...[
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                                  decoration: BoxDecoration(
                                    color: AppTheme.iconRedLight,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    'ACTIVE',
                                    style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w800, color: AppTheme.iconRedDark),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        )
                      else
                        Expanded(
                          child: DropdownButton<String>(
                            value: activeEnrolledExam?.id ?? enrolledExams.first.id,
                            underline: const SizedBox.shrink(),
                            isDense: true,
                            isExpanded: true,
                            dropdownColor: Colors.white,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: isMobile ? 12 : 13,
                              color: AppTheme.textPrimary,
                            ),
                            items: enrolledExams.map((e) {
                              return DropdownMenuItem<String>(
                                value: e.id,
                                child: Text(
                                  isMobile ? e.title : '${e.title} (${e.category})',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          OutlinedButton.icon(
            onPressed: () => GoRouter.of(context).go(AppConstants.routeSubscription),
            icon: const Icon(Icons.workspace_premium_outlined, size: 14, color: AppTheme.iconRed),
            label: Text(
              user.plan == SubscriptionPlan.free
                  ? (isTinyMobile ? 'PRO' : 'UPGRADE')
                  : 'PRO',
              style: TextStyle(fontSize: isMobile ? 11 : 12, fontWeight: FontWeight.w800),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.textPrimary,
              side: const BorderSide(color: AppTheme.divider),
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 14, vertical: isMobile ? 6 : 8),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          if (!showSidebarToggle) ...[
            const SizedBox(width: 4),
            IconButton(
              icon: const Icon(Icons.logout_rounded, color: AppTheme.iconRed, size: 18),
              tooltip: 'Logout',
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              padding: const EdgeInsets.all(6),
              visualDensity: VisualDensity.compact,
              onPressed: () async {
                await auth.logout();
                if (context.mounted) context.go(AppConstants.routeHome);
              },
            ),
          ],
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
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 650;

    Widget buildExamCard(ExamCourse exam, {required bool flexibleHeight}) {
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
              mainAxisSize: flexibleHeight ? MainAxisSize.min : MainAxisSize.max,
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
                if (flexibleHeight) const SizedBox(height: 12) else const Spacer(),
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
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                        await auth.enrollInExam(exam.id, action: 'set_single');
                        qp.selectExam(exam.id);
                        if (context.mounted) {
                          GoRouter.of(context).go(AppConstants.routeSubscription);
                        }
                      },
                      icon: const Icon(Icons.how_to_reg_rounded, size: 16, color: Colors.white),
                      label: const Text('Enroll in Exam', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 14 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (user.plan == SubscriptionPlan.free) _UpgradeBanner(),

          // ── Enrolled Exam Active Card OR Prompt to Enroll ──
          if (hasEnrollment && enrolledExam != null)
            Container(
              padding: EdgeInsets.all(isMobile ? 16 : 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.divider, width: 1.2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
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
                      Text(
                        enrolledExam.organization,
                        style: const TextStyle(color: AppTheme.textMuted, fontSize: 11.5, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    enrolledExam.title,
                    style: TextStyle(color: AppTheme.textPrimary, fontSize: isMobile ? 18 : 21, fontWeight: FontWeight.w800, letterSpacing: -0.4),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    enrolledExam.titleNepali,
                    style: const TextStyle(color: AppTheme.textBody, fontSize: 13.5, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    enrolledExam.description,
                    style: const TextStyle(color: AppTheme.textMuted, fontSize: 12.5, height: 1.5),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      FilledButton.icon(
                        onPressed: () => widget.onGoToTab(1),
                        icon: const Icon(Icons.menu_book_rounded, size: 16, color: Colors.white),
                        label: Text('Study Q&A Bank ($enrolledQuestionsCount)'),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppTheme.iconRed,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: () => widget.onGoToTab(2),
                        icon: const Icon(Icons.timer_outlined, size: 16, color: AppTheme.primaryColor),
                        label: const Text('Start Mock Test'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.primaryColor,
                          side: const BorderSide(color: AppTheme.divider, width: 1.2),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: () => widget.onGoToTab(3),
                        icon: const Icon(Icons.description_outlined, size: 16, color: AppTheme.primaryColor),
                        label: const Text('View Official Syllabus'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.primaryColor,
                          side: const BorderSide(color: AppTheme.divider, width: 1.2),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: () => widget.onGoToTab(4),
                        icon: const Icon(Icons.volunteer_activism_outlined, size: 16, color: AppTheme.iconRed),
                        label: const Text('Donate Questions & Earn रू'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.iconRedDark,
                          backgroundColor: AppTheme.iconRedLight,
                          side: BorderSide(color: AppTheme.iconRed.withOpacity(0.4), width: 1.2),
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
              padding: EdgeInsets.all(isMobile ? 16 : 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.iconRed.withOpacity(0.45), width: 1.4),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.iconRedLight,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.school_outlined, color: AppTheme.iconRed, size: 24),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select & Enroll in Your Target Exam Below',
                          style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Enroll in an exam course below to unlock its dedicated Question Bank, Mock Tests, and Official Syllabus. Other exam materials are hidden so your study stays 100% focused.',
                          style: TextStyle(fontSize: 12.5, color: AppTheme.textMuted, height: 1.45),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 18),
          _StatsGrid(user: user),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Text(
                'Enroll in a Lok Sewa Exam Course',
                style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
              ),
              if (user.isAdmin)
                TextButton.icon(
                  onPressed: () => GoRouter.of(context).go(AppConstants.routeAdmin),
                  icon: const Icon(Icons.add_circle_outline_rounded, size: 16, color: AppTheme.iconRed),
                  label: const Text('Add Exam in Admin CMS', style: TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.w600, fontSize: 12.5)),
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
          if (w <= 700)
            Column(
              children: filteredExams
                  .map((exam) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: buildExamCard(exam, flexibleHeight: true),
                      ))
                  .toList(),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: w > 1100 ? 3 : 2,
                childAspectRatio: 1.42,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: filteredExams.length,
              itemBuilder: (ctx, i) => buildExamCard(filteredExams[i], flexibleHeight: false),
            ),
        ],
      ),
    );
  }
}

class _UpgradeBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 560;
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: EdgeInsets.all(isMobile ? 14 : 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.iconRed.withOpacity(0.4), width: 1.2),
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.iconRedLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.lock_open_rounded, color: AppTheme.iconRed, size: 20),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Unlock All Lok Sewa Model Answers with Pro',
                            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13.5, color: AppTheme.textPrimary),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Full access to Paper I, Paper II & Paper III — रू 199',
                            style: TextStyle(color: AppTheme.textMuted, fontSize: 11.5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => GoRouter.of(context).go(AppConstants.routeSubscription),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppTheme.iconRed,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Upgrade Now (रू 199)', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                  ),
                ),
              ],
            )
          : Row(
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
                        'Get full access to Paper I, Paper II & Paper III model answers — रू 199',
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
    final w = MediaQuery.of(context).size.width;
    final isSmallMobile = w < 480;
    return GridView.count(
      crossAxisCount: w > 700 ? 4 : 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: isSmallMobile ? 10 : 16,
      mainAxisSpacing: isSmallMobile ? 10 : 16,
      childAspectRatio: isSmallMobile ? 1.45 : 1.75,
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
    final isSmallMobile = MediaQuery.of(context).size.width < 480;
    return Container(
      padding: EdgeInsets.all(isSmallMobile ? 12 : 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isRed ? AppTheme.iconRed : AppTheme.primaryColor, size: isSmallMobile ? 19 : 22),
          SizedBox(height: isSmallMobile ? 6 : 8),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: isSmallMobile ? 17 : 20, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
          ),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: AppTheme.textMuted, fontSize: isSmallMobile ? 11 : 11.5),
          ),
        ],
      ),
    );
  }
}

// ─── Clean Focused Question Bank ─────────────────────────────
class QuestionsTab extends StatefulWidget {
  final VoidCallback? onGoToExams;
  final bool isFullFocusMode;
  final ValueChanged<bool>? onToggleFullFocusMode;
  const QuestionsTab({
    super.key,
    this.onGoToExams,
    this.isFullFocusMode = false,
    this.onToggleFullFocusMode,
  });
  @override
  State<QuestionsTab> createState() => _QuestionsTabState();
}

class _QuestionsTabState extends State<QuestionsTab> {
  Question? _selected;
  String _lang = 'english';
  double _fontSize = 15.0;
  final Set<String> _studiedIds = {};
  final TextEditingController _searchCtrl = TextEditingController();
  bool _listCollapsed = false;
  PaperType _selectedPaper = PaperType.paper1;
  String _subCategory = 'it_mcq'; // 'it_mcq' | 'banking_subjective' | 'it_subjective'
  int _page = 1;
  bool _initialLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialLoaded) {
      _initialLoaded = true;
      _fetchCurrentPage(page: 1);
    }
  }

  void _fetchCurrentPage({int? page}) {
    final qp = context.read<QuestionProvider>();
    final targetPage = page ?? _page;
    _page = targetPage;

    QuestionType? type;
    SectionType? section;

    if (_selectedPaper == PaperType.paper1) {
      if (_subCategory == 'it_mcq') {
        type = QuestionType.mcq;
        section = SectionType.sectionB;
      } else {
        type = QuestionType.subjective;
        section = SectionType.sectionA;
      }
    } else {
      type = QuestionType.subjective;
    }

    qp.fetchPagedQuestions(
      examId: qp.selectedExamId,
      paper: _selectedPaper,
      type: type,
      section: section,
      query: _searchCtrl.text,
      page: targetPage,
      limit: 10,
    );
  }

  void _onPaperChanged(PaperType paper) {
    if (_selectedPaper == paper) return;
    setState(() {
      _selectedPaper = paper;
      _subCategory = paper == PaperType.paper1 ? 'it_mcq' : 'it_subjective';
      _page = 1;
      _selected = null;
    });
    _fetchCurrentPage(page: 1);
  }

  void _onSubCategoryChanged(String sub) {
    if (_subCategory == sub) return;
    setState(() {
      _subCategory = sub;
      _page = 1;
      _selected = null;
    });
    _fetchCurrentPage(page: 1);
  }

  void _onPageChanged(int targetPage) {
    setState(() {
      _page = targetPage;
      _selected = null;
    });
    _fetchCurrentPage(page: targetPage);
  }

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

  void _exitMobileReader() {
    setState(() => _selected = null);
    if (widget.isFullFocusMode) {
      widget.onToggleFullFocusMode?.call(false);
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

    final accessible = qp.pagedQuestions;
    final totalCount = qp.pagedTotal;
    final totalPages = qp.pagedTotalPages;
    final currentPage = qp.pagedPage;
    final isPageLoading = qp.pagedLoading;

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
    final isMobileReading = !isWide && _selected != null;

    final overallIdx = (currentPage - 1) * 10 + (currentIdx >= 0 ? currentIdx + 1 : 1);

    return Column(
      children: [
        // ── Adaptive Toolbar: Mobile Study Focus Bar vs Browse Toolbar ──
        if (isMobileReading)
          _MobileFocusReaderBar(
            lang: _lang,
            fontSize: _fontSize,
            currentIdx: overallIdx,
            total: totalCount,
            isFullFocusMode: widget.isFullFocusMode,
            onBackToList: _exitMobileReader,
            onLangChanged: (l) => setState(() => _lang = l),
            onFontDec: () => setState(() => _fontSize = (_fontSize - 1).clamp(13, 22)),
            onFontInc: () => setState(() => _fontSize = (_fontSize + 1).clamp(13, 22)),
            onToggleFullFocus: () => widget.onToggleFullFocusMode?.call(!widget.isFullFocusMode),
            onPrev: currentIdx > 0
                ? () => _go(accessible, -1)
                : (currentPage > 1 ? () => _onPageChanged(currentPage - 1) : null),
            onNext: currentIdx >= 0 && currentIdx < accessible.length - 1
                ? () => _go(accessible, 1)
                : (currentPage < totalPages ? () => _onPageChanged(currentPage + 1) : null),
          )
        else
          _QBankToolbar(
            searchCtrl: _searchCtrl,
            lang: _lang,
            fontSize: _fontSize,
            studiedCount: _studiedIds.length,
            total: totalCount,
            currentIdx: currentIdx,
            isWide: isWide,
            isListCollapsed: _listCollapsed,
            isFullFocusMode: widget.isFullFocusMode,
            selectedPaper: _selectedPaper,
            subCategory: _subCategory,
            onPaperChanged: _onPaperChanged,
            onSubCategoryChanged: _onSubCategoryChanged,
            onToggleFullFocus: () {
              final nextFocus = !widget.isFullFocusMode;
              widget.onToggleFullFocusMode?.call(nextFocus);
              if (isWide) {
                setState(() => _listCollapsed = nextFocus);
              }
            },
            onLangChanged: (l) => setState(() => _lang = l),
            onFontDec: () => setState(() => _fontSize = (_fontSize - 1).clamp(13, 22)),
            onFontInc: () => setState(() => _fontSize = (_fontSize + 1).clamp(13, 22)),
            onSearch: (v) { _fetchCurrentPage(page: 1); },
            onClearSearch: () { _searchCtrl.clear(); _fetchCurrentPage(page: 1); },
            onPrev: currentIdx > 0
                ? () => _go(accessible, -1)
                : (currentPage > 1 ? () => _onPageChanged(currentPage - 1) : null),
            onNext: currentIdx >= 0 && currentIdx < accessible.length - 1
                ? () => _go(accessible, 1)
                : (currentPage < totalPages ? () => _onPageChanged(currentPage + 1) : null),
            onToggleList: () => setState(() => _listCollapsed = !_listCollapsed),
          ),
        // ── Main Layout ─────────────────────────────────────────
        Expanded(
          child: isPageLoading && accessible.isEmpty
              ? const Center(child: CircularProgressIndicator(color: AppTheme.iconRed, strokeWidth: 2))
              : accessible.isEmpty
                  ? _EmptyState(onReset: () {
                      _searchCtrl.clear();
                      _onPaperChanged(PaperType.paper1);
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
                                  currentPage: currentPage,
                                  totalPages: totalPages,
                                  totalCount: totalCount,
                                  isLoading: isPageLoading,
                                  onSelect: (q) => setState(() => _selected = q),
                                  onToggleStudied: (id) => setState(() {
                                    _studiedIds.contains(id) ? _studiedIds.remove(id) : _studiedIds.add(id);
                                  }),
                                  onPageChanged: _onPageChanged,
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
                                      questionNumber: overallIdx,
                                      totalQuestions: totalCount,
                                      lang: _lang,
                                      fontSize: _fontSize,
                                      isStudied: _studiedIds.contains(_selected!.id),
                                      isFullFocusMode: widget.isFullFocusMode,
                                      onToggleStudied: () => setState(() {
                                        final id = _selected!.id;
                                        _studiedIds.contains(id) ? _studiedIds.remove(id) : _studiedIds.add(id);
                                      }),
                                      onPrev: currentIdx > 0
                                          ? () => _go(accessible, -1)
                                          : (currentPage > 1 ? () => _onPageChanged(currentPage - 1) : null),
                                      onNext: currentIdx >= 0 && currentIdx < accessible.length - 1
                                          ? () => _go(accessible, 1)
                                          : (currentPage < totalPages ? () => _onPageChanged(currentPage + 1) : null),
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
                              currentPage: currentPage,
                              totalPages: totalPages,
                              totalCount: totalCount,
                              isLoading: isPageLoading,
                              onSelect: (q) => setState(() => _selected = q),
                              onToggleStudied: (id) => setState(() {
                                _studiedIds.contains(id) ? _studiedIds.remove(id) : _studiedIds.add(id);
                              }),
                              onPageChanged: _onPageChanged,
                            )
                          : _StudyReader(
                              key: ValueKey(_selected!.id),
                              question: _selected!,
                              questionNumber: overallIdx,
                              totalQuestions: totalCount,
                              lang: _lang,
                              fontSize: _fontSize,
                              isStudied: _studiedIds.contains(_selected!.id),
                              isFullFocusMode: widget.isFullFocusMode,
                              onToggleStudied: () => setState(() {
                                final id = _selected!.id;
                                _studiedIds.contains(id) ? _studiedIds.remove(id) : _studiedIds.add(id);
                              }),
                              onBack: _exitMobileReader,
                              onPrev: currentIdx > 0
                                  ? () => _go(accessible, -1)
                                  : (currentPage > 1 ? () => _onPageChanged(currentPage - 1) : null),
                              onNext: currentIdx >= 0 && currentIdx < accessible.length - 1
                                  ? () => _go(accessible, 1)
                                  : (currentPage < totalPages ? () => _onPageChanged(currentPage + 1) : null),
                            ),
        ),
      ],
    );
  }
}

// ── Mobile Focus Study Reader Bar (Single-Row Compact Header on Mobile) ──
class _MobileFocusReaderBar extends StatelessWidget {
  final String lang;
  final double fontSize;
  final int currentIdx;
  final int total;
  final bool isFullFocusMode;
  final VoidCallback onBackToList;
  final ValueChanged<String> onLangChanged;
  final VoidCallback onFontDec;
  final VoidCallback onFontInc;
  final VoidCallback onToggleFullFocus;
  final VoidCallback? onPrev;
  final VoidCallback? onNext;

  const _MobileFocusReaderBar({
    required this.lang,
    required this.fontSize,
    required this.currentIdx,
    required this.total,
    required this.isFullFocusMode,
    required this.onBackToList,
    required this.onLangChanged,
    required this.onFontDec,
    required this.onFontInc,
    required this.onToggleFullFocus,
    this.onPrev,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final isTiny = MediaQuery.of(context).size.width < 370;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppTheme.divider, width: 1)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width - 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back to list button
              InkWell(
                onTap: onBackToList,
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F4F5),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppTheme.divider),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.arrow_back_rounded, size: 15, color: AppTheme.textPrimary),
                      const SizedBox(width: 4),
                      Text(
                        isTiny ? 'List' : 'All Qs',
                        style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 6),

              // Compact Controls Row: Lang + Font + Full Focus + Prev/Next
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Language toggle (ने / EN)
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F4F5),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppTheme.divider),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () => onLangChanged('nepali'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3.5),
                            decoration: BoxDecoration(
                              color: lang == 'nepali' ? Colors.white : Colors.transparent,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'ने',
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: lang == 'nepali' ? FontWeight.w800 : FontWeight.w600,
                                color: lang == 'nepali' ? AppTheme.iconRed : AppTheme.textMuted,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => onLangChanged('english'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3.5),
                            decoration: BoxDecoration(
                              color: lang == 'english' ? Colors.white : Colors.transparent,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'EN',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: lang == 'english' ? FontWeight.w800 : FontWeight.w600,
                                color: lang == 'english' ? AppTheme.iconRed : AppTheme.textMuted,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),

                  // Compact Font Size (A- / A+)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppTheme.divider),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: onFontDec,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7, vertical: 4.5),
                            child: Text('A−', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppTheme.textPrimary)),
                          ),
                        ),
                        Container(width: 1, height: 14, color: AppTheme.divider),
                        InkWell(
                          onTap: onFontInc,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7, vertical: 4.5),
                            child: Text('A+', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800, color: AppTheme.textPrimary)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),

                  // Full Screen Focus Mode Toggle Button
                  InkWell(
                    onTap: onToggleFullFocus,
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      decoration: BoxDecoration(
                        color: isFullFocusMode ? AppTheme.iconRed : AppTheme.iconRedLight,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: isFullFocusMode ? AppTheme.iconRed : AppTheme.iconRed.withOpacity(0.4),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isFullFocusMode ? Icons.fullscreen_exit_rounded : Icons.fullscreen_rounded,
                            size: 15,
                            color: isFullFocusMode ? Colors.white : AppTheme.iconRed,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            isFullFocusMode ? 'Exit Focus' : 'Focus',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: isFullFocusMode ? Colors.white : AppTheme.iconRedDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),

                  // Compact Page Turner (< 1/N >)
                  if (currentIdx >= 0)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: onPrev,
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4.5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: AppTheme.divider),
                            ),
                            child: Icon(
                              Icons.chevron_left_rounded,
                              size: 16,
                              color: onPrev != null ? AppTheme.textPrimary : AppTheme.divider,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            '${currentIdx + 1}/$total',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: onNext,
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4.5),
                            decoration: BoxDecoration(
                              color: onNext != null ? AppTheme.iconRed : Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: onNext != null ? AppTheme.iconRed : AppTheme.divider),
                            ),
                            child: Icon(
                              Icons.chevron_right_rounded,
                              size: 16,
                              color: onNext != null ? Colors.white : AppTheme.divider,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
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
  final bool isFullFocusMode;
  final PaperType selectedPaper;
  final String subCategory;
  final ValueChanged<PaperType> onPaperChanged;
  final ValueChanged<String> onSubCategoryChanged;
  final VoidCallback onToggleFullFocus;
  final ValueChanged<String> onLangChanged;
  final VoidCallback onFontDec;
  final VoidCallback onFontInc;
  final ValueChanged<String> onSearch;
  final VoidCallback onClearSearch;
  final VoidCallback? onPrev;
  final VoidCallback? onNext;
  final VoidCallback onToggleList;

  const _QBankToolbar({
    required this.searchCtrl,
    required this.lang,
    required this.fontSize,
    required this.studiedCount,
    required this.total,
    required this.currentIdx,
    required this.isWide,
    required this.isListCollapsed,
    required this.isFullFocusMode,
    required this.selectedPaper,
    required this.subCategory,
    required this.onPaperChanged,
    required this.onSubCategoryChanged,
    required this.onToggleFullFocus,
    required this.onLangChanged,
    required this.onFontDec,
    required this.onFontInc,
    required this.onSearch,
    required this.onClearSearch,
    required this.onPrev,
    required this.onNext,
    required this.onToggleList,
  });

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final isMobile = screenW < 600;
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
            padding: EdgeInsets.fromLTRB(isMobile ? 10 : 14, isMobile ? 8 : 10, isMobile ? 10 : 14, 0),
            child: isMobile
                ? Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 34,
                              child: TextField(
                                controller: searchCtrl,
                                style: const TextStyle(fontSize: 13),
                                decoration: InputDecoration(
                                  hintText: 'Search questions...',
                                  hintStyle: const TextStyle(fontSize: 12, color: AppTheme.textMuted),
                                  prefixIcon: const Icon(Icons.search_rounded, size: 16, color: AppTheme.primaryColor),
                                  suffixIcon: searchCtrl.text.isNotEmpty
                                      ? InkWell(
                                          onTap: onClearSearch,
                                          child: const Icon(Icons.close_rounded, size: 15, color: AppTheme.textMuted),
                                        )
                                      : null,
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
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
                          ),
                          const SizedBox(width: 8),
                          _SegToggle(
                            options: const ['EN', 'ने'],
                            values: const ['english', 'nepali'],
                            selected: lang,
                            onChanged: onLangChanged,
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF4F4F5),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: AppTheme.divider),
                            ),
                            child: Text(
                              '✓ $studiedCount/$total',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          if (isWide)
                            _ToolBtn(
                              tooltip: isListCollapsed ? 'Show Question List' : 'Hide Question List',
                              icon: isListCollapsed ? Icons.view_list_rounded : Icons.view_sidebar_outlined,
                              active: isListCollapsed,
                              onTap: onToggleList,
                            ),
                          // Search field
                          SizedBox(
                            width: 210,
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
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          // Lang toggle
                          _SegToggle(
                            options: const ['English', 'नेपाली'],
                            values: const ['english', 'nepali'],
                            selected: lang,
                            onChanged: onLangChanged,
                          ),
                          // Font size
                          _FontControl(
                            size: fontSize,
                            onDec: onFontDec,
                            onInc: onFontInc,
                          ),
                          // Full Focus Mode toggle button
                          InkWell(
                            onTap: onToggleFullFocus,
                            borderRadius: BorderRadius.circular(6),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: isFullFocusMode ? AppTheme.iconRed : AppTheme.iconRedLight,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: isFullFocusMode ? AppTheme.iconRed : AppTheme.iconRed.withOpacity(0.35),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    isFullFocusMode ? Icons.fullscreen_exit_rounded : Icons.fullscreen_rounded,
                                    size: 15,
                                    color: isFullFocusMode ? Colors.white : AppTheme.iconRed,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    isFullFocusMode ? 'Exit Focus' : 'Full Focus',
                                    style: TextStyle(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w800,
                                      color: isFullFocusMode ? Colors.white : AppTheme.iconRedDark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                          if (currentIdx >= 0)
                            // Prev / Next
                            _NavControl(
                              currentIdx: currentIdx,
                              total: total,
                              onPrev: onPrev,
                              onNext: onNext,
                            ),
                        ],
                      ),
                    ],
                  ),
          ),
          // Row 2: Filter chips - Paper I & Paper II with contextual sub-options
          Padding(
            padding: EdgeInsets.fromLTRB(isMobile ? 10 : 14, 7, isMobile ? 10 : 14, isMobile ? 8 : 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _Chip(
                    label: 'Paper I',
                    icon: Icons.menu_book_rounded,
                    active: selectedPaper == PaperType.paper1,
                    onTap: () => onPaperChanged(PaperType.paper1),
                  ),
                  const SizedBox(width: 8),
                  _Chip(
                    label: 'Paper II',
                    icon: Icons.terminal_rounded,
                    active: selectedPaper == PaperType.paper2,
                    onTap: () => onPaperChanged(PaperType.paper2),
                  ),
                  const SizedBox(width: 12),
                  Container(height: 18, width: 1, color: AppTheme.divider),
                  const SizedBox(width: 12),

                  if (selectedPaper == PaperType.paper1) ...[
                    _Chip(
                      label: 'IT MCQs',
                      icon: Icons.check_circle_outline_rounded,
                      active: subCategory == 'it_mcq',
                      badge: '567',
                      onTap: () => onSubCategoryChanged('it_mcq'),
                    ),
                    const SizedBox(width: 8),
                    _Chip(
                      label: 'Banking Subjective',
                      icon: Icons.account_balance_rounded,
                      active: subCategory == 'banking_subjective',
                      badge: '306',
                      onTap: () => onSubCategoryChanged('banking_subjective'),
                    ),
                  ] else ...[
                    _Chip(
                      label: 'IT Subjective Questions',
                      icon: Icons.code_rounded,
                      active: true,
                      badge: '868',
                      onTap: () => onSubCategoryChanged('it_subjective'),
                    ),
                  ],
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
  final IconData? icon;
  final String? badge;

  const _Chip({
    required this.label,
    required this.active,
    required this.onTap,
    this.icon,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 140),
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
        decoration: BoxDecoration(
          color: active ? AppTheme.iconRedLight : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: active ? AppTheme.iconRed.withOpacity(0.5) : AppTheme.divider,
            width: active ? 1.2 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 14,
                color: active ? AppTheme.iconRedDark : AppTheme.textMuted,
              ),
              const SizedBox(width: 5),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: active ? FontWeight.w800 : FontWeight.w500,
                color: active ? AppTheme.iconRedDark : AppTheme.textPrimary,
              ),
            ),
            if (badge != null) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                decoration: BoxDecoration(
                  color: active ? AppTheme.iconRed : const Color(0xFFE4E4E7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  badge!,
                  style: TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w800,
                    color: active ? Colors.white : AppTheme.textMuted,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Question Index (Left Panel with Pagination) ─────────────────
class _QuestionIndex extends StatelessWidget {
  final List<Question> questions;
  final String? selectedId;
  final String lang;
  final AppUser user;
  final Set<String> studiedIds;
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final bool isLoading;
  final ValueChanged<Question> onSelect;
  final ValueChanged<String> onToggleStudied;
  final ValueChanged<int> onPageChanged;

  const _QuestionIndex({
    required this.questions,
    required this.selectedId,
    required this.lang,
    required this.user,
    required this.studiedIds,
    required this.currentPage,
    required this.totalPages,
    required this.totalCount,
    required this.isLoading,
    required this.onSelect,
    required this.onToggleStudied,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFAFAFA),
      child: Column(
        children: [
          // Top Summary Pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: const BoxDecoration(
              color: Color(0xFFF4F4F5),
              border: Border(bottom: BorderSide(color: AppTheme.divider, width: 0.5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  totalCount == 0
                      ? '0 Questions'
                      : 'Showing ${(currentPage - 1) * 10 + 1}-${((currentPage - 1) * 10 + questions.length)} of $totalCount',
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppTheme.textMuted),
                ),
                if (isLoading)
                  const SizedBox(
                    width: 12,
                    height: 12,
                    child: CircularProgressIndicator(strokeWidth: 1.5, color: AppTheme.iconRed),
                  ),
              ],
            ),
          ),
          // Questions List (10 questions on this page)
          Expanded(
            child: ListView.builder(
              itemCount: questions.length,
              itemBuilder: (ctx, i) {
                final q = questions[i];
                final active = q.id == selectedId;
                final studied = studiedIds.contains(q.id);
                final isMcq = q.type == QuestionType.mcq;
                final locked = q.isPremium && !user.isPremium;
                final qNum = (currentPage - 1) * 10 + i + 1;

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
                                      '$qNum',
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
                                lang == 'english'
                                    ? (q.questionEnglish.isNotEmpty ? q.questionEnglish : q.questionNepali)
                                    : (q.questionNepali.isNotEmpty ? q.questionNepali : q.questionEnglish),
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
          ),
          // Bottom Pagination Bar (10 Questions at a time)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: AppTheme.divider, width: 0.8)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_rounded, size: 13),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                  tooltip: 'Previous 10 Questions',
                  onPressed: currentPage > 1 && !isLoading ? () => onPageChanged(currentPage - 1) : null,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F4F5),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppTheme.divider),
                  ),
                  child: Text(
                    'Page $currentPage of ${totalPages < 1 ? 1 : totalPages}',
                    style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_rounded, size: 13),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                  tooltip: 'Next 10 Questions',
                  onPressed: currentPage < totalPages && !isLoading ? () => onPageChanged(currentPage + 1) : null,
                ),
              ],
            ),
          ),
        ],
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
  final int questionNumber;
  final int totalQuestions;
  final String lang;
  final double fontSize;
  final bool isStudied;
  final bool isFullFocusMode;
  final VoidCallback onToggleStudied;
  final VoidCallback? onBack;
  final VoidCallback? onPrev;
  final VoidCallback? onNext;

  const _StudyReader({
    super.key,
    required this.question,
    required this.questionNumber,
    required this.totalQuestions,
    required this.lang,
    required this.fontSize,
    required this.isStudied,
    this.isFullFocusMode = false,
    required this.onToggleStudied,
    this.onBack,
    this.onPrev,
    this.onNext,
  });

  @override
  State<_StudyReader> createState() => _StudyReaderState();
}

class _StudyReaderState extends State<_StudyReader> {
  final _scroll = ScrollController();

  @override
  void didUpdateWidget(covariant _StudyReader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question.id != widget.question.id && _scroll.hasClients) {
      _scroll.jumpTo(0);
    }
  }

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
    final isMobile = MediaQuery.of(context).size.width < 600;

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        final v = details.primaryVelocity ?? 0;
        if (v < -320 && widget.onNext != null) {
          widget.onNext!();
        } else if (v > 320 && widget.onPrev != null) {
          widget.onPrev!();
        }
      },
      child: _LinedCopySheet(
        scrollController: _scroll,
        question: widget.question,
        questionNumber: widget.questionNumber,
        totalQuestions: widget.totalQuestions,
        lang: widget.lang,
        fontSize: widget.fontSize,
        isStudied: widget.isStudied,
        locked: locked,
        isMobile: isMobile,
        isFullFocusMode: widget.isFullFocusMode,
        onToggleStudied: widget.onToggleStudied,
        onBack: widget.onBack,
        onPrev: widget.onPrev,
        onNext: widget.onNext,
      ),
    );
  }
}

// ── Physical Lining Copy ("लाइनिङ कपी") Focus View ────────────────
class _LinedCopySheet extends StatelessWidget {
  final ScrollController scrollController;
  final Question question;
  final int questionNumber;
  final int totalQuestions;
  final String lang;
  final double fontSize;
  final bool isStudied;
  final bool locked;
  final bool isMobile;
  final bool isFullFocusMode;
  final VoidCallback onToggleStudied;
  final VoidCallback? onBack;
  final VoidCallback? onPrev;
  final VoidCallback? onNext;

  const _LinedCopySheet({
    required this.scrollController,
    required this.question,
    required this.questionNumber,
    required this.totalQuestions,
    required this.lang,
    required this.fontSize,
    required this.isStudied,
    required this.locked,
    required this.isMobile,
    this.isFullFocusMode = false,
    required this.onToggleStudied,
    this.onBack,
    this.onPrev,
    this.onNext,
  });

  String _toNepaliDigits(int number) {
    const map = ['०', '१', '२', '३', '४', '५', '६', '७', '८', '९'];
    return number
        .toString()
        .split('')
        .map((c) => int.tryParse(c) != null ? map[int.parse(c)] : c)
        .join();
  }

  @override
  Widget build(BuildContext context) {
    final questionText = lang == 'english'
        ? (question.questionEnglish.isNotEmpty ? question.questionEnglish : question.questionNepali)
        : (question.questionNepali.isNotEmpty ? question.questionNepali : question.questionEnglish);
    final nepaliAnswer = question.answerNepali ?? 'उत्तर उपलब्ध छैन।';
    final rawEnglish = question.answerEnglish?.trim() ?? '';
    final activeAnswer = lang == 'english' ? (rawEnglish.isNotEmpty && rawEnglish != 'Answer not available.' ? rawEnglish : nepaliAnswer) : nepaliAnswer;

    // Exact line-height locking so every text baseline rests on a physical ruled line
    final double lineHeight = (fontSize * (isMobile ? 2.08 : 2.15)).roundToDouble();
    final double textHeightRatio = lineHeight / fontSize;
    final double leftMarginWidth = isMobile ? 42.0 : 80.0;
    final double rightPad = isMobile ? 10.0 : 28.0;

    final baseQuestionStyle = TextStyle(
      fontSize: fontSize + 0.5,
      fontWeight: FontWeight.w800,
      height: lineHeight / (fontSize + 0.5),
      color: AppTheme.textPrimary,
      letterSpacing: -0.1,
    );
    final questionStrut = StrutStyle(
      fontSize: fontSize + 0.5,
      height: lineHeight / (fontSize + 0.5),
      forceStrutHeight: true,
      leading: 0,
    );

    final marginLabelFontSize = isMobile ? 10.5 : 13.0;
    final marginLabelStyle = TextStyle(
      fontSize: marginLabelFontSize,
      fontWeight: FontWeight.w800,
      height: lineHeight / marginLabelFontSize,
      color: AppTheme.iconRed,
    );
    final marginLabelStrut = StrutStyle(
      fontSize: marginLabelFontSize,
      height: lineHeight / marginLabelFontSize,
      forceStrutHeight: true,
      leading: 0,
    );

    final qLabel = lang == 'nepali'
        ? (isMobile ? 'प्र.${_toNepaliDigits(questionNumber)}' : 'प्र. ${_toNepaliDigits(questionNumber)}.')
        : 'Q.$questionNumber';
    final ansLabel = lang == 'nepali' ? 'उत्तर:' : 'Ans:';

    return Container(
      color: isMobile && isFullFocusMode ? Colors.white : const Color(0xFFEDEDED),
      child: SingleChildScrollView(
        controller: scrollController,
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? (isFullFocusMode ? 0 : 3) : 24,
          vertical: isMobile ? (isFullFocusMode ? 0 : 6) : 22,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 850),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── THE PHYSICAL LINING COPY PAGE ──
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(isMobile && isFullFocusMode ? 0 : 3),
                    border: Border.all(
                      color: const Color(0xFFD4D4D8),
                      width: isMobile && isFullFocusMode ? 0.5 : 1,
                    ),
                    boxShadow: isMobile && isFullFocusMode
                        ? null
                        : const [
                            BoxShadow(
                              color: Color(0x18000000),
                              blurRadius: 16,
                              offset: Offset(0, 6),
                            ),
                            BoxShadow(
                              color: Color(0x0A000000),
                              blurRadius: 3,
                              offset: Offset(2, 2),
                            ),
                          ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // ── 1. TOP UNRULED NOTEBOOK HEADER AREA ──
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Left margin column in header
                            Container(
                              width: leftMarginWidth,
                              decoration: const BoxDecoration(
                                border: Border(
                                  right: BorderSide(color: AppTheme.iconRed, width: 1.2),
                                ),
                              ),
                              child: Container(
                                margin: const EdgeInsets.only(right: 3.0),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    right: BorderSide(color: AppTheme.iconRed, width: 1.0),
                                  ),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.menu_book_rounded,
                                        size: isMobile ? 13 : 16,
                                        color: AppTheme.iconRed,
                                      ),
                                      const SizedBox(height: 1),
                                      Text(
                                        lang == 'nepali' ? 'लोकसेवा' : 'PSC',
                                        style: TextStyle(
                                          fontSize: isMobile ? 8.0 : 9.5,
                                          fontWeight: FontWeight.w800,
                                          color: AppTheme.iconRed,
                                          letterSpacing: 0.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            // Main header content + Right Date/Page stamp box
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                  isMobile ? 8 : 18,
                                  isMobile ? 7 : 14,
                                  rightPad,
                                  isMobile ? 7 : 12,
                                ),
                                child: Wrap(
                                  alignment: WrapAlignment.spaceBetween,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  runSpacing: 6,
                                  spacing: 8,
                                  children: [
                                    // Paper & Unit title + Action pills
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Wrap(
                                          spacing: 6,
                                          runSpacing: 4,
                                          crossAxisAlignment: WrapCrossAlignment.center,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                                              decoration: BoxDecoration(
                                                color: AppTheme.iconRedLight,
                                                borderRadius: BorderRadius.circular(3),
                                                border: Border.all(color: AppTheme.iconRed.withOpacity(0.35)),
                                              ),
                                              child: Text(
                                                question.paper == PaperType.paper1 ? 'PAPER I' : 'PAPER II',
                                                style: TextStyle(
                                                  fontSize: isMobile ? 9 : 10,
                                                  fontWeight: FontWeight.w800,
                                                  color: AppTheme.iconRedDark,
                                                  letterSpacing: 0.4,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'Unit ${question.unitNumber} · ${question.type == QuestionType.mcq ? "MCQ" : "${question.marks} Marks"}',
                                              style: TextStyle(
                                                fontSize: isMobile ? 10.5 : 11.5,
                                                fontWeight: FontWeight.w700,
                                                color: AppTheme.textPrimary,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Wrap(
                                          spacing: 6,
                                          runSpacing: 5,
                                          crossAxisAlignment: WrapCrossAlignment.center,
                                          children: [
                                            // Mark Revised button
                                            InkWell(
                                              onTap: onToggleStudied,
                                              borderRadius: BorderRadius.circular(4),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: isMobile ? 7 : 8,
                                                  vertical: isMobile ? 2.5 : 3.5,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: isStudied ? AppTheme.iconRedLight : Colors.white,
                                                  borderRadius: BorderRadius.circular(4),
                                                  border: Border.all(
                                                    color: isStudied ? AppTheme.iconRed : AppTheme.divider,
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      isStudied
                                                          ? Icons.check_circle_rounded
                                                          : Icons.check_circle_outline_rounded,
                                                      size: isMobile ? 12 : 13,
                                                      color: isStudied ? AppTheme.iconRed : AppTheme.textMuted,
                                                    ),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      isStudied ? 'Revised ✓' : 'Mark Revised',
                                                      style: TextStyle(
                                                        fontSize: isMobile ? 10 : 11,
                                                        fontWeight: FontWeight.w700,
                                                        color: isStudied ? AppTheme.iconRedDark : AppTheme.textPrimary,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            // Copy Answer button
                                            if (!locked && question.type != QuestionType.mcq)
                                              InkWell(
                                                onTap: () {
                                                  final cleanCopy = activeAnswer
                                                      .replaceAll('*', '')
                                                      .replaceAll(RegExp(r'^#+\s*', multiLine: true), '');
                                                  Clipboard.setData(
                                                    ClipboardData(text: '$questionText\n\n$cleanCopy'),
                                                  );
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(
                                                      content: Text('Copied Q&A from copy page'),
                                                      duration: Duration(seconds: 2),
                                                    ),
                                                  );
                                                },
                                                borderRadius: BorderRadius.circular(4),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: isMobile ? 7 : 8,
                                                    vertical: isMobile ? 2.5 : 3.5,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(4),
                                                    border: Border.all(color: AppTheme.divider),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Icon(Icons.copy_outlined, size: isMobile ? 11 : 12, color: AppTheme.textMuted),
                                                      const SizedBox(width: 3),
                                                      Text(
                                                        'Copy',
                                                        style: TextStyle(
                                                          fontSize: isMobile ? 10 : 11,
                                                          fontWeight: FontWeight.w600,
                                                          color: AppTheme.textMuted,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    // Physical Copy Top-Right Corner Box (Page No. / Marks / Year)
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: isMobile ? 7 : 10,
                                        vertical: isMobile ? 4 : 6,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: AppTheme.iconRed, width: 1.0),
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Page No.: ${questionNumber.toString().padLeft(2, '0')} / $totalQuestions',
                                            style: TextStyle(
                                              fontSize: isMobile ? 9.5 : 10.5,
                                              fontWeight: FontWeight.w800,
                                              color: AppTheme.iconRedDark,
                                              height: 1.25,
                                            ),
                                          ),
                                          const SizedBox(height: 1.5),
                                          Text(
                                            question.yearsAsked.isNotEmpty
                                                ? 'Asked: ${question.yearsAsked.join(", ")}'
                                                : 'Marks: ${question.marks} Full Marks',
                                            style: TextStyle(
                                              fontSize: isMobile ? 9 : 10,
                                              fontWeight: FontWeight.w600,
                                              color: AppTheme.textMuted,
                                              height: 1.25,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ── 2. DOUBLE HORIZONTAL RED TOP MARGIN LINE ──
                      Container(height: 1.5, color: AppTheme.iconRed),
                      const SizedBox(height: 2.5),
                      Container(height: 1.0, color: AppTheme.iconRed),

                      // ── 3. RULED NOTEBOOK BODY (Every line sits on a horizontal line) ──
                      CustomPaint(
                        painter: _LinedNotebookPainter(
                          lineHeight: lineHeight,
                          leftMargin: leftMarginWidth,
                          showBinderHoles: !isMobile,
                        ),
                        child: Padding(
                          // Leave 1 empty ruled line at top and 2 empty ruled lines at bottom
                          padding: EdgeInsets.only(
                            top: lineHeight,
                            bottom: lineHeight * (isMobile ? 1.5 : 2.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // ── QUESTION ROW ON RULED LINES ──
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: leftMarginWidth,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: isMobile ? 3 : 24,
                                        right: isMobile ? 5 : 6,
                                      ),
                                      child: Text(
                                        qLabel,
                                        textAlign: TextAlign.right,
                                        style: marginLabelStyle,
                                        strutStyle: marginLabelStrut,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: isMobile ? 8 : 16,
                                        right: rightPad,
                                      ),
                                      child: SelectableText(
                                        '$questionText [${question.marks}]',
                                        style: baseQuestionStyle,
                                        strutStyle: questionStrut,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // 1 empty ruled line between Question and Answer
                              SizedBox(height: lineHeight),

                              // ── ANSWER ROW ON RULED LINES ──
                              if (question.type == QuestionType.mcq)
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: isMobile ? leftMarginWidth + 8 : leftMarginWidth + 16,
                                    right: rightPad,
                                  ),
                                  child: _MCQView(question: question, fontSize: fontSize),
                                )
                              else if (locked)
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: isMobile ? leftMarginWidth + 8 : leftMarginWidth + 16,
                                    right: rightPad,
                                  ),
                                  child: _PaywallCard(),
                                )
                              else
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: leftMarginWidth,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: isMobile ? 3 : 24,
                                          right: isMobile ? 5 : 6,
                                        ),
                                        child: Text(
                                          ansLabel,
                                          textAlign: TextAlign.right,
                                          style: marginLabelStyle,
                                          strutStyle: marginLabelStrut,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: isMobile ? 8 : 16,
                                          right: rightPad,
                                        ),
                                        child: _LinedAnswerBody(
                                          content: activeAnswer,
                                          fontSize: fontSize,
                                          lineHeight: lineHeight,
                                          textHeightRatio: textHeightRatio,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),

                      // ── 4. BOTTOM NOTEBOOK PAGE TURN FOOTER ──
                      Container(height: 1.0, color: AppTheme.iconRed.withOpacity(0.5)),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 10 : 24,
                          vertical: isMobile ? 9 : 10,
                        ),
                        color: const Color(0xFFFAFAFA),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: onPrev,
                              borderRadius: BorderRadius.circular(5),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      size: 12,
                                      color: onPrev != null ? AppTheme.textPrimary : AppTheme.divider,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      isMobile ? 'Prev' : 'Prev Page',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: onPrev != null ? AppTheme.textPrimary : AppTheme.divider,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Text(
                              isMobile
                                  ? 'Page $questionNumber / $totalQuestions (Swipe ⇄)'
                                  : 'Copy Page $questionNumber of $totalQuestions',
                              style: TextStyle(
                                fontSize: isMobile ? 11 : 11.5,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.textMuted,
                              ),
                            ),
                            InkWell(
                              onTap: onNext,
                              borderRadius: BorderRadius.circular(5),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      isMobile ? 'Next' : 'Next Page',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: onNext != null ? AppTheme.iconRed : AppTheme.divider,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 12,
                                      color: onNext != null ? AppTheme.iconRed : AppTheme.divider,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isMobile ? 16 : 28),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LinedNotebookPainter extends CustomPainter {
  final double lineHeight;
  final double leftMargin;
  final bool showBinderHoles;

  const _LinedNotebookPainter({
    required this.lineHeight,
    required this.leftMargin,
    required this.showBinderHoles,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Horizontal ruled lines across the entire page width
    final rulePaint = Paint()
      ..color = const Color(0xFFD4D4D8)
      ..strokeWidth = 1.0;

    // Draw horizontal lines at every lineHeight interval so text baselines rest right above the line
    for (double y = lineHeight - 5.0; y < size.height; y += lineHeight) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), rulePaint);
    }

    // 2. Vertical Double Red Margin Lines on the left
    final redMarginPaint1 = Paint()
      ..color = AppTheme.iconRed
      ..strokeWidth = 1.2;
    final redMarginPaint2 = Paint()
      ..color = AppTheme.iconRed
      ..strokeWidth = 1.0;

    canvas.drawLine(
      Offset(leftMargin, 0),
      Offset(leftMargin, size.height),
      redMarginPaint1,
    );
    canvas.drawLine(
      Offset(leftMargin - 3.5, 0),
      Offset(leftMargin - 3.5, size.height),
      redMarginPaint2,
    );

    // 3. Physical Notebook Binder Punch Holes in the left margin
    if (showBinderHoles) {
      final holeFill = Paint()
        ..color = const Color(0xFFEDEDED)
        ..style = PaintingStyle.fill;
      final holeBorder = Paint()
        ..color = const Color(0xFFD4D4D8)
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke;

      final holePositions = <double>[
        lineHeight * 3.5,
        size.height / 2,
        if (size.height > lineHeight * 10) size.height - lineHeight * 3.5,
      ];
      for (final hy in holePositions) {
        if (hy > 20 && hy < size.height - 20) {
          canvas.drawCircle(Offset(16, hy), 6.5, holeFill);
          canvas.drawCircle(Offset(16, hy), 6.5, holeBorder);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _LinedNotebookPainter oldDelegate) {
    return oldDelegate.lineHeight != lineHeight ||
        oldDelegate.leftMargin != leftMargin ||
        oldDelegate.showBinderHoles != showBinderHoles;
  }
}

// ── Line-Locked Answer Body for Physical Lining Copy ──────────────
// ── Line-Locked Answer Body for Physical Lining Copy ──────────────
class _DiagramCodeWidget extends StatelessWidget {
  final String code;
  final double fontSize;
  final double lineHeight;

  const _DiagramCodeWidget({
    required this.code,
    required this.fontSize,
    required this.lineHeight,
  });

  @override
  Widget build(BuildContext context) {
    final diagramFontSize = fontSize * 0.85;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        border: Border.all(color: const Color(0xFFCBD5E1), width: 1.0),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SelectableText(
            code.trim(),
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: diagramFontSize,
              height: lineHeight / diagramFontSize,
              color: const Color(0xFF0F172A),
              fontWeight: FontWeight.w600,
            ),
            strutStyle: StrutStyle(
              fontSize: diagramFontSize,
              height: lineHeight / diagramFontSize,
              forceStrutHeight: true,
              leading: 0,
            ),
          ),
        ),
      ),
    );
  }
}

class _MarkdownTableWidget extends StatelessWidget {
  final List<String> lines;
  final double fontSize;
  final double lineHeight;
  final double textHeightRatio;

  const _MarkdownTableWidget({
    required this.lines,
    required this.fontSize,
    required this.lineHeight,
    required this.textHeightRatio,
  });

  List<String> _parseRowCells(String row) {
    var trimmed = row.trim();
    if (trimmed.startsWith('|')) trimmed = trimmed.substring(1);
    if (trimmed.endsWith('|')) trimmed = trimmed.substring(0, trimmed.length - 1);
    return trimmed.split('|').map((c) => c.trim()).toList();
  }

  Widget _buildCellText(
    String text, {
    required bool isHeader,
    required TextStyle cellStyle,
    required StrutStyle cellStrut,
  }) {
    final spans = <TextSpan>[];
    final regex = RegExp(r'(\*\*\*([^*]+?)\*\*\*|\*\*([^*]+?)\*\*|\*([^*]+?)\*)');
    int lastEnd = 0;

    for (final match in regex.allMatches(text)) {
      if (match.start > lastEnd) {
        final plain = text.substring(lastEnd, match.start).replaceAll('*', '');
        if (plain.isNotEmpty) {
          spans.add(TextSpan(text: plain));
        }
      }
      final boldItalic = match.group(2);
      final boldText = match.group(3);
      final singleStar = match.group(4);

      if (boldItalic != null && boldItalic.isNotEmpty) {
        spans.add(TextSpan(
          text: boldItalic,
          style: cellStyle.copyWith(fontWeight: FontWeight.w800, fontStyle: FontStyle.italic),
        ));
      } else if (boldText != null && boldText.isNotEmpty) {
        spans.add(TextSpan(
          text: boldText,
          style: cellStyle.copyWith(
            fontWeight: FontWeight.w800,
            color: isHeader ? AppTheme.iconRedDark : AppTheme.iconRedDark,
          ),
        ));
      } else if (singleStar != null && singleStar.isNotEmpty) {
        spans.add(TextSpan(
          text: singleStar,
          style: cellStyle.copyWith(fontStyle: FontStyle.italic, fontWeight: FontWeight.w700),
        ));
      }
      lastEnd = match.end;
    }

    if (lastEnd < text.length) {
      final tail = text.substring(lastEnd).replaceAll('*', '');
      if (tail.isNotEmpty) {
        spans.add(TextSpan(text: tail));
      }
    }

    if (spans.isEmpty) {
      return SelectableText(
        text.replaceAll('*', ''),
        style: cellStyle,
        strutStyle: cellStrut,
      );
    }

    return SelectableText.rich(
      TextSpan(style: cellStyle, children: spans),
      strutStyle: cellStrut,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (lines.isEmpty) return const SizedBox.shrink();

    // Find separator line index (the one containing '---')
    int sepIdx = -1;
    for (int i = 0; i < lines.length; i++) {
      if (lines[i].contains('---')) {
        sepIdx = i;
        break;
      }
    }

    List<String> headerLines;
    List<String> bodyLines;

    if (sepIdx > 0) {
      headerLines = lines.sublist(0, sepIdx);
      bodyLines = lines.sublist(sepIdx + 1);
    } else if (lines.length > 1) {
      headerLines = [lines.first];
      bodyLines = lines.sublist(1);
    } else {
      headerLines = [lines.first];
      bodyLines = [];
    }

    final headerRows = headerLines.map(_parseRowCells).toList();
    final bodyRows = bodyLines
        .where((l) => !l.contains('---') && l.trim().isNotEmpty)
        .map(_parseRowCells)
        .toList();

    int maxCols = 0;
    for (final r in headerRows) {
      if (r.length > maxCols) maxCols = r.length;
    }
    for (final r in bodyRows) {
      if (r.length > maxCols) maxCols = r.length;
    }

    if (maxCols == 0) return const SizedBox.shrink();

    for (final r in headerRows) {
      while (r.length < maxCols) {
        r.add('');
      }
    }
    for (final r in bodyRows) {
      while (r.length < maxCols) {
        r.add('');
      }
    }

    // Exact line-height locked styles so text baselines sit directly on the physical ruled notebook lines
    final cellFontSize = fontSize * 0.94;
    final cellStyleHeader = TextStyle(
      fontSize: cellFontSize,
      height: lineHeight / cellFontSize,
      color: AppTheme.iconRedDark,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.1,
    );
    final cellStyleBody = TextStyle(
      fontSize: cellFontSize,
      height: lineHeight / cellFontSize,
      color: AppTheme.textPrimary,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.1,
    );
    final cellStrut = StrutStyle(
      fontSize: cellFontSize,
      height: lineHeight / cellFontSize,
      forceStrutHeight: true,
      leading: 0,
    );

    // Dynamic proportional column widths so columns fit 100% of the notebook page and never overflow offscreen
    final Map<int, TableColumnWidth> colWidths = {};
    if (maxCols == 2) {
      colWidths[0] = const FlexColumnWidth(1.0);
      colWidths[1] = const FlexColumnWidth(1.6);
    } else if (maxCols == 3) {
      colWidths[0] = const FlexColumnWidth(1.0);
      colWidths[1] = const FlexColumnWidth(1.45);
      colWidths[2] = const FlexColumnWidth(1.45);
    } else if (maxCols == 4) {
      colWidths[0] = const FlexColumnWidth(0.9);
      colWidths[1] = const FlexColumnWidth(1.05);
      colWidths[2] = const FlexColumnWidth(1.1);
      colWidths[3] = const FlexColumnWidth(1.5);
    } else {
      for (int c = 0; c < maxCols; c++) {
        colWidths[c] = const FlexColumnWidth(1.0);
      }
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        // On very small mobile screens (< 360px), allow horizontal scrolling with comfortable minimum column width
        final minTableWidth = maxCols * 115.0;
        final needsScroll = availableWidth < minTableWidth;
        final tableWidth = needsScroll ? minTableWidth : availableWidth;

        Widget tableWidget = Container(
          width: tableWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: const BorderSide(color: AppTheme.iconRed, width: 1.5),
              bottom: const BorderSide(color: AppTheme.iconRedDark, width: 1.8),
              left: BorderSide(color: AppTheme.iconRed.withOpacity(0.45), width: 1.2),
              right: BorderSide(color: AppTheme.iconRed.withOpacity(0.45), width: 1.2),
            ),
          ),
          child: Table(
            columnWidths: colWidths,
            defaultVerticalAlignment: TableCellVerticalAlignment.top,
            border: TableBorder(
              horizontalInside: const BorderSide(
                color: Color(0xFFD4D4D8), // Exact matching notebook line color
                width: 1.0,
              ),
              verticalInside: BorderSide(
                color: AppTheme.iconRed.withOpacity(0.25),
                width: 1.0,
              ),
            ),
            children: [
              for (final hRow in headerRows)
                TableRow(
                  decoration: BoxDecoration(
                    color: AppTheme.iconRed.withOpacity(0.06),
                  ),
                  children: hRow.map((cell) => TableCell(
                    verticalAlignment: TableCellVerticalAlignment.top,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: _buildCellText(
                        cell,
                        isHeader: true,
                        cellStyle: cellStyleHeader,
                        cellStrut: cellStrut,
                      ),
                    ),
                  )).toList(),
                ),
              for (final bRow in bodyRows)
                TableRow(
                  children: bRow.map((cell) => TableCell(
                    verticalAlignment: TableCellVerticalAlignment.top,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: _buildCellText(
                        cell,
                        isHeader: false,
                        cellStyle: cellStyleBody,
                        cellStrut: cellStrut,
                      ),
                    ),
                  )).toList(),
                ),
            ],
          ),
        );

        if (needsScroll) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: tableWidget,
          );
        }
        return tableWidget;
      },
    );
  }
}

class _LinedAnswerBody extends StatelessWidget {
  final String content;
  final double fontSize;
  final double lineHeight;
  final double textHeightRatio;

  const _LinedAnswerBody({
    required this.content,
    required this.fontSize,
    required this.lineHeight,
    required this.textHeightRatio,
  });

  bool _isTableLine(String line) {
    final t = line.trim();
    if (!t.startsWith('|')) return false;
    final lastPipe = t.lastIndexOf('|');
    return lastPipe > 0;
  }

  bool _hasTableStructure(List<String> lines) {
    if (lines.length < 2) return false;
    return lines.any((l) => l.contains('---'));
  }

  Widget _linedRichText(
    String raw, {
    required TextStyle baseStyle,
    required StrutStyle strutStyle,
  }) {
    final cleanRaw = raw.replaceFirst(RegExp(r'^#+\s*'), '');
    final spans = <TextSpan>[];
    // Regex matches ***bold_italic***, **bold**, and *bold/italic*
    final regex = RegExp(r'(\*\*\*([^*]+?)\*\*\*|\*\*([^*]+?)\*\*|\*([^*]+?)\*)');
    int lastEnd = 0;

    for (final match in regex.allMatches(cleanRaw)) {
      if (match.start > lastEnd) {
        final plain = cleanRaw.substring(lastEnd, match.start).replaceAll('*', '');
        if (plain.isNotEmpty) {
          spans.add(TextSpan(text: plain));
        }
      }

      final boldItalic = match.group(2);
      final boldText = match.group(3);
      final singleStarText = match.group(4);

      if (boldItalic != null && boldItalic.isNotEmpty) {
        spans.add(
          TextSpan(
            text: boldItalic,
            style: baseStyle.copyWith(
              fontWeight: FontWeight.w800,
              fontStyle: FontStyle.italic,
              color: AppTheme.textPrimary,
            ),
          ),
        );
      } else if (boldText != null && boldText.isNotEmpty) {
        final isLabel = boldText.trim().endsWith(':');
        spans.add(
          TextSpan(
            text: boldText,
            style: baseStyle.copyWith(
              fontWeight: FontWeight.w800,
              color: isLabel ? AppTheme.iconRedDark : AppTheme.textPrimary,
            ),
          ),
        );
      } else if (singleStarText != null && singleStarText.isNotEmpty) {
        // Labels like *Mechanism:*, *Pros:*, *Cons:* are rendered bold
        final isLabel = singleStarText.trim().endsWith(':');
        spans.add(
          TextSpan(
            text: singleStarText,
            style: baseStyle.copyWith(
              fontWeight: isLabel ? FontWeight.w800 : FontWeight.w700,
              fontStyle: isLabel ? FontStyle.normal : FontStyle.italic,
              color: isLabel ? AppTheme.iconRedDark : AppTheme.textPrimary,
            ),
          ),
        );
      }
      lastEnd = match.end;
    }

    if (lastEnd < cleanRaw.length) {
      final tail = cleanRaw.substring(lastEnd).replaceAll('*', '');
      if (tail.isNotEmpty) {
        spans.add(TextSpan(text: tail));
      }
    }

    if (spans.isEmpty) {
      return SelectableText(
        cleanRaw.replaceAll('*', ''),
        style: baseStyle,
        strutStyle: strutStyle,
      );
    }

    return SelectableText.rich(
      TextSpan(style: baseStyle, children: spans),
      strutStyle: strutStyle,
    );
  }

  void _renderSingleLine(
    String t,
    TextStyle baseStyle,
    StrutStyle strut,
    List<Widget> children,
  ) {
    // Strip leading markdown hashes (#, ##, ###, ####)
    final isMarkdownHeading = t.startsWith('#');
    final withoutHashes = t.replaceFirst(RegExp(r'^#+\s*'), '').trim();
    final cleanForCheck = withoutHashes.replaceAll('*', '').trim();

    final isFullBoldLine = (withoutHashes.startsWith('**') && withoutHashes.endsWith('**')) ||
        (withoutHashes.startsWith('*') && withoutHashes.endsWith('*') && !withoutHashes.contains('•') && cleanForCheck.length < 80);

    final isHeading = isMarkdownHeading ||
        isFullBoldLine ||
        (cleanForCheck.endsWith(':') &&
            cleanForCheck.length < 80 &&
            !t.startsWith('•') &&
            !t.startsWith('-') &&
            !t.startsWith('* ')) ||
        RegExp(r'^[१२३४५६७८९1-9][.।]').hasMatch(cleanForCheck) ||
        cleanForCheck.startsWith('Introduction') ||
        cleanForCheck.startsWith('Conclusion') ||
        cleanForCheck.startsWith('Way Forward') ||
        cleanForCheck.startsWith('परिचय') ||
        cleanForCheck.startsWith('निष्कर्ष');

    final isBullet = t.startsWith('•') ||
        t.startsWith('-') ||
        (t.startsWith('*') && !t.startsWith('**'));

    if (isHeading) {
      children.add(
        SelectableText(
          cleanForCheck,
          style: baseStyle.copyWith(
            fontWeight: FontWeight.w800,
            color: AppTheme.iconRedDark,
            decoration: TextDecoration.underline,
            decorationColor: AppTheme.iconRed.withOpacity(0.55),
          ),
          strutStyle: strut,
        ),
      );
    } else if (isBullet) {
      final bulletContent = t.replaceFirst(RegExp(r'^[•\-\*]\s*'), '');
      children.add(
        _linedRichText(
          '•  $bulletContent',
          baseStyle: baseStyle,
          strutStyle: strut,
        ),
      );
    } else {
      children.add(
        _linedRichText(
          t,
          baseStyle: baseStyle,
          strutStyle: strut,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final baseStyle = TextStyle(
      fontSize: fontSize,
      height: textHeightRatio,
      color: AppTheme.textPrimary,
    );
    final strut = StrutStyle(
      fontSize: fontSize,
      height: textHeightRatio,
      forceStrutHeight: true,
      leading: 0,
    );

    final blocks = content
        .split('\n\n')
        .where((b) => b.trim().isNotEmpty)
        .toList();
    if (blocks.isEmpty) {
      return _linedRichText(content, baseStyle: baseStyle, strutStyle: strut);
    }

    final children = <Widget>[];
    for (int bIdx = 0; bIdx < blocks.length; bIdx++) {
      final lines = blocks[bIdx]
          .split('\n')
          .where((l) => l.trim().isNotEmpty)
          .toList();

      int lIdx = 0;
      while (lIdx < lines.length) {
        final line = lines[lIdx];
        final t = line.trim();

        if (t.isEmpty) {
          lIdx++;
          continue;
        }

        // 1. Code / Diagram block
        if (t.startsWith('```')) {
          final codeLines = <String>[];
          if (t.length > 3 && t.endsWith('```')) {
            codeLines.add(t.substring(3, t.length - 3).trim());
            lIdx++;
          } else {
            lIdx++;
            while (lIdx < lines.length && !lines[lIdx].trim().startsWith('```')) {
              codeLines.add(lines[lIdx]);
              lIdx++;
            }
            if (lIdx < lines.length && lines[lIdx].trim().startsWith('```')) {
              lIdx++; // consume closing backticks
            }
          }
          children.add(
            _DiagramCodeWidget(
              code: codeLines.join('\n'),
              fontSize: fontSize,
              lineHeight: lineHeight,
            ),
          );
          continue;
        }

        // 2. Markdown Table block
        if (_isTableLine(t)) {
          final tableLines = <String>[];
          while (lIdx < lines.length && _isTableLine(lines[lIdx].trim())) {
            tableLines.add(lines[lIdx].trim());
            lIdx++;
          }
          if (_hasTableStructure(tableLines)) {
            children.add(
              _MarkdownTableWidget(
                lines: tableLines,
                fontSize: fontSize,
                lineHeight: lineHeight,
                textHeightRatio: textHeightRatio,
              ),
            );
            continue;
          } else {
            for (final tblLine in tableLines) {
              _renderSingleLine(tblLine, baseStyle, strut, children);
            }
            continue;
          }
        }

        // 3. Regular Line: Heading, Bullet, or Paragraph
        _renderSingleLine(t, baseStyle, strut, children);
        lIdx++;
      }

      // Leave 1 exact blank ruled line between answer sections
      if (bIdx < blocks.length - 1) {
        children.add(SizedBox(height: lineHeight));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
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

  Widget _richExplanation(String raw, {required TextStyle baseStyle}) {
    final spans = <TextSpan>[];
    final regex = RegExp(r'(\*\*\*([^*]+?)\*\*\*|\*\*([^*]+?)\*\*|\*([^*]+?)\*)');
    int lastEnd = 0;

    for (final match in regex.allMatches(raw)) {
      if (match.start > lastEnd) {
        final plain = raw.substring(lastEnd, match.start).replaceAll('*', '');
        if (plain.isNotEmpty) {
          spans.add(TextSpan(text: plain));
        }
      }

      final boldItalic = match.group(2);
      final boldText = match.group(3);
      final singleStarText = match.group(4);

      if (boldItalic != null && boldItalic.isNotEmpty) {
        spans.add(
          TextSpan(
            text: boldItalic,
            style: baseStyle.copyWith(
              fontWeight: FontWeight.w800,
              fontStyle: FontStyle.italic,
              color: AppTheme.textPrimary,
            ),
          ),
        );
      } else if (boldText != null && boldText.isNotEmpty) {
        final isLabel = boldText.trim().endsWith(':');
        spans.add(
          TextSpan(
            text: boldText,
            style: baseStyle.copyWith(
              fontWeight: FontWeight.w800,
              color: isLabel ? AppTheme.iconRedDark : AppTheme.textPrimary,
            ),
          ),
        );
      } else if (singleStarText != null && singleStarText.isNotEmpty) {
        final isLabel = singleStarText.trim().endsWith(':');
        spans.add(
          TextSpan(
            text: singleStarText,
            style: baseStyle.copyWith(
              fontWeight: isLabel ? FontWeight.w800 : FontWeight.w700,
              fontStyle: isLabel ? FontStyle.normal : FontStyle.italic,
              color: isLabel ? AppTheme.iconRedDark : AppTheme.textPrimary,
            ),
          ),
        );
      }
      lastEnd = match.end;
    }

    if (lastEnd < raw.length) {
      final tail = raw.substring(lastEnd).replaceAll('*', '');
      if (tail.isNotEmpty) {
        spans.add(TextSpan(text: tail));
      }
    }

    if (spans.isEmpty) {
      return SelectableText(raw.replaceAll('*', ''), style: baseStyle);
    }

    return SelectableText.rich(TextSpan(style: baseStyle, children: spans));
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
                _richExplanation(
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
            'Upgrade to Pro Plan (रू 199) to unlock all Paper I, Paper II & Paper III model answers.',
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
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(isMobile ? 14 : 24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Container(
            padding: EdgeInsets.all(isMobile ? 22 : 32),
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
                const Text(
                  'Timed MCQ Mock Test',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
                  textAlign: TextAlign.center,
                ),
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
      ),
    );
  }

  Widget _rule(IconData icon, String text, bool isRed) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Icon(icon, size: 18, color: isRed ? AppTheme.iconRed : AppTheme.primaryColor),
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 13.5, color: AppTheme.textBody))),
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
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: AppTheme.divider, width: 1)),
          ),
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 14 : 20, vertical: 10),
          child: Row(
            children: [
              const Icon(Icons.timer_outlined, color: AppTheme.iconRed, size: 19),
              const SizedBox(width: 6),
              Text(
                '${remaining.inMinutes.toString().padLeft(2, '0')}:${(remaining.inSeconds % 60).toString().padLeft(2, '0')}',
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w800,
                  fontSize: isMobile ? 16 : 18,
                ),
              ),
              const Spacer(),
              Text(
                isMobile
                    ? 'Q ${mt.currentIndex + 1} / ${mt.questions.length}'
                    : 'Question ${mt.currentIndex + 1} of ${mt.questions.length}',
                style: const TextStyle(color: AppTheme.textMuted, fontSize: 12.5, fontWeight: FontWeight.w600),
              ),
              SizedBox(width: isMobile ? 10 : 16),
              FilledButton(
                onPressed: () {
                  _timer?.cancel();
                  context.read<MockTestProvider>().submitTest();
                },
                style: FilledButton.styleFrom(
                  backgroundColor: AppTheme.iconRed,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 16, vertical: 10),
                ),
                child: Text(
                  isMobile ? 'Submit' : 'Submit Test',
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                ),
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
            padding: EdgeInsets.all(isMobile ? 14 : 24),
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
    final isMobile = MediaQuery.of(context).size.width < 600;
    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 14 : 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(isMobile ? 20 : 28),
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

    final isMobile = MediaQuery.of(context).size.width < 600;

    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 14 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(isMobile ? 16 : 22),
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
                    Expanded(
                      child: Text(
                        '${exam.organization} • ${exam.level}',
                        style: const TextStyle(color: AppTheme.iconRedDark, fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  exam.title,
                  style: TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.w800, fontSize: isMobile ? 18 : 20),
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
              padding: EdgeInsets.all(isMobile ? 16 : 20),
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
                      Expanded(
                        child: Text(
                          'Examination Scheme (परीक्षा योजना)',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
                        ),
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

// ─── Donate Questions & Earn Money Tab (100 Verified Questions = रू 5) ───
class DonateQuestionsTab extends StatefulWidget {
  final VoidCallback? onGoToExams;
  const DonateQuestionsTab({super.key, this.onGoToExams});

  @override
  State<DonateQuestionsTab> createState() => _DonateQuestionsTabState();
}

class _DonateQuestionsTabState extends State<DonateQuestionsTab> {
  final _unitTitleCtrl = TextEditingController(text: 'Unit 1: Core Syllabus Topic');
  final _yearCtrl = TextEditingController(text: '2081 BS / Model Practice');
  final _qNpCtrl = TextEditingController();
  final _qEnCtrl = TextEditingController();
  final _ansNpCtrl = TextEditingController();
  final _ansEnCtrl = TextEditingController();
  final _optACtrl = TextEditingController();
  final _optBCtrl = TextEditingController();
  final _optCCtrl = TextEditingController();
  final _optDCtrl = TextEditingController();
  final _expCtrl = TextEditingController();
  final _walletCtrl = TextEditingController();

  String _qType = 'subjective';
  String _paper = 'paper1';
  String _section = 'sectionA';
  int _unitNum = 1;
  int _marks = 5;
  int _correctIdx = 0;
  String? _selectedExamId;

  bool _submitting = false;
  bool _claiming = false;
  bool _loadingDonations = false;
  int _totalSubmitted = 0;
  int _verifiedCount = 0;
  int _unclaimedVerifiedCount = 0;
  int _claimedCount = 0;
  int _pendingCount = 0;
  double _earnedRupees = 0.0;
  double _claimableRupees = 0.0;
  String _paymentMethod = 'eSewa';
  String? _questionPhotoDataUrl;
  String? _questionPhotoName;
  String? _answerPhotoDataUrl;
  String? _answerPhotoName;
  List<Map<String, dynamic>> _myDonations = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadMyDonations();
    });
  }

  @override
  void dispose() {
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
    _walletCtrl.dispose();
    super.dispose();
  }

  void _pickDonationPhoto({required bool isQuestionPhoto}) {
    final input = html.FileUploadInputElement()..accept = 'image/*';
    input.click();
    input.onChange.listen((_) {
      final files = input.files;
      if (files == null || files.isEmpty) return;
      final file = files.first;
      if (file.size > 4 * 1024 * 1024) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Photo size exceeds 4 MB. Please select a clear photo under 4 MB.'),
            backgroundColor: AppTheme.iconRed,
          ),
        );
        return;
      }
      final reader = html.FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((_) {
        final dataUrl = reader.result as String?;
        if (dataUrl == null || !mounted) return;
        setState(() {
          if (isQuestionPhoto) {
            _questionPhotoDataUrl = dataUrl;
            _questionPhotoName = file.name;
          } else {
            _answerPhotoDataUrl = dataUrl;
            _answerPhotoName = file.name;
          }
        });
      });
    });
  }

  Widget _buildPhotoImageWidget(String photoSource, {double? height, BoxFit fit = BoxFit.cover}) {
    if (photoSource.startsWith('data:image/')) {
      final commaIdx = photoSource.indexOf(',');
      if (commaIdx != -1) {
        try {
          final bytes = base64Decode(photoSource.substring(commaIdx + 1));
          return Image.memory(
            bytes,
            height: height,
            width: double.infinity,
            fit: fit,
            errorBuilder: (_, __, ___) => const Center(
              child: Icon(Icons.broken_image_outlined, color: AppTheme.iconRed),
            ),
          );
        } catch (_) {}
      }
    }
    return Image.network(
      photoSource,
      height: height,
      width: double.infinity,
      fit: fit,
      errorBuilder: (_, __, ___) => const Center(
        child: Icon(Icons.broken_image_outlined, color: AppTheme.iconRed),
      ),
    );
  }

  void _showPhotoPreviewDialog(String title, String photoSource) {
    showDialog<void>(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720, maxHeight: 680),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      icon: const Icon(Icons.close_rounded, color: AppTheme.textPrimary),
                    ),
                  ],
                ),
                const Divider(height: 16),
                Flexible(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: InteractiveViewer(
                      minScale: 0.8,
                      maxScale: 4.0,
                      child: _buildPhotoImageWidget(photoSource, fit: BoxFit.contain),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoUploadCard({
    required String title,
    required String subtitle,
    required String? photoDataUrl,
    required String? photoName,
    required VoidCallback onPick,
    required VoidCallback onClear,
  }) {
    final hasPhoto = photoDataUrl != null && photoDataUrl.isNotEmpty;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: hasPhoto ? AppTheme.iconRedLight.withOpacity(0.55) : const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: hasPhoto ? AppTheme.iconRed : AppTheme.divider,
          width: hasPhoto ? 1.5 : 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                hasPhoto ? Icons.check_circle_rounded : Icons.add_a_photo_outlined,
                size: 18,
                color: AppTheme.iconRed,
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 11.5, color: AppTheme.textMuted, height: 1.35),
          ),
          const SizedBox(height: 10),
          if (hasPhoto) ...[
            GestureDetector(
              onTap: () => _showPhotoPreviewDialog(title, photoDataUrl),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppTheme.divider),
                  ),
                  child: _buildPhotoImageWidget(photoDataUrl, height: 120, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    photoName ?? 'Uploaded Photo',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: onPick,
                  icon: const Icon(Icons.sync_rounded, size: 14, color: AppTheme.textPrimary),
                  label: const Text(
                    'Change',
                    style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: AppTheme.textPrimary),
                  ),
                ),
                TextButton.icon(
                  onPressed: onClear,
                  icon: const Icon(Icons.delete_outline_rounded, size: 14, color: AppTheme.iconRed),
                  label: const Text(
                    'Remove',
                    style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: AppTheme.iconRed),
                  ),
                ),
              ],
            ),
          ] else
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onPick,
                icon: const Icon(Icons.camera_alt_outlined, size: 16, color: AppTheme.iconRed),
                label: const Text(
                  'Upload Clear Photo',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppTheme.iconRed),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppTheme.iconRed),
                  padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _loadMyDonations() async {
    final token = context.read<AuthProvider>().token;
    if (token == null || token.isEmpty) return;
    setState(() => _loadingDonations = true);
    try {
      final res = await http.get(
        Uri.parse('${AppConstants.apiBaseUrl}/questions/donations/my'),
        headers: {'Authorization': 'Bearer $token'},
      ).timeout(const Duration(seconds: 15));
      if (res.statusCode == 200 && mounted) {
        final data = jsonDecode(res.body) as Map<String, dynamic>;
        final rawList = (data['donations'] as List<dynamic>?) ?? [];
        final parsedList = rawList.map((e) => Map<String, dynamic>.from(e as Map)).toList();
        final verifiedTotal = (data['verifiedCount'] as num?)?.toInt() ?? 0;
        final unclaimedVerified = (data['unclaimedVerifiedCount'] as num?)?.toInt() ??
            parsedList.where((d) => d['status'] == 'approved' && d['claimed'] != true).length;
        final claimedTotal = (data['claimedCount'] as num?)?.toInt() ??
            parsedList.where((d) => d['status'] == 'approved' && d['claimed'] == true).length;

        setState(() {
          _totalSubmitted = (data['totalSubmitted'] as num?)?.toInt() ?? parsedList.length;
          _verifiedCount = verifiedTotal;
          _unclaimedVerifiedCount = unclaimedVerified;
          _claimedCount = claimedTotal;
          _pendingCount = (data['pendingCount'] as num?)?.toInt() ?? 0;
          _earnedRupees = (data['earnedRupees'] as num?)?.toDouble() ?? (_verifiedCount * 0.05);
          _claimableRupees = (data['claimableRupees'] as num?)?.toDouble() ?? (_unclaimedVerifiedCount * 0.05);
          _myDonations = parsedList;
          _loadingDonations = false;
        });
        return;
      }
    } catch (_) {}
    if (mounted) setState(() => _loadingDonations = false);
  }

  Future<void> _claimReward() async {
    if (_unclaimedVerifiedCount < 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'You need at least 200 verified questions to claim. Currently $_unclaimedVerifiedCount / 200 verified.',
          ),
          backgroundColor: AppTheme.iconRed,
        ),
      );
      return;
    }

    final walletId = _walletCtrl.text.trim();
    if (walletId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter your $_paymentMethod ID / Mobile Number to claim your reward.'),
          backgroundColor: AppTheme.iconRed,
        ),
      );
      return;
    }

    final token = context.read<AuthProvider>().token;
    if (token == null || token.isEmpty) return;

    setState(() => _claiming = true);
    try {
      final res = await http.post(
        Uri.parse('${AppConstants.apiBaseUrl}/questions/donations/claim'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'paymentMethod': _paymentMethod,
          'walletId': walletId,
        }),
      ).timeout(const Duration(seconds: 15));

      if (!mounted) return;
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              data['message']?.toString() ??
                  'Reward claim submitted! Payment will be sent to your $_paymentMethod ID ($walletId).',
            ),
            backgroundColor: AppTheme.primaryColor,
          ),
        );
        await _loadMyDonations();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['error']?.toString() ?? 'Failed to submit reward claim.'),
            backgroundColor: AppTheme.iconRed,
          ),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Network error while claiming reward. Please try again.'),
            backgroundColor: AppTheme.iconRed,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _claiming = false);
    }
  }

  Future<void> _submitDonation(String examId) async {
    final qNp = _qNpCtrl.text.trim();
    final qEn = _qEnCtrl.text.trim();
    final hasQuestionPhoto = _questionPhotoDataUrl != null && _questionPhotoDataUrl!.isNotEmpty;
    final hasAnswerPhoto = _answerPhotoDataUrl != null && _answerPhotoDataUrl!.isNotEmpty;

    if (qNp.isEmpty && qEn.isEmpty && !hasQuestionPhoto) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter the question text OR upload a clear photo of the question.'),
          backgroundColor: AppTheme.iconRed,
        ),
      );
      return;
    }

    if (_qType == 'subjective') {
      if (_ansNpCtrl.text.trim().isEmpty &&
          _ansEnCtrl.text.trim().isEmpty &&
          !hasAnswerPhoto &&
          !hasQuestionPhoto) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Please type the model answer OR upload a clear photo of your well-written answer for verification.',
            ),
            backgroundColor: AppTheme.iconRed,
          ),
        );
        return;
      }
    } else {
      final hasAllOptions = _optACtrl.text.trim().isNotEmpty &&
          _optBCtrl.text.trim().isNotEmpty &&
          _optCCtrl.text.trim().isNotEmpty &&
          _optDCtrl.text.trim().isNotEmpty;
      if (!hasAllOptions && !hasQuestionPhoto && !hasAnswerPhoto) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter all 4 MCQ options OR upload a clear photo of the MCQ & answer.'),
            backgroundColor: AppTheme.iconRed,
          ),
        );
        return;
      }
    }

    final token = context.read<AuthProvider>().token;
    if (token == null || token.isEmpty) return;

    setState(() => _submitting = true);
    try {
      final cleanUnitTitle = _unitTitleCtrl.text.trim().isEmpty
          ? 'Unit $_unitNum'
          : _unitTitleCtrl.text.trim();
      final fallbackQText = '[Photo Question] $cleanUnitTitle';

      final payload = <String, dynamic>{
        'exam_id': examId,
        'paper': _paper,
        'section': _section,
        'unit_number': _unitNum,
        'unit_title': cleanUnitTitle,
        'marks': _marks,
        'type': _qType,
        'years_asked': [
          _yearCtrl.text.trim().isEmpty ? 'Candidate Contributed' : _yearCtrl.text.trim()
        ],
        'question_nepali': qNp.isNotEmpty ? qNp : (qEn.isNotEmpty ? qEn : fallbackQText),
        'question_english': qEn.isNotEmpty ? qEn : (qNp.isNotEmpty ? qNp : fallbackQText),
        'question_photo_url': _questionPhotoDataUrl,
        'answer_photo_url': _answerPhotoDataUrl,
      };

      if (_qType == 'subjective') {
        final aNp = _ansNpCtrl.text.trim();
        final aEn = _ansEnCtrl.text.trim();
        const fallbackAns = '[See attached well-written answer photo for verification]';
        payload['answer_nepali'] = aNp.isNotEmpty ? aNp : (aEn.isNotEmpty ? aEn : fallbackAns);
        payload['answer_english'] = aEn.isNotEmpty ? aEn : (aNp.isNotEmpty ? aNp : fallbackAns);
      } else {
        payload['options'] = [
          _optACtrl.text.trim(),
          _optBCtrl.text.trim(),
          _optCCtrl.text.trim(),
          _optDCtrl.text.trim(),
        ];
        payload['correct_option_index'] = _correctIdx;
        payload['explanation'] = _expCtrl.text.trim();
      }

      final res = await http.post(
        Uri.parse('${AppConstants.apiBaseUrl}/questions/donations'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(payload),
      ).timeout(const Duration(seconds: 20));

      if (!mounted) return;
      final data = jsonDecode(res.body) as Map<String, dynamic>;

      if (res.statusCode == 201) {
        _qNpCtrl.clear();
        _qEnCtrl.clear();
        _ansNpCtrl.clear();
        _ansEnCtrl.clear();
        _optACtrl.clear();
        _optBCtrl.clear();
        _optCCtrl.clear();
        _optDCtrl.clear();
        _expCtrl.clear();
        setState(() {
          _questionPhotoDataUrl = null;
          _questionPhotoName = null;
          _answerPhotoDataUrl = null;
          _answerPhotoName = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              data['message']?.toString() ??
                  'Question & answer donated successfully! Sent for Admin verification.',
            ),
            backgroundColor: AppTheme.primaryColor,
          ),
        );
        await _loadMyDonations();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['error']?.toString() ?? 'Failed to donate question'),
            backgroundColor: AppTheme.iconRed,
          ),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Network error while submitting question. Please try again.'),
            backgroundColor: AppTheme.iconRed,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final qp = context.watch<QuestionProvider>();
    final auth = context.watch<AuthProvider>();
    final user = auth.user;

    final isEnrolled = (user?.isAdmin ?? false) || (user?.enrolledExams.isNotEmpty ?? false);
    if (!isEnrolled) {
      return _NotEnrolledPrompt(onGoToExams: widget.onGoToExams);
    }

    // Restrict available exams strictly to the candidate's enrolled exam(s)
    final enrolledExamCourses = (user?.isAdmin ?? false)
        ? qp.exams
        : qp.exams.where((e) => user!.enrolledExams.contains(e.id)).toList();

    final activeExam = enrolledExamCourses.isNotEmpty
        ? enrolledExamCourses.firstWhere(
            (e) => e.id == (_selectedExamId ?? qp.selectedExamId),
            orElse: () => enrolledExamCourses.first,
          )
        : qp.selectedExam;

    final targetExamId = activeExam?.id ??
        (user!.enrolledExams.isNotEmpty ? user.enrolledExams.first : 'rbb_it_5');

    final screenW = MediaQuery.of(context).size.width;
    final isMobile = screenW < 680;
    final eligibleToClaim = _unclaimedVerifiedCount >= 200;
    final claimProgressRatio = (_unclaimedVerifiedCount / 200.0).clamp(0.0, 1.0);
    final remainingToClaim = (200 - _unclaimedVerifiedCount).clamp(0, 200);

    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 14 : 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 920),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── 1. REWARD PROGRAM BANNER & EARNINGS TRACKER ──
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(isMobile ? 16 : 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.iconRed, width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 10,
                      runSpacing: 8,
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.iconRedLight,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: AppTheme.iconRed.withOpacity(0.35)),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.volunteer_activism_rounded, size: 14, color: AppTheme.iconRed),
                              SizedBox(width: 6),
                              Text(
                                'CANDIDATE QUESTION DONATION & REWARD PROGRAM',
                                style: TextStyle(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w800,
                                  color: AppTheme.iconRedDark,
                                  letterSpacing: 0.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: _loadMyDonations,
                          borderRadius: BorderRadius.circular(6),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.refresh_rounded, size: 14, color: AppTheme.iconRed),
                                SizedBox(width: 4),
                                Text(
                                  'Refresh Status',
                                  style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: AppTheme.iconRed),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Donate Valid Questions & Earn Money (100 Verified = रू 5.00 • Claim at 200 Verified Qs)',
                      style: TextStyle(
                        fontSize: isMobile ? 17.5 : 20,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.textPrimary,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Contribute authentic Lok Sewa subjective Q&As or objective MCQs for your enrolled exam course — either by typing or by uploading a clear photo of the question and a well-written answer! Every valid question approved by our Admin team earns रू 0.05 (100 Verified Questions = रू 5.00). Reach 200 Admin-Verified Questions (रू 10.00) to unlock your Payment ID claim!',
                      style: TextStyle(fontSize: 13, color: AppTheme.textBody, height: 1.5),
                    ),
                    const SizedBox(height: 18),

                    // Stats cards row
                    LayoutBuilder(
                      builder: (ctx, constraints) {
                        final boxW = isMobile
                            ? ((constraints.maxWidth - 10) / 2).clamp(115.0, 400.0)
                            : ((constraints.maxWidth - 36) / 4).clamp(160.0, 220.0);
                        return Wrap(
                          spacing: isMobile ? 10 : 12,
                          runSpacing: isMobile ? 10 : 12,
                          children: [
                            _DonationStatBox(
                              label: 'Unclaimed Balance',
                              value: 'रू ${_claimableRupees.toStringAsFixed(2)}',
                              sub: 'Total earned: रू ${_earnedRupees.toStringAsFixed(2)}',
                              highlightRed: true,
                              width: boxW,
                            ),
                            _DonationStatBox(
                              label: 'Verified (Unclaimed)',
                              value: '$_unclaimedVerifiedCount / 200',
                              sub: _claimedCount > 0
                                  ? '$_claimedCount Qs already claimed'
                                  : '200 Qs needed to claim',
                              highlightRed: eligibleToClaim,
                              width: boxW,
                            ),
                            _DonationStatBox(
                              label: 'Pending Review',
                              value: '$_pendingCount Qs',
                              sub: 'Awaiting verification',
                              highlightRed: false,
                              width: boxW,
                            ),
                            _DonationStatBox(
                              label: 'Total Donated',
                              value: '$_totalSubmitted Qs',
                              sub: 'All submissions',
                              highlightRed: false,
                              width: boxW,
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 16),
                    // Claim Eligibility Progress Bar (0 -> 200 Verified Questions = Rs. 10 Claim Unlock)
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: eligibleToClaim ? AppTheme.iconRedLight : const Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: eligibleToClaim ? AppTheme.iconRed : AppTheme.divider,
                          width: eligibleToClaim ? 1.5 : 1.0,
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
                                  eligibleToClaim
                                      ? '🎉 Eligible to Claim Reward! ($_unclaimedVerifiedCount Verified Questions = रू ${_claimableRupees.toStringAsFixed(2)})'
                                      : 'Claim Eligibility Progress ($_unclaimedVerifiedCount / 200 Verified Questions Required)',
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w800,
                                    color: eligibleToClaim ? AppTheme.iconRedDark : AppTheme.textPrimary,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${(claimProgressRatio * 100).toInt()}%',
                                style: const TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w800,
                                  color: AppTheme.iconRed,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: claimProgressRatio,
                              minHeight: 7,
                              backgroundColor: AppTheme.divider,
                              color: AppTheme.iconRed,
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (!eligibleToClaim)
                            Row(
                              children: [
                                const Icon(Icons.lock_clock_outlined, size: 16, color: AppTheme.textMuted),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    'Reach 200 Admin-Verified Questions (रू 10.00) to unlock reward withdrawal & enter your Payment ID ($remainingToClaim more verified questions needed).',
                                    style: const TextStyle(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.textMuted,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          else ...[
                            const Divider(height: 18),
                            const Text(
                              'Provide Your Payment ID to Claim Your Earned Reward:',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 10),
                            if (isMobile) ...[
                              DropdownButtonFormField<String>(
                                value: _paymentMethod,
                                decoration: const InputDecoration(
                                  labelText: 'Select Payment Method *',
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                items: const [
                                  DropdownMenuItem(value: 'eSewa', child: Text('eSewa Wallet')),
                                  DropdownMenuItem(value: 'Khalti', child: Text('Khalti Wallet')),
                                ],
                                onChanged: (v) => setState(() => _paymentMethod = v ?? 'eSewa'),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: _walletCtrl,
                                decoration: InputDecoration(
                                  labelText: 'Your $_paymentMethod ID / Mobile Number *',
                                  hintText: 'e.g. 98XXXXXXXX',
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: const Icon(
                                    Icons.account_balance_wallet_outlined,
                                    size: 18,
                                    color: AppTheme.iconRed,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: double.infinity,
                                child: FilledButton.icon(
                                  onPressed: _claiming ? null : _claimReward,
                                  icon: _claiming
                                      ? const SizedBox(
                                          width: 15,
                                          height: 15,
                                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                        )
                                      : const Icon(Icons.payments_outlined, size: 17, color: Colors.white),
                                  label: Text(
                                    _claiming
                                        ? 'Submitting Claim...'
                                        : 'Claim Reward Now (रू ${_claimableRupees.toStringAsFixed(2)})',
                                    style: const TextStyle(fontWeight: FontWeight.w800),
                                  ),
                                  style: FilledButton.styleFrom(
                                    backgroundColor: AppTheme.iconRed,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                  ),
                                ),
                              ),
                            ] else
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: DropdownButtonFormField<String>(
                                      value: _paymentMethod,
                                      decoration: const InputDecoration(
                                        labelText: 'Payment Method *',
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      items: const [
                                        DropdownMenuItem(value: 'eSewa', child: Text('eSewa Wallet')),
                                        DropdownMenuItem(value: 'Khalti', child: Text('Khalti Wallet')),
                                      ],
                                      onChanged: (v) => setState(() => _paymentMethod = v ?? 'eSewa'),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    flex: 3,
                                    child: TextField(
                                      controller: _walletCtrl,
                                      decoration: InputDecoration(
                                        labelText: 'Your $_paymentMethod ID / Mobile Number *',
                                        hintText: 'e.g. 98XXXXXXXX',
                                        filled: true,
                                        fillColor: Colors.white,
                                        prefixIcon: const Icon(
                                          Icons.account_balance_wallet_outlined,
                                          size: 18,
                                          color: AppTheme.iconRed,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  FilledButton.icon(
                                    onPressed: _claiming ? null : _claimReward,
                                    icon: _claiming
                                        ? const SizedBox(
                                            width: 15,
                                            height: 15,
                                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                          )
                                        : const Icon(Icons.payments_outlined, size: 17, color: Colors.white),
                                    label: Text(
                                      _claiming
                                          ? 'Claiming...'
                                          : 'Claim रू ${_claimableRupees.toStringAsFixed(2)}',
                                      style: const TextStyle(fontWeight: FontWeight.w800),
                                    ),
                                    style: FilledButton.styleFrom(
                                      backgroundColor: AppTheme.iconRed,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ── 2. QUESTION DONATION INPUT FORM (SCOPED TO ENROLLED COURSE) ──
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(isMobile ? 16 : 24),
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
                        Icon(Icons.edit_note_rounded, color: AppTheme.iconRed, size: 22),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Donate a Question for Your Enrolled Course',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                      decoration: BoxDecoration(
                        color: AppTheme.iconRedLight,
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(color: AppTheme.iconRed.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.verified_user_outlined, size: 16, color: AppTheme.iconRed),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              user!.isAdmin
                                  ? 'Admin Mode: You can donate questions to any exam course.'
                                  : 'Enrolled Course Rule: Since you are enrolled in "${activeExam?.title ?? targetExamId}", you can donate questions exclusively for this exam course.',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.iconRedDark,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Enrolled Exam Selector (Locked to Enrolled Exam if single course)
                    if (enrolledExamCourses.length <= 1 && activeExam != null)
                      TextField(
                        readOnly: true,
                        controller: TextEditingController(
                          text: '${activeExam.title} (${activeExam.titleNepali}) — Enrolled',
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Target Enrolled Exam Course (Locked to Your Course) *',
                          prefixIcon: Icon(Icons.lock_outline_rounded, size: 18, color: AppTheme.iconRed),
                        ),
                      )
                    else
                      DropdownButtonFormField<String>(
                        isExpanded: true,
                        value: targetExamId,
                        decoration: const InputDecoration(
                          labelText: 'Select Your Enrolled Exam Course *',
                          prefixIcon: Icon(Icons.school_outlined, size: 18, color: AppTheme.iconRed),
                        ),
                        items: enrolledExamCourses
                            .map(
                              (e) => DropdownMenuItem(
                                value: e.id,
                                child: Text('${e.title} (${e.category})', overflow: TextOverflow.ellipsis),
                              ),
                            )
                            .toList(),
                        onChanged: (v) => setState(() => _selectedExamId = v),
                      ),

                    const SizedBox(height: 14),

                    // Row: Question Type + Paper + Section
                    if (isMobile) ...[
                      DropdownButtonFormField<String>(
                        isExpanded: true,
                        value: _qType,
                        decoration: const InputDecoration(labelText: 'Question Type *'),
                        items: const [
                          DropdownMenuItem(value: 'subjective', child: Text('Subjective (Written Q&A — विषयगत)', overflow: TextOverflow.ellipsis)),
                          DropdownMenuItem(value: 'mcq', child: Text('Objective MCQ (4 Options — वस्तुगत)', overflow: TextOverflow.ellipsis)),
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
                              decoration: const InputDecoration(labelText: 'Paper *'),
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
                              decoration: const InputDecoration(labelText: 'Section *'),
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
                              decoration: const InputDecoration(labelText: 'Question Type *'),
                              items: const [
                                DropdownMenuItem(value: 'subjective', child: Text('Subjective (Written Q&A — विषयगत)')),
                                DropdownMenuItem(value: 'mcq', child: Text('Objective MCQ (4 Options — वस्तुगत)')),
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
                              decoration: const InputDecoration(labelText: 'Paper *'),
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
                              decoration: const InputDecoration(labelText: 'Section *'),
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

                    // Row: Unit Number + Marks + Year Asked/Source
                    if (isMobile) ...[
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              value: _unitNum,
                              decoration: const InputDecoration(labelText: 'Syllabus Unit *'),
                              items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                                  .map((u) => DropdownMenuItem(value: u, child: Text('Unit $u')))
                                  .toList(),
                              onChanged: (v) => setState(() {
                                _unitNum = v!;
                                if (_unitTitleCtrl.text.startsWith('Unit ')) {
                                  _unitTitleCtrl.text = 'Unit $_unitNum: Core Syllabus Topic';
                                }
                              }),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              value: _marks,
                              decoration: const InputDecoration(labelText: 'Marks *'),
                              items: const [
                                DropdownMenuItem(value: 1, child: Text('1 Mark')),
                                DropdownMenuItem(value: 2, child: Text('2 Marks')),
                                DropdownMenuItem(value: 5, child: Text('5 Marks')),
                                DropdownMenuItem(value: 10, child: Text('10 Marks')),
                              ],
                              onChanged: (v) => setState(() => _marks = v!),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _yearCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Past Year / Source',
                          hintText: 'e.g. 2081 BS / Model',
                        ),
                      ),
                    ] else
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              value: _unitNum,
                              decoration: const InputDecoration(labelText: 'Syllabus Unit *'),
                              items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                                  .map((u) => DropdownMenuItem(value: u, child: Text('Unit $u')))
                                  .toList(),
                              onChanged: (v) => setState(() {
                                _unitNum = v!;
                                if (_unitTitleCtrl.text.startsWith('Unit ')) {
                                  _unitTitleCtrl.text = 'Unit $_unitNum: Core Syllabus Topic';
                                }
                              }),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              value: _marks,
                              decoration: const InputDecoration(labelText: 'Marks *'),
                              items: const [
                                DropdownMenuItem(value: 1, child: Text('1 Mark')),
                                DropdownMenuItem(value: 2, child: Text('2 Marks')),
                                DropdownMenuItem(value: 5, child: Text('5 Marks')),
                                DropdownMenuItem(value: 10, child: Text('10 Marks')),
                              ],
                              onChanged: (v) => setState(() => _marks = v!),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 2,
                            child: TextField(
                              controller: _yearCtrl,
                              decoration: const InputDecoration(
                                labelText: 'Past Year / Source',
                                hintText: 'e.g. 2081 BS / Model',
                              ),
                            ),
                          ),
                        ],
                      ),

                    const SizedBox(height: 14),
                    TextField(
                      controller: _unitTitleCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Unit / Topic Title *',
                        hintText: 'e.g. Unit 1: Banking Laws & NRB Directives',
                      ),
                    ),

                    const SizedBox(height: 18),

                    // ── PHOTO UPLOAD OPTION FOR QUESTION & WELL-WRITTEN ANSWER ──
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppTheme.iconRed.withOpacity(0.45)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.camera_enhance_rounded, color: AppTheme.iconRed, size: 19),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Option A: Upload Clear Photo of Question & Well-Written Answer',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppTheme.iconRedLight,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: AppTheme.iconRed.withOpacity(0.3)),
                            ),
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.verified_outlined, size: 16, color: AppTheme.iconRed),
                                SizedBox(width: 7),
                                Expanded(
                                  child: Text(
                                    'Photo Verification Requirement: Uploaded photos must be clear, sharp, and legible, and the answer must be well-written & structured in proper Lok Sewa format to be approved by Admin.',
                                    style: TextStyle(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w700,
                                      color: AppTheme.iconRedDark,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          if (isMobile) ...[
                            _buildPhotoUploadCard(
                              title: '1. Question Photo (Clear & Legible)',
                              subtitle: 'Upload a sharp photo of the printed or handwritten question.',
                              photoDataUrl: _questionPhotoDataUrl,
                              photoName: _questionPhotoName,
                              onPick: () => _pickDonationPhoto(isQuestionPhoto: true),
                              onClear: () => setState(() {
                                _questionPhotoDataUrl = null;
                                _questionPhotoName = null;
                              }),
                            ),
                            const SizedBox(height: 10),
                            _buildPhotoUploadCard(
                              title: '2. Well-Written Answer Photo',
                              subtitle: 'Upload a clear photo of your well-written, structured answer sheet.',
                              photoDataUrl: _answerPhotoDataUrl,
                              photoName: _answerPhotoName,
                              onPick: () => _pickDonationPhoto(isQuestionPhoto: false),
                              onClear: () => setState(() {
                                _answerPhotoDataUrl = null;
                                _answerPhotoName = null;
                              }),
                            ),
                          ] else
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: _buildPhotoUploadCard(
                                    title: '1. Question Photo (Clear & Legible)',
                                    subtitle: 'Upload a sharp photo of the printed or handwritten question.',
                                    photoDataUrl: _questionPhotoDataUrl,
                                    photoName: _questionPhotoName,
                                    onPick: () => _pickDonationPhoto(isQuestionPhoto: true),
                                    onClear: () => setState(() {
                                      _questionPhotoDataUrl = null;
                                      _questionPhotoName = null;
                                    }),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildPhotoUploadCard(
                                    title: '2. Well-Written Answer Photo',
                                    subtitle: 'Upload a clear photo of your well-written, structured answer sheet.',
                                    photoDataUrl: _answerPhotoDataUrl,
                                    photoName: _answerPhotoName,
                                    onPick: () => _pickDonationPhoto(isQuestionPhoto: false),
                                    onClear: () => setState(() {
                                      _answerPhotoDataUrl = null;
                                      _answerPhotoName = null;
                                    }),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),
                    const Row(
                      children: [
                        Icon(Icons.keyboard_alt_outlined, size: 18, color: AppTheme.textPrimary),
                        SizedBox(width: 7),
                        Expanded(
                          child: Text(
                            'Option B: Type Question & Model Answer (Optional if Clear Photos Uploaded Above)',
                            style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                    TextField(
                      controller: _qNpCtrl,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: 'Question in Nepali (नेपालीमा प्रश्न)',
                        hintText: 'यहाँ नेपालीमा प्रश्न लेख्नुहोस् (वा माथि स्पष्ट फोटो अपलोड गर्नुहोस्)...',
                      ),
                    ),

                    const SizedBox(height: 14),
                    TextField(
                      controller: _qEnCtrl,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: 'Question in English (अंग्रेजीमा प्रश्न)',
                        hintText: 'Write the question in English here (or upload clear photo above)...',
                      ),
                    ),

                    const SizedBox(height: 14),
                    if (_qType == 'subjective') ...[
                      TextField(
                        controller: _ansNpCtrl,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          labelText: 'Model Answer in Nepali (नेपालीमा नमुना उत्तर)',
                          hintText: 'लोकसेवा परीक्षाको ढाँचामा बुँदागत नमुना उत्तर लेख्नुहोस् (वा माथि उत्तरको स्पष्ट फोटो अपलोड गर्नुहोस्)...',
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: _ansEnCtrl,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          labelText: 'Model Answer in English (Optional)',
                          hintText: 'Write structured model answer in English (or upload well-written answer photo above)...',
                        ),
                      ),
                    ] else ...[
                      if (isMobile) ...[
                        TextField(controller: _optACtrl, decoration: const InputDecoration(labelText: 'Option A *')),
                        const SizedBox(height: 10),
                        TextField(controller: _optBCtrl, decoration: const InputDecoration(labelText: 'Option B *')),
                        const SizedBox(height: 10),
                        TextField(controller: _optCCtrl, decoration: const InputDecoration(labelText: 'Option C *')),
                        const SizedBox(height: 10),
                        TextField(controller: _optDCtrl, decoration: const InputDecoration(labelText: 'Option D *')),
                      ] else ...[
                        Row(
                          children: [
                            Expanded(child: TextField(controller: _optACtrl, decoration: const InputDecoration(labelText: 'Option A *'))),
                            const SizedBox(width: 12),
                            Expanded(child: TextField(controller: _optBCtrl, decoration: const InputDecoration(labelText: 'Option B *'))),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(child: TextField(controller: _optCCtrl, decoration: const InputDecoration(labelText: 'Option C *'))),
                            const SizedBox(width: 12),
                            Expanded(child: TextField(controller: _optDCtrl, decoration: const InputDecoration(labelText: 'Option D *'))),
                          ],
                        ),
                      ],
                      const SizedBox(height: 14),
                      DropdownButtonFormField<int>(
                        value: _correctIdx,
                        decoration: const InputDecoration(labelText: 'Correct Option *'),
                        items: const [
                          DropdownMenuItem(value: 0, child: Text('Option A is Correct')),
                          DropdownMenuItem(value: 1, child: Text('Option B is Correct')),
                          DropdownMenuItem(value: 2, child: Text('Option C is Correct')),
                          DropdownMenuItem(value: 3, child: Text('Option D is Correct')),
                        ],
                        onChanged: (v) => setState(() => _correctIdx = v!),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: _expCtrl,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          labelText: 'Brief Explanation / Solution Note',
                          hintText: 'Explain why this option is correct...',
                        ),
                      ),
                    ],

                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: _submitting ? null : () => _submitDonation(targetExamId),
                        icon: _submitting
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                              )
                            : const Icon(Icons.cloud_upload_outlined, size: 18, color: Colors.white),
                        label: Text(
                          _submitting
                              ? 'Submitting Question & Answer for Verification...'
                              : 'Submit Question Donation (+रू 0.05 on Verification)',
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppTheme.iconRed,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── 3. MY DONATED QUESTIONS & VERIFICATION STATUS HISTORY ──
              const Text(
                'My Donated Questions & Verification History',
                style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
              ),
              const SizedBox(height: 10),
              if (_loadingDonations)
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(child: CircularProgressIndicator(color: AppTheme.iconRed, strokeWidth: 2)),
                )
              else if (_myDonations.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppTheme.divider),
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.volunteer_activism_outlined, size: 32, color: AppTheme.textMuted),
                      SizedBox(height: 8),
                      Text(
                        'No Questions Donated Yet',
                        style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w800, color: AppTheme.textPrimary),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Submit your first valid question (typed or clear photo) above for your enrolled exam course to start earning!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12.5, color: AppTheme.textMuted),
                      ),
                    ],
                  ),
                )
              else
                ..._myDonations.map((d) {
                  final status = (d['status'] ?? 'pending').toString();
                  final isApproved = status == 'approved';
                  final isRejected = status == 'rejected';
                  final qTitle = ((d['question_english']?.toString().isNotEmpty == true) ? d['question_english'] : (d['question_nepali'] ?? '')).toString();
                  final examId = (d['exam_id'] ?? 'rbb_it_5').toString();
                  final qType = (d['type'] ?? 'subjective').toString().toUpperCase();
                  final marks = d['marks'] ?? 5;
                  final qPhotoUrl = (d['question_photo_url'] ?? '').toString();
                  final aPhotoUrl = (d['answer_photo_url'] ?? '').toString();

                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isApproved ? AppTheme.iconRed.withOpacity(0.45) : AppTheme.divider,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 8,
                          runSpacing: 6,
                          alignment: WrapAlignment.spaceBetween,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF4F4F5),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    '$examId • $qType • ${marks}M',
                                    style: const TextStyle(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.w700,
                                      color: AppTheme.textPrimary,
                                    ),
                                  ),
                                ),
                                if (qPhotoUrl.isNotEmpty || aPhotoUrl.isNotEmpty)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                                    decoration: BoxDecoration(
                                      color: AppTheme.iconRedLight,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.photo_camera_outlined, size: 11, color: AppTheme.iconRed),
                                        SizedBox(width: 4),
                                        Text(
                                          'PHOTO ATTACHED',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w800,
                                            color: AppTheme.iconRedDark,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: isApproved
                                    ? AppTheme.iconRedLight
                                    : (isRejected ? const Color(0xFFF4F4F5) : const Color(0xFFFAFAFA)),
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: isApproved ? AppTheme.iconRed : AppTheme.divider,
                                ),
                              ),
                              child: Text(
                                isApproved
                                    ? '✓ VERIFIED & PUBLISHED (+रू 0.05)'
                                    : (isRejected ? '✕ REJECTED' : '⏳ PENDING ADMIN VERIFICATION'),
                                style: TextStyle(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w800,
                                  color: isApproved
                                      ? AppTheme.iconRedDark
                                      : (isRejected ? AppTheme.textMuted : AppTheme.textPrimary),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          qTitle,
                          style: const TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textPrimary,
                            height: 1.4,
                          ),
                        ),
                        if (qPhotoUrl.isNotEmpty || aPhotoUrl.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 6,
                            children: [
                              if (qPhotoUrl.isNotEmpty)
                                OutlinedButton.icon(
                                  onPressed: () => _showPhotoPreviewDialog('Uploaded Question Photo', qPhotoUrl),
                                  icon: const Icon(Icons.image_outlined, size: 14, color: AppTheme.iconRed),
                                  label: const Text(
                                    'View Question Photo',
                                    style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: AppTheme.iconRed),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                    side: const BorderSide(color: AppTheme.iconRed),
                                  ),
                                ),
                              if (aPhotoUrl.isNotEmpty)
                                OutlinedButton.icon(
                                  onPressed: () => _showPhotoPreviewDialog('Uploaded Well-Written Answer Photo', aPhotoUrl),
                                  icon: const Icon(Icons.fact_check_outlined, size: 14, color: AppTheme.textPrimary),
                                  label: const Text(
                                    'View Answer Photo',
                                    style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: AppTheme.textPrimary),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                    side: const BorderSide(color: AppTheme.divider),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  );
                }),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _DonationStatBox extends StatelessWidget {
  final String label;
  final String value;
  final String sub;
  final bool highlightRed;
  final double width;

  const _DonationStatBox({
    required this.label,
    required this.value,
    required this.sub,
    required this.highlightRed,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: highlightRed ? AppTheme.iconRedLight : const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: highlightRed ? AppTheme.iconRed : AppTheme.divider,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: highlightRed ? AppTheme.iconRedDark : AppTheme.textMuted,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: highlightRed ? AppTheme.iconRedDark : AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            sub,
            style: const TextStyle(fontSize: 10.5, color: AppTheme.textMuted),
          ),
        ],
      ),
    );
  }
}

