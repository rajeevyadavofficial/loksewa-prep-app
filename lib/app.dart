import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'data/repositories/providers.dart';
import 'features/landing/landing_page.dart';
import 'features/auth/auth_pages.dart';
import 'features/dashboard/dashboard_page.dart';
import 'features/subscription/subscription_page.dart';
import 'features/admin/admin_page.dart';

class LokSewaApp extends StatefulWidget {
  const LokSewaApp({super.key});

  @override
  State<LokSewaApp> createState() => _LokSewaAppState();
}

class _LokSewaAppState extends State<LokSewaApp> {
  late final GoRouter _router = GoRouter(
    routes: [
      GoRoute(path: AppConstants.routeHome, builder: (_, __) => const LandingPage()),
      GoRoute(path: AppConstants.routeLogin, builder: (_, __) => const LoginPage()),
      GoRoute(path: AppConstants.routeRegister, builder: (_, __) => const RegisterPage()),
      GoRoute(path: AppConstants.routeDashboard, builder: (_, __) => const DashboardPage()),
      GoRoute(path: AppConstants.routeSubscription, builder: (_, __) => const SubscriptionPage()),
      GoRoute(path: AppConstants.routeAdminLogin, builder: (_, __) => const AdminLoginPage()),
      GoRoute(path: AppConstants.routeAdmin, builder: (_, __) => const AdminPage()),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => QuestionProvider()),
        ChangeNotifierProvider(create: (_) => MockTestProvider()),
        ChangeNotifierProvider(create: (_) => StudyNotesProvider()),
      ],
      child: MaterialApp.router(
        title: AppConstants.appName,
        theme: AppTheme.lightTheme,
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
