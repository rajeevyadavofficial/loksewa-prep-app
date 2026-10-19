import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';
import '../../core/constants/app_constants.dart';

// ─── Auth Provider (Connected to Node.js + MongoDB API) ──────
class AuthProvider extends ChangeNotifier {
  static const String _lsCandidateKey = 'loksewa_candidate_session_v1';
  static const String _lsAdminKey = 'loksewa_admin_session_v1';

  static const String _prefAdminLoggedIn = 'admin_is_logged_in';
  static const String _prefAdminToken = 'admin_jwt_token';
  static const String _prefAdminId = 'admin_user_id';
  static const String _prefAdminName = 'admin_user_name';
  static const String _prefAdminEmail = 'admin_user_email';

  AppUser? _user;
  String? _token;

  AppUser? _adminUser;
  String? _adminToken;

  bool _initializing = true;
  bool _loading = false;
  String? _error;

  /// Active user for Candidate screens (/dashboard, /subscription) — strictly Candidate session only.
  AppUser? get user => _user;
  AppUser? get candidateUser => _user;
  AppUser? get adminUser => _adminUser;

  String? get token => _token;
  String? get adminToken => _adminToken;

  bool get isLoggedIn => _user != null;
  bool get isCandidateLoggedIn => _user != null;
  bool get isAdminLoggedIn => _adminUser?.isAdmin == true && (_adminToken?.isNotEmpty ?? false);
  bool get initializing => _initializing;
  bool get loading => _loading;
  String? get error => _error;

  AuthProvider() {
    _restoreSyncFromLocalStorage();
    _restore();
  }

  DateTime? _parseExpiry(dynamic raw) {
    if (raw == null) return null;
    final str = raw.toString().trim();
    if (str.isEmpty) return null;
    return DateTime.tryParse(str);
  }

  void _restoreSyncFromLocalStorage() {
    try {
      final rawAdmin = html.window.localStorage[_lsAdminKey];
      if (rawAdmin != null && rawAdmin.isNotEmpty) {
        final map = jsonDecode(rawAdmin) as Map<String, dynamic>;
        final tok = map['token']?.toString() ?? '';
        if (tok.isNotEmpty) {
          _adminToken = tok;
          _adminUser = AppUser(
            uid: map['uid']?.toString() ?? 'usr_admin_01',
            name: map['name']?.toString() ?? 'Admin',
            email: map['email']?.toString() ?? 'admin@loksewa.com',
            plan: SubscriptionPlan.premium,
            planExpiresAt: _parseExpiry(map['planExpiresAt']),
            isAdmin: true,
            enrolledExams: List<String>.from(map['enrolledExams'] ?? const []),
          );
        }
      }
    } catch (_) {}

    try {
      final rawCandidate = html.window.localStorage[_lsCandidateKey];
      if (rawCandidate != null && rawCandidate.isNotEmpty) {
        final map = jsonDecode(rawCandidate) as Map<String, dynamic>;
        final tok = map['token']?.toString() ?? '';
        if (tok.isNotEmpty) {
          _token = tok;
          _user = AppUser(
            uid: map['uid']?.toString() ?? 'u-local',
            name: map['name']?.toString() ?? 'User',
            email: map['email']?.toString() ?? '',
            plan: _plan(map['plan']?.toString() ?? 'free'),
            planExpiresAt: _parseExpiry(map['planExpiresAt']),
            isAdmin: map['isAdmin'] == true,
            enrolledExams: List<String>.from(map['enrolledExams'] ?? const []),
          );
        }
      }
    } catch (_) {}

    if (_user != null || _adminUser != null) {
      _initializing = false;
    }
  }

  Future<void> _restore() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // 1. Restore Admin session if not already restored from localStorage
      if (_adminUser == null && (prefs.getBool(_prefAdminLoggedIn) ?? false)) {
        final admTok = prefs.getString(_prefAdminToken);
        if (admTok != null && admTok.isNotEmpty) {
          _adminToken = admTok;
          _adminUser = AppUser(
            uid: prefs.getString(_prefAdminId) ?? 'usr_admin_01',
            name: prefs.getString(_prefAdminName) ?? 'Admin',
            email: prefs.getString(_prefAdminEmail) ?? 'admin@loksewa.com',
            plan: SubscriptionPlan.premium,
            isAdmin: true,
          );
          _saveAdminToLocalStorage();
        }
      }

      // 2. Restore Candidate (or legacy Admin) session
      if (_user == null && (prefs.getBool(AppConstants.prefIsLoggedIn) ?? false)) {
        final savedToken = prefs.getString(AppConstants.prefAuthToken);
        final savedEnrolled = prefs.getStringList(AppConstants.prefEnrolledExams) ?? const [];
        final savedIsAdmin = prefs.getBool(AppConstants.prefIsAdmin) ?? false;
        final restoredUser = AppUser(
          uid: prefs.getString(AppConstants.prefUserId) ?? 'u-local',
          name: prefs.getString(AppConstants.prefUserName) ?? 'User',
          email: prefs.getString(AppConstants.prefUserEmail) ?? '',
          plan: _plan(prefs.getString(AppConstants.prefUserPlan) ?? 'free'),
          planExpiresAt: _parseExpiry(prefs.getString(AppConstants.prefPlanExpiresAt)),
          isAdmin: savedIsAdmin,
          enrolledExams: savedEnrolled,
        );
        if (savedIsAdmin) {
          _adminToken ??= savedToken;
          _adminUser ??= restoredUser;
          _saveAdminToLocalStorage();
        } else {
          _token = savedToken;
          _user = restoredUser;
          _saveCandidateToLocalStorage();
        }
      }

      if (_token != null && _token!.isNotEmpty) {
        _syncMe();
      }
      if (_adminToken != null && _adminToken!.isNotEmpty) {
        _syncAdminMe();
      }
    } catch (_) {
      // Ignore SharedPreferences read errors; localStorage fallback already loaded
    } finally {
      _initializing = false;
      notifyListeners();
    }
  }

  Future<void> _syncMe() async {
    if (_token == null || _token!.isEmpty) return;
    try {
      final res = await http.get(
        Uri.parse('${AppConstants.apiBaseUrl}/auth/me'),
        headers: {'Authorization': 'Bearer $_token'},
      ).timeout(const Duration(seconds: 10));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final u = data['user'];
        final enrolled = List<String>.from(u['enrolledExams'] ?? []);
        _user = AppUser(
          uid: u['uid'] ?? '',
          name: u['name'] ?? '',
          email: u['email'] ?? '',
          plan: _plan(u['plan'] ?? 'free'),
          planExpiresAt: _parseExpiry(u['planExpiresAt']),
          isAdmin: u['isAdmin'] == true,
          enrolledExams: enrolled,
        );
        await _saveSession();
        notifyListeners();
      }
    } catch (_) {
      // Offline / backend waking up fallback — keep existing session
    }
  }

  Future<void> _syncAdminMe() async {
    if (_adminToken == null || _adminToken!.isEmpty) return;
    try {
      final res = await http.get(
        Uri.parse('${AppConstants.apiBaseUrl}/auth/me'),
        headers: {'Authorization': 'Bearer $_adminToken'},
      ).timeout(const Duration(seconds: 10));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final u = data['user'];
        if (u['isAdmin'] == true) {
          _adminUser = AppUser(
            uid: u['uid'] ?? '',
            name: u['name'] ?? 'Admin',
            email: u['email'] ?? '',
            plan: _plan(u['plan'] ?? 'premium'),
            planExpiresAt: null,
            isAdmin: true,
            enrolledExams: List<String>.from(u['enrolledExams'] ?? []),
          );
          await _saveAdminSession();
          notifyListeners();
        }
      }
    } catch (_) {
      // Keep existing admin session
    }
  }

  SubscriptionPlan _plan(String s) {
    if (s == 'premium') return SubscriptionPlan.premium;
    if (s == 'basic') return SubscriptionPlan.basic;
    return SubscriptionPlan.free;
  }

  Future<String?> login(String email, String password, {bool forAdminPortal = false}) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final res = await http.post(
        Uri.parse('${AppConstants.apiBaseUrl}/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      ).timeout(const Duration(seconds: 25));

      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        final jwtToken = data['token']?.toString() ?? '';
        final u = data['user'];
        final isUserAdmin = u['isAdmin'] == true;
        final loggedInUser = AppUser(
          uid: u['uid'] ?? '',
          name: u['name'] ?? 'User',
          email: u['email'] ?? email,
          plan: _plan(u['plan'] ?? 'free'),
          planExpiresAt: isUserAdmin ? null : _parseExpiry(u['planExpiresAt']),
          isAdmin: isUserAdmin,
          enrolledExams: List<String>.from(u['enrolledExams'] ?? []),
        );

        if (forAdminPortal && !isUserAdmin) {
          _loading = false;
          _error = 'Access Denied: This portal is restricted to Administrators only.';
          notifyListeners();
          return _error;
        }
        if (!forAdminPortal && isUserAdmin) {
          _loading = false;
          _error = 'Admin accounts cannot sign in to Candidate View. Please use /admin/adminlogin.';
          notifyListeners();
          return _error;
        }

        if (isUserAdmin) {
          _adminToken = jwtToken;
          _adminUser = loggedInUser;
          await _saveAdminSession();
        } else {
          _token = jwtToken;
          _user = loggedInUser;
          await _saveSession();
        }

        _loading = false;
        notifyListeners();
        return null;
      } else {
        _loading = false;
        _error = data['error'] ?? 'Login failed';
        notifyListeners();
        return _error;
      }
    } catch (_) {
      _loading = false;
      _error = 'Server is waking up or connection is slow. Please try again in a few seconds.';
      notifyListeners();
      return _error;
    }
  }

  Future<String?> register(String name, String email, String password) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final res = await http.post(
        Uri.parse('${AppConstants.apiBaseUrl}/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      ).timeout(const Duration(seconds: 25));

      final data = jsonDecode(res.body);
      if (res.statusCode == 201 || res.statusCode == 200) {
        _token = data['token'];
        final u = data['user'];
        _user = AppUser(
          uid: u['uid'] ?? '',
          name: u['name'] ?? name,
          email: u['email'] ?? email,
          plan: _plan(u['plan'] ?? 'free'),
          planExpiresAt: _parseExpiry(u['planExpiresAt']),
          isAdmin: u['isAdmin'] == true,
          enrolledExams: List<String>.from(u['enrolledExams'] ?? []),
        );
        await _saveSession();
        _loading = false;
        notifyListeners();
        return null;
      } else {
        _loading = false;
        _error = data['error'] ?? 'Registration failed';
        notifyListeners();
        return _error;
      }
    } catch (_) {
      _loading = false;
      _error = 'Server is waking up or connection is slow. Please try again in a few seconds.';
      notifyListeners();
      return _error;
    }
  }

  void _saveCandidateToLocalStorage() {
    if (_user == null) return;
    try {
      html.window.localStorage[_lsCandidateKey] = jsonEncode({
        'token': _token ?? '',
        'uid': _user!.uid,
        'name': _user!.name,
        'email': _user!.email,
        'plan': _user!.plan.name,
        'planExpiresAt': _user!.planExpiresAt?.toIso8601String(),
        'isAdmin': _user!.isAdmin,
        'enrolledExams': _user!.enrolledExams,
      });
    } catch (_) {}
  }

  void _saveAdminToLocalStorage() {
    if (_adminUser == null) return;
    try {
      html.window.localStorage[_lsAdminKey] = jsonEncode({
        'token': _adminToken ?? '',
        'uid': _adminUser!.uid,
        'name': _adminUser!.name,
        'email': _adminUser!.email,
        'plan': _adminUser!.plan.name,
        'planExpiresAt': null,
        'isAdmin': true,
        'enrolledExams': _adminUser!.enrolledExams,
      });
    } catch (_) {}
  }

  Future<void> _saveSession() async {
    if (_user == null) return;
    _saveCandidateToLocalStorage();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(AppConstants.prefIsLoggedIn, true);
      await prefs.setString(AppConstants.prefAuthToken, _token ?? '');
      await prefs.setString(AppConstants.prefUserId, _user!.uid);
      await prefs.setString(AppConstants.prefUserName, _user!.name);
      await prefs.setString(AppConstants.prefUserEmail, _user!.email);
      await prefs.setString(AppConstants.prefUserPlan, _user!.plan.name);
      if (_user!.planExpiresAt != null) {
        await prefs.setString(AppConstants.prefPlanExpiresAt, _user!.planExpiresAt!.toIso8601String());
      } else {
        await prefs.remove(AppConstants.prefPlanExpiresAt);
      }
      await prefs.setBool(AppConstants.prefIsAdmin, _user!.isAdmin);
      await prefs.setStringList(AppConstants.prefEnrolledExams, _user!.enrolledExams);
    } catch (_) {}
  }

  Future<void> _saveAdminSession() async {
    if (_adminUser == null) return;
    _saveAdminToLocalStorage();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_prefAdminLoggedIn, true);
      await prefs.setString(_prefAdminToken, _adminToken ?? '');
      await prefs.setString(_prefAdminId, _adminUser!.uid);
      await prefs.setString(_prefAdminName, _adminUser!.name);
      await prefs.setString(_prefAdminEmail, _adminUser!.email);
    } catch (_) {}
  }

  /// Logs out the Candidate session ONLY (does not log out Admin from /admin).
  Future<void> logout() async {
    _user = null;
    _token = null;
    try {
      html.window.localStorage.remove(_lsCandidateKey);
    } catch (_) {}
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(AppConstants.prefIsLoggedIn);
      await prefs.remove(AppConstants.prefAuthToken);
      await prefs.remove(AppConstants.prefUserId);
      await prefs.remove(AppConstants.prefUserName);
      await prefs.remove(AppConstants.prefUserEmail);
      await prefs.remove(AppConstants.prefUserPlan);
      await prefs.remove(AppConstants.prefPlanExpiresAt);
      await prefs.remove(AppConstants.prefIsAdmin);
      await prefs.remove(AppConstants.prefEnrolledExams);
    } catch (_) {}
    notifyListeners();
  }

  /// Explicitly logs out the Admin session from /admin.
  Future<void> logoutAdmin() async {
    _adminUser = null;
    _adminToken = null;
    try {
      html.window.localStorage.remove(_lsAdminKey);
    } catch (_) {}
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_prefAdminLoggedIn);
      await prefs.remove(_prefAdminToken);
      await prefs.remove(_prefAdminId);
      await prefs.remove(_prefAdminName);
      await prefs.remove(_prefAdminEmail);
    } catch (_) {}
    notifyListeners();
  }

  Future<bool> enrollInExam(String examId, {String action = 'enroll'}) async {
    final activeUser = user;
    final activeToken = token;
    if (activeUser == null) return false;
    final current = List<String>.from(activeUser.enrolledExams);
    if (action == 'unenroll') {
      current.remove(examId);
    } else if (action == 'set_single') {
      current
        ..clear()
        ..add(examId);
    } else {
      if (!current.contains(examId)) current.add(examId);
    }
    if (_user != null) {
      _user = _user!.copyWith(enrolledExams: current);
      await _saveSession();
    } else if (_adminUser != null) {
      _adminUser = _adminUser!.copyWith(enrolledExams: current);
      await _saveAdminSession();
    }
    notifyListeners();

    try {
      if (activeToken != null && activeToken.isNotEmpty) {
        final res = await http.post(
          Uri.parse('${AppConstants.apiBaseUrl}/auth/enroll'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $activeToken',
          },
          body: jsonEncode({'examId': examId, 'action': action}),
        ).timeout(const Duration(seconds: 6));
        if (res.statusCode == 200) {
          final data = jsonDecode(res.body);
          if (data['user'] != null) {
            final u = data['user'];
            final updatedEnrolled = List<String>.from(u['enrolledExams'] ?? current);
            if (_user != null) {
              _user = _user!.copyWith(enrolledExams: updatedEnrolled);
              await _saveSession();
            } else if (_adminUser != null) {
              _adminUser = _adminUser!.copyWith(enrolledExams: updatedEnrolled);
              await _saveAdminSession();
            }
            notifyListeners();
          }
          return true;
        }
      }
    } catch (_) {}
    return true;
  }

  Future<bool> upgradePlan(
    SubscriptionPlan plan, {
    String method = 'esewa',
    String transactionRef = '',
  }) async {
    final activeUser = user;
    final activeToken = token;
    if (activeUser == null) return false;
    try {
      if (activeToken != null && activeToken.isNotEmpty) {
        final res = await http.post(
          Uri.parse('${AppConstants.apiBaseUrl}/auth/upgrade'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $activeToken',
          },
          body: jsonEncode({
            'plan': plan.name,
            'method': method,
            'transactionRef': transactionRef,
          }),
        ).timeout(const Duration(seconds: 6));
        if (res.statusCode == 200) {
          await _syncMe();
          return true;
        }
      }
    } catch (_) {}
    return false;
  }

  Future<void> refreshUserProfile() async {
    await _syncMe();
    await _syncAdminMe();
  }
}

// ─── Question & Exam Provider (Connected to Node.js + MongoDB API) ──
class QuestionProvider extends ChangeNotifier {
  List<ExamCourse> _exams = [];
  List<Question> _all = [];
  List<Question> _filtered = [];
  AppSettings _settings = const AppSettings();
  bool _loading = false;
  bool _loadedFromBackend = false;
  String _selectedExamId = 'rbb_it_5';
  String _searchQuery = '';
  PaperType? _paperFilter;
  SectionType? _sectionFilter;
  int? _unitFilter;
  QuestionType? _typeFilter;

  List<ExamCourse> get exams => _exams;
  List<Question> get allQuestions => _all;
  List<Question> get questions => _filtered;
  AppSettings get settings => _settings;
  bool get loading => _loading;
  bool get loadedFromBackend => _loadedFromBackend;
  String get selectedExamId => _selectedExamId;
  String get searchQuery => _searchQuery;
  PaperType? get paperFilter => _paperFilter;
  SectionType? get sectionFilter => _sectionFilter;
  int? get unitFilter => _unitFilter;
  QuestionType? get typeFilter => _typeFilter;

  ExamCourse? get selectedExam {
    if (_exams.isEmpty) return null;
    try {
      return _exams.firstWhere((e) => e.id == _selectedExamId);
    } catch (_) {
      return _exams.first;
    }
  }

  void selectExam(String examId) {
    _selectedExamId = examId;
    _paperFilter = null;
    _sectionFilter = null;
    _unitFilter = null;
    _typeFilter = null;
    _applyFilters();
  }

  void ensureEnrolledExamSelected(List<String> enrolledExams) {
    if (enrolledExams.isEmpty) return;
    if (!enrolledExams.contains(_selectedExamId)) {
      _selectedExamId = enrolledExams.first;
      _paperFilter = null;
      _sectionFilter = null;
      _unitFilter = null;
      _typeFilter = null;
      _applyFilters();
    }
  }

  int countForExam(String examId) {
    return _all.where((q) => q.examId == examId).length;
  }

  static const String _prefSettingsKey = 'loksewa_app_settings_v1';

  Future<void> _saveSettingsToPrefs(AppSettings s) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefSettingsKey, jsonEncode(s.toJson()));
    } catch (_) {}
  }

  Future<AppSettings> fetchSettingsFromBackend() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cached = prefs.getString(_prefSettingsKey);
      if (cached != null && cached.isNotEmpty) {
        _settings = AppSettings.fromJson(jsonDecode(cached) as Map<String, dynamic>);
        notifyListeners();
      }
      final setRes = await http
          .get(Uri.parse('${AppConstants.apiBaseUrl}/settings'))
          .timeout(const Duration(seconds: 10));
      if (setRes.statusCode == 200) {
        final Map<String, dynamic> sBody = jsonDecode(setRes.body);
        if (sBody['settings'] != null) {
          _settings = AppSettings.fromJson(sBody['settings'] as Map<String, dynamic>);
          await _saveSettingsToPrefs(_settings);
          notifyListeners();
        }
      }
    } catch (_) {}
    return _settings;
  }

  // ── Pagination State (10 questions at a time) ──────────────────────
  List<Question> _pagedQuestions = [];
  int _pagedTotal = 0;
  int _pagedPage = 1;
  int _pagedTotalPages = 1;
  bool _pagedLoading = false;

  List<Question> get pagedQuestions => _pagedQuestions;
  int get pagedTotal => _pagedTotal;
  int get pagedPage => _pagedPage;
  int get pagedTotalPages => _pagedTotalPages;
  bool get pagedLoading => _pagedLoading;

  Future<void> fetchPagedQuestions({
    required String examId,
    required PaperType paper,
    QuestionType? type,
    SectionType? section,
    String? query,
    int page = 1,
    int limit = 10,
  }) async {
    _pagedLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(AppConstants.prefAuthToken) ?? '';
      final headers = <String, String>{'Content-Type': 'application/json'};
      if (token.isNotEmpty) headers['Authorization'] = 'Bearer $token';

      final pStr = paper == PaperType.paper1 ? 'paper1' : 'paper2';
      final tStr = type == QuestionType.mcq ? 'mcq' : (type == QuestionType.subjective ? 'subjective' : '');
      final sStr = section == SectionType.sectionA ? 'sectionA' : (section == SectionType.sectionB ? 'sectionB' : '');

      final queryParams = <String, String>{
        'exam_id': examId,
        'paper': pStr,
        'page': '$page',
        'limit': '$limit',
      };
      if (tStr.isNotEmpty) queryParams['type'] = tStr;
      if (sStr.isNotEmpty) queryParams['section'] = sStr;
      if (query != null && query.trim().isNotEmpty) queryParams['search'] = query.trim();

      final uri = Uri.parse('${AppConstants.apiBaseUrl}/questions').replace(queryParameters: queryParams);
      final res = await http.get(uri, headers: headers).timeout(const Duration(seconds: 12));

      if (res.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(res.body);
        final List<dynamic> list = body['questions'] ?? [];
        _pagedQuestions = list.map((e) => Question.fromJson(e as Map<String, dynamic>)).toList();
        _pagedTotal = body['total'] is int ? body['total'] : (int.tryParse('${body['total']}') ?? _pagedQuestions.length);
        _pagedPage = body['page'] is int ? body['page'] : page;
        _pagedTotalPages = body['totalPages'] is int ? body['totalPages'] : ((_pagedTotal / limit).ceil());
        if (_pagedTotalPages < 1) _pagedTotalPages = 1;
        _pagedLoading = false;
        notifyListeners();
        return;
      }
    } catch (e) {
      debugPrint('fetchPagedQuestions backend fallback: $e');
    }

    // Fallback: If offline or API fails, slice from local _all array
    if (_all.isEmpty) {
      try {
        final jsonStr = await rootBundle.loadString('assets/data/questions.json');
        final List<dynamic> decoded = jsonDecode(jsonStr);
        _all = decoded.map((e) => Question.fromJson(e as Map<String, dynamic>)).toList();
      } catch (_) {}
    }

    final filtered = _all.where((q) {
      if (examId != 'all' && q.examId != examId) return false;
      if (q.paper != paper) return false;
      if (type != null && q.type != type) return false;
      if (section != null && q.section != section) return false;
      if (query != null && query.trim().isNotEmpty) {
        final s = query.trim().toLowerCase();
        if (!q.questionNepali.toLowerCase().contains(s) &&
            !q.questionEnglish.toLowerCase().contains(s) &&
            !q.unitTitle.toLowerCase().contains(s)) return false;
      }
      return true;
    }).toList();

    _pagedTotal = filtered.length;
    _pagedTotalPages = (_pagedTotal / limit).ceil();
    if (_pagedTotalPages < 1) _pagedTotalPages = 1;
    final clampedPage = page.clamp(1, _pagedTotalPages);
    _pagedPage = clampedPage;
    final start = (clampedPage - 1) * limit;
    _pagedQuestions = filtered.skip(start).take(limit).toList();
    _pagedLoading = false;
    notifyListeners();
  }

  Future<void> loadAll({bool forceRefresh = false}) async {
    // Always ensure settings are fetched & cached independently
    fetchSettingsFromBackend();

    if (_exams.isNotEmpty && _all.isNotEmpty && !forceRefresh) return;
    _loading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(AppConstants.prefAuthToken) ?? '';
      final headers = <String, String>{'Content-Type': 'application/json'};
      if (token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }

      // Fetch exams list (lightweight, ~2KB)
      final examRes = await http
          .get(Uri.parse('${AppConstants.apiBaseUrl}/exams'), headers: headers)
          .timeout(const Duration(seconds: 15));

      if (examRes.statusCode == 200) {
        final Map<String, dynamic> eBody = jsonDecode(examRes.body);
        final List<dynamic> eList = eBody['exams'] ?? [];
        _exams = eList.map((e) => ExamCourse.fromJson(e as Map<String, dynamic>)).toList();
      }
    } catch (_) {
      try {
        final examStr = await rootBundle.loadString('assets/data/exams.json');
        final List<dynamic> eDecoded = jsonDecode(examStr);
        _exams = eDecoded.map((e) => ExamCourse.fromJson(e as Map<String, dynamic>)).toList();
      } catch (_) {}
    }

    // Always load local bundled questions into _all for offline quiz/practice/fallback
    if (_all.isEmpty || forceRefresh) {
      try {
        final jsonStr = await rootBundle.loadString('assets/data/questions.json');
        final List<dynamic> decoded = jsonDecode(jsonStr);
        if (decoded.isNotEmpty) {
          _all = decoded.map((e) => Question.fromJson(e as Map<String, dynamic>)).toList();
        } else {
          _all = _buildQuestions();
        }
      } catch (_) {
        _all = _buildQuestions();
      }
    }

    _applyFilters();
    _loading = false;
    notifyListeners();
  }

  Future<bool> addExamToMongo(Map<String, dynamic> examData, String token) async {
    try {
      final res = await http.post(
        Uri.parse('${AppConstants.apiBaseUrl}/exams'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(examData),
      );
      if (res.statusCode == 201) {
        await loadAll(forceRefresh: true);
        return true;
      }
    } catch (_) {}
    return false;
  }

  Future<bool> toggleExamComingSoon(String examId, bool isComingSoon, String token) async {
    try {
      final res = await http.put(
        Uri.parse('${AppConstants.apiBaseUrl}/exams/$examId/status'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'is_coming_soon': isComingSoon}),
      );
      if (res.statusCode == 200) {
        await loadAll(forceRefresh: true);
        return true;
      }
    } catch (_) {}
    return false;
  }

  Future<bool> deleteExamFromMongo(String examId, String token) async {
    try {
      final res = await http.delete(
        Uri.parse('${AppConstants.apiBaseUrl}/exams/$examId'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (res.statusCode == 200) {
        await loadAll(forceRefresh: true);
        return true;
      }
    } catch (_) {}
    return false;
  }

  Future<bool> updateExamInMongo(String examId, Map<String, dynamic> examData, String token) async {
    try {
      final res = await http.post(
        Uri.parse('${AppConstants.apiBaseUrl}/exams'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(examData),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        await loadAll(forceRefresh: true);
        return true;
      }
    } catch (_) {}
    return false;
  }

  Future<bool> addQuestionToMongo(Map<String, dynamic> qData, String token) async {
    try {
      final res = await http.post(
        Uri.parse('${AppConstants.apiBaseUrl}/questions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(qData),
      );
      if (res.statusCode == 201) {
        await loadAll(forceRefresh: true);
        return true;
      }
    } catch (_) {}
    return false;
  }

  Future<bool> updateQuestionInMongo(String questionId, Map<String, dynamic> qData, String token) async {
    try {
      final res = await http.put(
        Uri.parse('${AppConstants.apiBaseUrl}/questions/$questionId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(qData),
      );
      if (res.statusCode == 200) {
        await loadAll(forceRefresh: true);
        return true;
      }
    } catch (_) {}
    return false;
  }

  Future<bool> deleteQuestionFromMongo(String questionId, String token) async {
    try {
      final res = await http.delete(
        Uri.parse('${AppConstants.apiBaseUrl}/questions/$questionId'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (res.statusCode == 200) {
        await loadAll(forceRefresh: true);
        return true;
      }
    } catch (_) {}
    return false;
  }

  Future<bool> updateSettingsToMongo(AppSettings newSettings, String token) async {
    try {
      final res = await http.put(
        Uri.parse('${AppConstants.apiBaseUrl}/settings'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(newSettings.toJson()),
      );
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        if (data['settings'] != null) {
          _settings = AppSettings.fromJson(data['settings'] as Map<String, dynamic>);
        } else {
          _settings = newSettings;
        }
        await _saveSettingsToPrefs(_settings);
        notifyListeners();
        return true;
      }
    } catch (_) {}
    _settings = newSettings;
    await _saveSettingsToPrefs(_settings);
    notifyListeners();
    return false;
  }

  Future<String?> uploadImageToCloudinary({
    required String imageDataUrl,
    String? targetField,
    required String token,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('${AppConstants.apiBaseUrl}/settings/upload-image'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'imageDataUrl': imageDataUrl,
          'targetField': targetField,
          'folder': 'loksewa_prep',
        }),
      );
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final uploadedUrl = data['url'] as String?;
        if (data['settings'] != null) {
          _settings = AppSettings.fromJson(data['settings'] as Map<String, dynamic>);
        } else if (uploadedUrl != null && uploadedUrl.isNotEmpty) {
          final currentJson = _settings.toJson();
          if (targetField == 'paymentQrUrl' || targetField == 'payment_qr_url') {
            currentJson['paymentQrUrl'] = uploadedUrl;
          } else if (targetField == 'whatsappQrUrl' || targetField == 'whatsapp_qr_url') {
            currentJson['whatsappQrUrl'] = uploadedUrl;
          }
          _settings = AppSettings.fromJson(currentJson);
        }
        await _saveSettingsToPrefs(_settings);
        notifyListeners();
        return uploadedUrl;
      }
    } catch (_) {}
    return null;
  }

  void setFilters({
    PaperType? paper,
    SectionType? section,
    int? unit,
    QuestionType? type,
    String? query,
    bool clearPaper = false,
    bool clearSection = false,
    bool clearUnit = false,
    bool clearType = false,
  }) {
    if (clearPaper) {
      _paperFilter = null;
    } else if (paper != null) {
      _paperFilter = paper;
    }

    if (clearSection) {
      _sectionFilter = null;
    } else if (section != null) {
      _sectionFilter = section;
    }

    if (clearUnit) {
      _unitFilter = null;
    } else if (unit != null) {
      _unitFilter = unit;
    }

    if (clearType) {
      _typeFilter = null;
    } else if (type != null) {
      _typeFilter = type;
    }

    if (query != null) _searchQuery = query;

    _applyFilters();
  }

  void clearFilters() {
    _paperFilter = null;
    _sectionFilter = null;
    _unitFilter = null;
    _typeFilter = null;
    _searchQuery = '';
    _applyFilters();
  }

  void _applyFilters() {
    _filtered = _all.where((q) {
      if (_selectedExamId != 'all' && q.examId != _selectedExamId) return false;
      if (_paperFilter != null && q.paper != _paperFilter) return false;
      if (_sectionFilter != null && q.section != _sectionFilter) return false;
      if (_unitFilter != null && q.unitNumber != _unitFilter) return false;
      if (_typeFilter != null && q.type != _typeFilter) return false;
      if (_searchQuery.isNotEmpty) {
        final s = _searchQuery.toLowerCase();
        if (!q.questionNepali.toLowerCase().contains(s) &&
            !q.questionEnglish.toLowerCase().contains(s) &&
            !q.unitTitle.toLowerCase().contains(s)) return false;
      }
      return true;
    }).toList();
    notifyListeners();
  }

  List<Question> getMCQs({bool premiumAllowed = false, List<String> enrolledExams = const []}) {
    if (enrolledExams.isNotEmpty && !enrolledExams.contains(_selectedExamId)) {
      return [];
    }
    final examMcqs = _all.where((q) =>
      q.examId == _selectedExamId &&
      q.type == QuestionType.mcq &&
      (premiumAllowed || !q.isPremium)
    ).toList();
    return examMcqs;
  }

  List<Question> getAccessible(
    SubscriptionPlan plan, {
    List<String> enrolledExams = const [],
    bool isAdmin = false,
  }) {
    if (isAdmin) return _filtered;
    if (enrolledExams.isEmpty) return [];
    if (!enrolledExams.contains(_selectedExamId)) return [];
    return _filtered.where((q) => enrolledExams.contains(q.examId)).toList();
  }

  List<Question> _buildQuestions() {
    // Comprehensive set of past questions from the RBB study material
    return [
      // ── PAPER I SECTION A — UNIT 1: Banking & Financial System ──
      const Question(
        id: 'p1a_u1_q1', paper: PaperType.paper1, section: SectionType.sectionA,
        unitNumber: 1, unitTitle: 'Banking & Financial System (बैंकिङ तथा वित्तीय प्रणाली)',
        marks: 10, type: QuestionType.subjective, yearsAsked: ['2075', '2078', '2080'],
        questionNepali: 'नेपालको बैंकिङ प्रणालीको विकास क्रम उल्लेख गर्नुहोस् र हालको अवस्थाको विश्लेषण गर्नुहोस्।',
        questionEnglish: 'Describe the chronological development of Nepal\'s banking system and analyze its current state.',
        answerNepali: '''**परिचय (Introduction):**
नेपालको बैंकिङ प्रणालीको इतिहास एक शताब्दीभन्दा बढी पुरानो छ। आधुनिक बैंकिङको शुरुवात वि.सं. १९९४ सालमा नेपाल बैंक लिमिटेडको स्थापनासँगै भयो।

**विकास क्रम (Development Chronology):**

| कालखण्ड | महत्त्वपूर्ण घटना |
|---|---|
| वि.सं. १९९४ (1937) | नेपाल बैंक लिमिटेडको स्थापना — पहिलो व्यावसायिक बैंक |
| वि.सं. २०१३ (1956) | नेपाल राष्ट्र बैंकको स्थापना — केन्द्रीय बैंक |
| वि.सं. २०१९ (1962) | राष्ट्रिय वाणिज्य बैंकको स्थापना |
| वि.सं. २०४१ (1984) | उदारीकरण नीति — निजी बैंकलाई अनुमति |
| वि.सं. २०४३ (1986) | नेपाल इन्डोसुएज बैंक (हालको नेपाल इन्भेष्टमेन्ट बैंक) — पहिलो संयुक्त उद्यम बैंक |
| वि.सं. २०४८ (1991) | आर्थिक उदारीकरण — विदेशी लगानी खुलाइयो |
| वि.सं. २०७२–२०७५ | NRB को मर्जर नीति — बैंक तथा वित्तीय संस्था एकीकरण |

**हालको संरचना:**
- **वर्ग 'क'**: वाणिज्य बैंक (२० वटा)
- **वर्ग 'ख'**: विकास बैंक
- **वर्ग 'ग'**: वित्त कम्पनी
- **वर्ग 'घ'**: लघुवित्त वित्तीय संस्था

**निष्कर्ष (Conclusion):**
नेपालको बैंकिङ प्रणाली क्रमशः सुदृढ भइरहेको छ। डिजिटल बैंकिङ, मोबाइल पेमेन्ट र वित्तीय समावेशीकरणमा उल्लेखनीय प्रगति भएको छ। तथापि ग्रामीण क्षेत्रमा पहुँच र सुशासन थप सुधारको आवश्यकता छ।''',
        answerEnglish: '''**Introduction:**
Nepal's banking history spans over a century. Modern banking commenced with the establishment of Nepal Bank Limited in 1937 BS (1937 AD), followed by the founding of Nepal Rastra Bank (NRB) as the central bank in 1956 AD.

**Development Chronology:**

| Period | Key Event |
|---|---|
| 1937 AD | Nepal Bank Limited established — First commercial bank |
| 1956 AD | Nepal Rastra Bank established — Central bank |
| 1962 AD | Rastriya Banijya Bank established — State-owned commercial bank |
| 1984 AD | Liberalization policy — Private banks permitted |
| 1986 AD | Nepal Indosuez Bank (now Nepal Investment Bank) — First joint venture bank |
| 1991 AD | Economic liberalization — Foreign investment opened |
| 2015–2018 AD | NRB merger policy — Consolidation of BFIs |

**Current Structure (As per NRB):**
- **Class 'A'**: Commercial Banks (20)
- **Class 'B'**: Development Banks
- **Class 'C'**: Finance Companies
- **Class 'D'**: Microfinance Financial Institutions

**Conclusion:**
Nepal's banking system has progressively strengthened. Significant strides have been made in digital banking, mobile payments, and financial inclusion. However, rural outreach and good governance require further improvement.''',
        isPremium: false,
      ),
      const Question(
        id: 'p1a_u1_q2', paper: PaperType.paper1, section: SectionType.sectionA,
        unitNumber: 1, unitTitle: 'Banking & Financial System (बैंकिङ तथा वित्तीय प्रणाली)',
        marks: 5, type: QuestionType.subjective, yearsAsked: ['2076', '2079'],
        questionNepali: 'केन्द्रीय बैंकका कार्यहरू उल्लेख गर्नुहोस्।',
        questionEnglish: 'Describe the functions of a Central Bank.',
        answerNepali: '''**परिचय:** नेपाल राष्ट्र बैंक नेपालको केन्द्रीय बैंक हो जसको स्थापना वि.सं. २०१३ मा भएको हो।

**मुख्य कार्यहरू:**
१. **मुद्रा निर्गमन** — नोट तथा सिक्का जारी गर्ने एकाधिकार
२. **सरकारको बैंकर** — सरकारी खाता सञ्चालन, ऋण व्यवस्थापन
३. **बैंकहरूको बैंकर** — अन्तिम ऋणदाता (Lender of Last Resort)
४. **विदेशी मुद्रा व्यवस्थापन** — विनिमय दर नियन्त्रण
५. **मौद्रिक नीति** — ब्याजदर, नगद मौज्दात अनुपात (CRR) निर्धारण
६. **बैंकिङ नियमन** — BFI को अनुमति, निरीक्षण, नियमन

**निष्कर्ष:** केन्द्रीय बैंकले देशको समग्र आर्थिक स्थायित्व कायम राख्न महत्त्वपूर्ण भूमिका खेल्दछ।''',
        answerEnglish: '''**Introduction:** Nepal Rastra Bank (NRB) is Nepal's central bank, established in 1956 AD under the Nepal Rastra Bank Act.

**Key Functions:**
1. **Currency Issuance** — Monopoly right to issue notes and coins
2. **Banker to Government** — Manages government accounts and public debt
3. **Banker's Bank** — Acts as Lender of Last Resort for BFIs
4. **Foreign Exchange Management** — Controls exchange rates and reserves
5. **Monetary Policy** — Sets interest rates, CRR, SLR to control inflation
6. **Banking Regulation** — Licensing, inspection, and supervision of all BFIs

**Conclusion:** The central bank plays a vital role in maintaining macroeconomic stability, price stability, and public confidence in the financial system.''',
        isPremium: false,
      ),
      const Question(
        id: 'p1a_u1_q3', paper: PaperType.paper1, section: SectionType.sectionA,
        unitNumber: 1, unitTitle: 'Banking & Financial System (बैंकिङ तथा वित्तीय प्रणाली)',
        marks: 10, type: QuestionType.subjective, yearsAsked: ['2073', '2077', '2081'],
        questionNepali: 'राष्ट्रिय वाणिज्य बैंकको स्थापना, उद्देश्य र वर्तमान अवस्था वर्णन गर्नुहोस्।',
        questionEnglish: 'Describe the establishment, objectives, and current status of Rastriya Banijya Bank (RBB).',
        answerNepali: '''**परिचय:**
राष्ट्रिय वाणिज्य बैंक (RBB) नेपालको सबैभन्दा पुरानो र ठूलो सरकारी स्वामित्वको वाणिज्य बैंक हो।

**स्थापना:**
- स्थापना मिति: वि.सं. २०२३ साल (1966 AD)
- कानुनी आधार: वाणिज्य बैंक ऐन, २०२३
- स्वामित्व: नेपाल सरकार (१००%)

**उद्देश्यहरू:**
- आर्थिक विकासमा सहयोग
- ग्रामीण क्षेत्रमा बैंकिङ सेवा विस्तार
- साना तथा मझौला उद्यमलाई कर्जा प्रवाह
- सरकारी कोषको व्यवस्थापन

**वर्तमान अवस्था:**
- शाखा सञ्जाल: नेपालभर ३०० भन्दा बढी शाखाहरू
- कर्मचारी: करिब ५,०००+
- डिजिटल सेवाहरू: मोबाइल बैंकिङ, इन्टरनेट बैंकिङ, RTGS
- ISO प्रमाणीकरण प्राप्त

**चुनौतीहरू:**
- निजी क्षेत्रसँग प्रतिस्पर्धा
- NPA (Non-Performing Assets) व्यवस्थापन
- डिजिटल परिवर्तन

**निष्कर्ष:**
RBB सरकारी बैंकको रूपमा देशको वित्तीय प्रणालीमा महत्त्वपूर्ण भूमिका निर्वाह गरिरहेको छ र आधुनिकीकरणतर्फ अग्रसर छ।''',
        answerEnglish: '''**Introduction:**
Rastriya Banijya Bank (RBB) is Nepal's oldest and largest government-owned commercial bank, playing a central role in the national economy.

**Establishment:**
- Founded: 2023 BS (1966 AD)
- Legal Basis: Commercial Bank Act, 2023 BS
- Ownership: Government of Nepal (100%)

**Objectives:**
- Support economic development
- Extend banking services to rural areas
- Channel credit to SMEs
- Manage government treasury operations

**Current Status:**
- Branch Network: 300+ branches nationwide
- Staff: Approximately 5,000+
- Digital Services: Mobile banking, Internet banking, RTGS, QR payments
- ISO Certified operations

**Challenges:**
- Competition from private sector banks
- Non-Performing Asset (NPA) management
- Digital transformation requirements

**Conclusion:**
RBB continues to serve as a vital pillar of Nepal's financial system. As a state-owned bank, its mandate extends beyond profit — to national financial inclusion and public service — making its modernization both urgent and significant.''',
        isPremium: false,
      ),
      // ── PAPER I SECTION A — UNIT 2: Organizational Management ──
      const Question(
        id: 'p1a_u2_q1', paper: PaperType.paper1, section: SectionType.sectionA,
        unitNumber: 2, unitTitle: 'Organizational Management (संगठनात्मक व्यवस्थापन)',
        marks: 10, type: QuestionType.subjective, yearsAsked: ['2074', '2078', '2080'],
        questionNepali: 'व्यवस्थापनका कार्यहरू (Functions of Management) वर्णन गर्नुहोस्।',
        questionEnglish: 'Describe the functions of management with relevant examples.',
        answerNepali: '''**परिचय:**
व्यवस्थापन भनेको संगठनका उद्देश्य हासिल गर्नका लागि मानव तथा भौतिक साधनहरूको प्रभावकारी उपयोग गर्ने कला र विज्ञान हो।

**व्यवस्थापनका प्रमुख कार्यहरू (POLC):**

| कार्य | विवरण |
|---|---|
| **योजना (Planning)** | लक्ष्य निर्धारण, रणनीति तर्जुमा |
| **संगठन (Organizing)** | कार्य विभाजन, अधिकार प्रत्यायोजन |
| **नेतृत्व (Leading)** | प्रेरणा, संचार, नेतृत्व शैली |
| **नियन्त्रण (Controlling)** | कार्यसम्पादन मापन, सुधारात्मक कदम |

**विस्तृत विवरण:**
१. **योजना**: संगठनले के, कहिले, कसरी हासिल गर्ने भन्ने निर्णय गर्ने प्रक्रिया।
२. **संगठन**: कार्यहरूलाई विभाजन गरी उचित व्यक्तिलाई जिम्मेवारी दिने।
३. **नेतृत्व**: कर्मचारीलाई प्रेरित गरी उत्पादकत्व वृद्धि गर्ने।
४. **नियन्त्रण**: पूर्वनिर्धारित मानकसँग वास्तविक कार्यसम्पादनको तुलना।

**निष्कर्ष:**
बैंकिङ क्षेत्रमा यी सबै व्यवस्थापकीय कार्यहरूको प्रभावकारी कार्यान्वयनले संस्थागत सुशासन र ग्राहक सन्तुष्टि सुनिश्चित गर्दछ।''',
        answerEnglish: '''**Introduction:**
Management is the art and science of effectively utilizing human and material resources to achieve organizational goals through coordinated effort.

**Key Functions of Management (POLC Framework):**

| Function | Description |
|---|---|
| **Planning** | Setting objectives and formulating strategies |
| **Organizing** | Dividing tasks and delegating authority |
| **Leading** | Motivating, communicating, and directing staff |
| **Controlling** | Measuring performance and taking corrective action |

**Detailed Explanation:**
1. **Planning**: The process of deciding what to achieve, when, and how — includes strategic, tactical, and operational plans.
2. **Organizing**: Structuring roles, responsibilities, and reporting relationships to implement the plan.
3. **Leading**: Inspiring employees through motivation, communication, and leadership style (transformational, transactional, etc.).
4. **Controlling**: Comparing actual performance against set standards and implementing corrective measures.

**Conclusion:**
In the banking sector, effective application of all management functions ensures institutional governance, employee productivity, and superior customer service — key pillars of a successful bank.''',
        isPremium: false,
      ),
      const Question(
        id: 'p1a_u2_q2', paper: PaperType.paper1, section: SectionType.sectionA,
        unitNumber: 2, unitTitle: 'Organizational Management (संगठनात्मक व्यवस्थापन)',
        marks: 5, type: QuestionType.subjective, yearsAsked: ['2077', '2081'],
        questionNepali: 'नेतृत्वका प्रकारहरू उल्लेख गर्नुहोस्।',
        questionEnglish: 'Describe the types of leadership styles.',
        answerNepali: '''**परिचय:** नेतृत्व भनेको अरूलाई लक्ष्यतर्फ प्रेरित गर्ने क्षमता हो।

**नेतृत्वका प्रमुख प्रकारहरू:**
- **निरंकुश (Autocratic)**: एक व्यक्तिले सबै निर्णय गर्छन्। दक्षता उच्च, मनोबल न्यून।
- **जनतान्त्रिक (Democratic)**: कर्मचारी सहभागितामा निर्णय। मनोबल उच्च।
- **स्वतन्त्र (Laissez-faire)**: कर्मचारीलाई स्वतन्त्रता दिइन्छ। अनुभवी टोलीका लागि उपयुक्त।
- **परिवर्तनकारी (Transformational)**: दृष्टिकोण र प्रेरणाद्वारा परिवर्तन ल्याउने।
- **लेनदेन (Transactional)**: पुरस्कार-दण्डमा आधारित।

**निष्कर्ष:** बैंकिङ क्षेत्रमा परिस्थिति अनुसार परिवर्तनकारी र जनतान्त्रिक नेतृत्व शैली प्रभावकारी मानिन्छ।''',
        answerEnglish: '''**Introduction:** Leadership is the ability to guide and motivate individuals or groups toward achieving organizational objectives.

**Major Leadership Styles:**
- **Autocratic**: Single leader makes all decisions. High efficiency but low morale.
- **Democratic/Participative**: Decisions involve team input. High morale and creativity.
- **Laissez-faire**: Leader delegates fully. Suitable for expert, self-driven teams.
- **Transformational**: Inspires change through vision and charisma.
- **Transactional**: Based on reward-punishment system for performance.

**Conclusion:** In the banking sector, a blend of transformational and democratic leadership fosters innovation, employee engagement, and customer-centric service delivery.''',
        isPremium: true,
      ),
      // ── PAPER I SECTION A — UNIT 3: HR Management ──
      const Question(
        id: 'p1a_u3_q1', paper: PaperType.paper1, section: SectionType.sectionA,
        unitNumber: 3, unitTitle: 'Human Resource Management (मानव संसाधन व्यवस्थापन)',
        marks: 10, type: QuestionType.subjective, yearsAsked: ['2073', '2076', '2079', '2082'],
        questionNepali: 'मानव संसाधन व्यवस्थापनका मुख्य कार्यहरू के-के हुन्? बैंकिङ सन्दर्भमा व्याख्या गर्नुहोस्।',
        questionEnglish: 'What are the main functions of Human Resource Management? Explain in the context of banking.',
        answerNepali: '''**परिचय:**
मानव संसाधन व्यवस्थापन (HRM) भनेको संगठनका लक्ष्य हासिल गर्न कर्मचारीको प्रभावकारी उपयोग गर्ने व्यवस्थापकीय प्रक्रिया हो।

**HRM का मुख्य कार्यहरू:**

**१. कार्यबल योजना (Workforce Planning):**
- बैंकलाई आवश्यक कर्मचारी संख्या, योग्यता र कार्यकाल निर्धारण।

**२. भर्ना तथा छनोट (Recruitment & Selection):**
- लोकसेवा आयोग वा आन्तरिक प्रक्रियाबाट योग्य कर्मचारी छनोट।
- RBB ले लिखित परीक्षा + अन्तर्वार्ताबाट छनोट गर्दछ।

**३. तालिम तथा विकास (Training & Development):**
- प्रारम्भिक तालिम, पदस्थापन तालिम, व्यावसायिक विकास कार्यक्रम।

**४. कार्यसम्पादन मूल्यांकन (Performance Appraisal):**
- KPI (Key Performance Indicators) मार्फत मूल्यांकन।

**५. पारिश्रमिक व्यवस्थापन (Compensation Management):**
- तलब, सुविधा, भत्ता, बोनस।

**६. श्रम सम्बन्ध (Labour Relations):**
- ट्रेड युनियन, सामूहिक सौदाबाजी।

**७. विदाई व्यवस्थापन (Separation Management):**
- सेवानिवृत्ति, राजीनामा, बर्खास्तगी।

**निष्कर्ष:**
बैंकिङ क्षेत्रमा HRM को प्रभावकारी कार्यान्वयनले कुशल कर्मचारी, उच्च उत्पादकत्व र ग्राहक सन्तुष्टि सुनिश्चित गर्दछ।''',
        answerEnglish: '''**Introduction:**
Human Resource Management (HRM) is the strategic approach to the effective management of employees in an organization so that they help the business gain a competitive advantage.

**Key HRM Functions in Banking:**

**1. Workforce Planning:**
Determining the right number, skills, and timing of staff needed to meet the bank's goals.

**2. Recruitment & Selection:**
Attracting and choosing qualified candidates via competitive exams (e.g., Lok Sewa Aayog), interviews, and structured assessments. RBB uses written tests + interviews.

**3. Training & Development:**
- Induction training for new hires
- On-the-job training for specialized roles
- Leadership and soft skills development programs

**4. Performance Appraisal:**
Using KPIs (e.g., loan recovery rate, customer satisfaction score) to evaluate employee performance objectively.

**5. Compensation & Benefits:**
Designing competitive salary structures, allowances, bonuses, and non-monetary benefits.

**6. Labour Relations:**
Managing trade union negotiations, collective bargaining, and grievance redressal.

**7. Separation Management:**
Handling retirement, resignations, and terminations in compliance with labor law.

**Conclusion:**
Effective HRM in banking is the cornerstone of service quality. Well-recruited, well-trained, and fairly compensated staff are the bank's most valuable assets in a competitive market.''',
        isPremium: true,
      ),
      // ── PAPER I SECTION B — MCQ ──
      const Question(
        id: 'p1b_mcq1', paper: PaperType.paper1, section: SectionType.sectionB,
        unitNumber: 1, unitTitle: 'IT Fundamentals',
        marks: 1, type: QuestionType.mcq, yearsAsked: ['2078', '2079'],
        questionNepali: 'RAM को पूर्ण रूप के हो?',
        questionEnglish: 'What is the full form of RAM?',
        options: [
          'Random Access Memory',
          'Read Access Memory',
          'Rapid Access Memory',
          'Random Assigned Memory',
        ],
        correctOptionIndex: 0,
        explanation: 'RAM stands for Random Access Memory — volatile memory used for temporary data storage while the CPU processes it.',
        isPremium: false,
      ),
      const Question(
        id: 'p1b_mcq2', paper: PaperType.paper1, section: SectionType.sectionB,
        unitNumber: 1, unitTitle: 'IT Fundamentals',
        marks: 1, type: QuestionType.mcq, yearsAsked: ['2079', '2080'],
        questionNepali: 'नेटवर्कमा IP address को प्रयोग के का लागि गरिन्छ?',
        questionEnglish: 'What is an IP address used for in a network?',
        options: [
          'Uniquely identifying a device on a network',
          'Encrypting data transmissions',
          'Storing files on a server',
          'Compressing network packets',
        ],
        correctOptionIndex: 0,
        explanation: 'An IP (Internet Protocol) address uniquely identifies each device on a network, enabling routing of data packets to the correct destination.',
        isPremium: false,
      ),
      const Question(
        id: 'p1b_mcq3', paper: PaperType.paper1, section: SectionType.sectionB,
        unitNumber: 2, unitTitle: 'Database Management',
        marks: 1, type: QuestionType.mcq, yearsAsked: ['2080', '2081'],
        questionNepali: 'DBMS मा Primary Key को काम के हो?',
        questionEnglish: 'What is the purpose of a Primary Key in DBMS?',
        options: [
          'Uniquely identify each record in a table',
          'Encrypt database records',
          'Link two databases together',
          'Sort records alphabetically',
        ],
        correctOptionIndex: 0,
        explanation: 'A Primary Key uniquely identifies each row in a database table. It cannot contain NULL values and must be unique across all rows.',
        isPremium: false,
      ),
      // ── PAPER II SECTION A ──
      const Question(
        id: 'p2a_u1_q1', paper: PaperType.paper2, section: SectionType.sectionA,
        unitNumber: 1, unitTitle: 'Computer Hardware & Software',
        marks: 5, type: QuestionType.subjective, yearsAsked: ['2078', '2080'],
        questionNepali: 'Operating System का कार्यहरू उल्लेख गर्नुहोस्।',
        questionEnglish: 'List and explain the functions of an Operating System.',
        answerNepali: '''**परिचय:** Operating System (OS) भनेको कम्प्युटर हार्डवेयर र सफ्टवेयरबीचको मध्यस्थकर्ता हो।

**OS का प्रमुख कार्यहरू:**
१. **Process Management** — CPU scheduling, multi-tasking व्यवस्थापन
२. **Memory Management** — RAM को आवंटन र पुनःप्राप्ति
३. **File System Management** — फाइल सिर्जना, मेटाउने, व्यवस्थापन
४. **Device Management** — I/O device driver नियन्त्रण
५. **Security Management** — User authentication, access control
६. **User Interface** — CLI वा GUI मार्फत प्रयोगकर्तासँग अन्तर्क्रिया

**निष्कर्ष:** OS ले कम्प्युटर प्रणालीको समग्र दक्षता, सुरक्षा र प्रयोगकर्ता अनुभव सुनिश्चित गर्दछ।''',
        answerEnglish: '''**Introduction:** An Operating System (OS) is system software that manages computer hardware, software resources, and provides common services for computer programs.

**Key Functions of an Operating System:**
1. **Process Management** — CPU scheduling (FCFS, Round Robin, Priority), multitasking
2. **Memory Management** — Allocating and deallocating RAM to running processes
3. **File System Management** — Creating, reading, updating, and deleting files and directories
4. **Device Management** — Managing I/O devices via device drivers
5. **Security Management** — User authentication, access control lists (ACL), permission management
6. **User Interface** — Providing CLI (Command Line Interface) or GUI (Graphical User Interface)

**Conclusion:** The OS acts as the backbone of any computing system, ensuring efficient resource utilization, security, and a seamless user experience.''',
        isPremium: true,
      ),
      const Question(
        id: 'p2a_u2_q1', paper: PaperType.paper2, section: SectionType.sectionA,
        unitNumber: 2, unitTitle: 'Database Management System (DBMS)',
        marks: 10, type: QuestionType.subjective, yearsAsked: ['2076', '2079', '2082'],
        questionNepali: 'Database को ACID properties के हुन्? विस्तारमा बुझाउनुहोस्।',
        questionEnglish: 'What are the ACID properties of a database? Explain in detail.',
        answerNepali: '''**परिचय:**
Database Transaction को अखण्डता सुनिश्चित गर्न ACID properties परिभाषित गरिएका छन्। बैंकिङ प्रणालीमा यी गुणहरू अत्यन्त महत्त्वपूर्ण छन्।

**ACID Properties:**

| Property | अर्थ | बैंकिङ उदाहरण |
|---|---|---|
| **Atomicity** | सम्पूर्ण transaction सफल हुने वा केही नहुने | Fund transfer: Debit र Credit दुवै हुनुपर्छ |
| **Consistency** | Database सधैं valid state मा रहने | खाताको balance negative हुन नहुने |
| **Isolation** | Concurrent transactions एकअर्काबाट स्वतन्त्र | दुई ATM withdrawal एकैसाथ गर्दा conflict नहुने |
| **Durability** | Committed transaction स्थायी रहने | Power failure पछि पनि transaction सुरक्षित |

**विस्तृत व्याख्या:**
- **Atomicity**: BEGIN TRANSACTION → COMMIT/ROLLBACK मेकानिजम
- **Consistency**: Constraints, triggers, cascades मार्फत
- **Isolation**: Lock-based protocols (Shared/Exclusive lock)
- **Durability**: Write-Ahead Logging (WAL), REDO/UNDO logs

**निष्कर्ष:** बैंकिङ जस्तो संवेदनशील क्षेत्रमा ACID properties ले डाटाको अखण्डता र ग्राहकको विश्वास सुनिश्चित गर्दछ।''',
        answerEnglish: '''**Introduction:**
ACID properties are a set of guarantees that ensure database transactions are processed reliably. In banking — where financial accuracy is critical — these properties are non-negotiable.

**ACID Properties Explained:**

| Property | Meaning | Banking Example |
|---|---|---|
| **Atomicity** | All or nothing — entire transaction succeeds or fails completely | Fund transfer: Both debit AND credit must complete |
| **Consistency** | Database remains valid before and after transaction | Account balance cannot go below zero |
| **Isolation** | Concurrent transactions don't interfere with each other | Two simultaneous ATM withdrawals don't overdraw the account |
| **Durability** | Committed transactions survive system failures | Transaction record persists even after power failure |

**Implementation Mechanisms:**
- **Atomicity**: `BEGIN TRANSACTION → COMMIT / ROLLBACK`
- **Consistency**: CHECK constraints, foreign keys, triggers
- **Isolation**: Locking protocols (Shared, Exclusive, Intent locks); Isolation levels (Read Uncommitted → Serializable)
- **Durability**: Write-Ahead Logging (WAL), REDO/UNDO logs, database replication

**Conclusion:**
In banking systems, ACID properties are foundational to financial data integrity. Every core banking transaction — deposits, withdrawals, loans, transfers — relies on these guarantees to maintain customer trust and regulatory compliance.''',
        isPremium: true,
      ),
    ];
  }
}

// ─── Mock Test Provider ───────────────────────────────────────
class MockTestProvider extends ChangeNotifier {
  List<Question> _questions = [];
  Map<String, int> _answers = {};
  int _currentIndex = 0;
  bool _isFinished = false;
  bool _isStarted = false;
  Duration _elapsed = Duration.zero;
  MockTestResult? _lastResult;

  static const Duration testDuration = Duration(minutes: 45);

  List<Question> get questions => _questions;
  Map<String, int> get answers => _answers;
  int get currentIndex => _currentIndex;
  bool get isFinished => _isFinished;
  bool get isStarted => _isStarted;
  Duration get elapsed => _elapsed;
  Duration get remaining => testDuration - _elapsed;
  MockTestResult? get lastResult => _lastResult;
  Question? get currentQuestion =>
      _questions.isNotEmpty ? _questions[_currentIndex] : null;

  void startTest(List<Question> mcqs) {
    _questions = List.from(mcqs)..shuffle();
    if (_questions.length > 50) _questions = _questions.take(50).toList();
    _answers = {};
    _currentIndex = 0;
    _isFinished = false;
    _isStarted = true;
    _elapsed = Duration.zero;
    _lastResult = null;
    notifyListeners();
  }

  void answerQuestion(String questionId, int optionIndex) {
    _answers[questionId] = optionIndex;
    notifyListeners();
  }

  void nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }

  void jumpTo(int index) {
    if (index >= 0 && index < _questions.length) {
      _currentIndex = index;
      notifyListeners();
    }
  }

  void updateElapsed(Duration elapsed) {
    _elapsed = elapsed;
    if (elapsed >= testDuration && !_isFinished) {
      submitTest();
    }
    notifyListeners();
  }

  void submitTest() {
    int correct = 0, incorrect = 0, unanswered = 0;
    for (final q in _questions) {
      if (!_answers.containsKey(q.id)) {
        unanswered++;
      } else if (_answers[q.id] == q.correctOptionIndex) {
        correct++;
      } else {
        incorrect++;
      }
    }
    _lastResult = MockTestResult(
      totalQuestions: _questions.length,
      answered: _answers.length,
      correct: correct,
      incorrect: incorrect,
      unanswered: unanswered,
      timeTaken: _elapsed,
      userAnswers: Map.from(_answers),
    );
    _isFinished = true;
    _isStarted = false;
    notifyListeners();
  }

  void reset() {
    _questions = [];
    _answers = {};
    _currentIndex = 0;
    _isFinished = false;
    _isStarted = false;
    _elapsed = Duration.zero;
    notifyListeners();
  }
}
