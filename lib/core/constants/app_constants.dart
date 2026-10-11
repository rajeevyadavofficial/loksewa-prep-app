class AppConstants {
  // App Info
  static const String appName = 'LokSewa Prep';
  static const String appTagline = 'Nepal\'s #1 Loksewa Exam Preparation Platform';
  static const String appVersion = '1.0.0';

  // Node.js + MongoDB Backend API URL
  static const String apiBaseUrl = 'http://localhost:5000/api';

  // Exam Info
  static const String examName = 'Rastriya Banijya Bank (RBB)';
  static const String examPost = 'Senior Assistant (IT) - Level 5';

  // Subscription Plans
  static const String freePlanName = 'Free';
  static const String basicPlanName = 'Pro';
  static const String premiumPlanName = 'Pro';

  static const double basicPlanMonthlyPrice = 299; // NPR
  static const double premiumPlanMonthlyPrice = 299; // NPR
  static const double premiumPlanYearlyPrice = 2999; // NPR

  // Free plan limits
  static const int freeQuestionsLimit = 10;
  static const int freeMockTestsLimit = 1;

  // Routes
  static const String routeHome = '/';
  static const String routeLogin = '/login';
  static const String routeRegister = '/register';
  static const String routeDashboard = '/dashboard';
  static const String routeSyllabus = '/syllabus';
  static const String routeQuestions = '/questions';
  static const String routeQuestionDetail = '/questions/:id';
  static const String routeMockTest = '/mock-test';
  static const String routeSubscription = '/subscription';
  static const String routeAdmin = '/admin';
  static const String routeAdminLogin = '/admin/adminlogin';
  static const String routeProfile = '/profile';

  // SharedPrefs keys
  static const String prefIsLoggedIn = 'is_logged_in';
  static const String prefAuthToken = 'auth_jwt_token';
  static const String prefUserId = 'user_id';
  static const String prefUserName = 'user_name';
  static const String prefUserEmail = 'user_email';
  static const String prefUserPlan = 'user_plan';
  static const String prefIsAdmin = 'is_admin';
  static const String prefEnrolledExams = 'user_enrolled_exams';
  static const String prefProgress = 'user_progress';
}
