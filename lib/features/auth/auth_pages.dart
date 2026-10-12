import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';
import '../../data/repositories/providers.dart';

// ─── General Candidate Login Page (/login) ────────────────────
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscurePass = true;
  bool _isSubmitting = false;
  String _statusMessage = 'Signing you in, please wait...';

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_isSubmitting) return;
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    setState(() {
      _isSubmitting = true;
      _statusMessage = 'Signing you in to LoksewaHero...';
    });

    final auth = context.read<AuthProvider>();
    final error = await auth.login(_emailCtrl.text.trim(), _passCtrl.text.trim());
    if (!mounted) return;
    if (error == null) {
      setState(() {
        _statusMessage = 'Verified! Preparing your study dashboard...';
      });
      // Start refreshing courses/questions and navigate
      context.read<QuestionProvider>().loadAll(forceRefresh: true);
      await Future.delayed(const Duration(milliseconds: 250));
      if (mounted) context.go(AppConstants.routeDashboard);
    } else {
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error), backgroundColor: AppTheme.iconRed),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    if (!auth.initializing && auth.isCandidateLoggedIn && !_isSubmitting) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.go(AppConstants.routeDashboard);
      });
    }
    final isSmall = MediaQuery.of(context).size.width < 480;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(isSmall ? 14 : 24),
            child: Column(
              children: [
                _AuthCard(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const _AuthHeader(
                          title: 'Candidate Sign In',
                          subtitle: 'Sign in to continue your Lok Sewa preparation',
                          icon: Icons.menu_book_rounded,
                        ),
                        const SizedBox(height: 28),
                        TextFormField(
                          controller: _emailCtrl,
                          enabled: !_isSubmitting,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: 'Candidate Email Address',
                            prefixIcon: Icon(Icons.email_outlined, color: AppTheme.primaryColor),
                          ),
                          validator: (v) => (v?.contains('@') ?? false) ? null : 'Enter valid email',
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _passCtrl,
                          enabled: !_isSubmitting,
                          obscureText: _obscurePass,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _submit(),
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock_outline, color: AppTheme.primaryColor),
                            suffixIcon: IconButton(
                              icon: Icon(_obscurePass ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: AppTheme.textMuted),
                              onPressed: _isSubmitting ? null : () => setState(() => _obscurePass = !_obscurePass),
                            ),
                          ),
                          validator: (v) => (v?.length ?? 0) >= 6 ? null : 'Min 6 characters',
                        ),
                        const SizedBox(height: 20),
                        if (_isSubmitting) ...[
                          _AuthLoadingBanner(message: _statusMessage),
                          const SizedBox(height: 16),
                        ],
                        Consumer<AuthProvider>(
                          builder: (ctx, auth, _) {
                            final busy = _isSubmitting || auth.loading;
                            return FilledButton(
                              onPressed: busy ? null : _submit,
                              style: FilledButton.styleFrom(
                                backgroundColor: AppTheme.iconRed,
                                foregroundColor: Colors.white,
                                disabledBackgroundColor: AppTheme.iconRed.withOpacity(0.85),
                                disabledForegroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: busy
                                  ? const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 18,
                                          height: 18,
                                          child: CircularProgressIndicator(strokeWidth: 2.3, color: Colors.white),
                                        ),
                                        SizedBox(width: 12),
                                        Text(
                                          'Signing In, Please Wait...',
                                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                                        ),
                                      ],
                                    )
                                  : const Text('Sign In as Candidate', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                            );
                          },
                        ),
                        const SizedBox(height: 18),
                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const Text('Don\'t have an account? ', style: TextStyle(color: AppTheme.textMuted)),
                            TextButton(
                              onPressed: _isSubmitting ? null : () => context.go(AppConstants.routeRegister),
                              child: const Text('Register Free', style: TextStyle(color: AppTheme.iconRed, fontWeight: FontWeight.w700)),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: _isSubmitting ? null : () => context.go(AppConstants.routeHome),
                          child: const Text('← Back to Home', style: TextStyle(color: AppTheme.textMuted)),
                        ),
                      ],
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
}

// ─── Dedicated Admin Login Page (/admin/adminlogin) ───────────
class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});
  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscurePass = true;
  bool _isSubmitting = false;
  String _statusMessage = 'Verifying administrator credentials...';

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_isSubmitting) return;
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    setState(() {
      _isSubmitting = true;
      _statusMessage = 'Verifying administrator credentials...';
    });

    final auth = context.read<AuthProvider>();
    final error = await auth.login(
      _emailCtrl.text.trim(),
      _passCtrl.text.trim(),
      forAdminPortal: true,
    );
    if (!mounted) return;
    if (error == null) {
      setState(() {
        _statusMessage = 'Authenticated! Loading Admin CMS Portal...';
      });
      context.read<QuestionProvider>().loadAll(forceRefresh: true);
      await Future.delayed(const Duration(milliseconds: 250));
      if (mounted) context.go(AppConstants.routeAdmin);
    } else {
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error), backgroundColor: AppTheme.iconRed),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    if (!auth.initializing && auth.isAdminLoggedIn && !_isSubmitting) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.go(AppConstants.routeAdmin);
      });
    }
    final isSmall = MediaQuery.of(context).size.width < 480;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(isSmall ? 14 : 24),
            child: _AuthCard(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _AuthHeader(
                      title: 'Admin CMS Portal',
                      subtitle: 'Authorized Administrator Sign In (/admin/adminlogin)',
                      icon: Icons.admin_panel_settings_outlined,
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.iconRedLight,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppTheme.iconRed.withOpacity(0.3)),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.shield_outlined, size: 16, color: AppTheme.iconRed),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Restricted Area: Authorized Administrators Only.',
                              style: TextStyle(fontSize: 11.5, color: AppTheme.iconRedDark, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    TextFormField(
                      controller: _emailCtrl,
                      enabled: !_isSubmitting,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Admin Email',
                        prefixIcon: Icon(Icons.admin_panel_settings_outlined, color: AppTheme.primaryColor),
                      ),
                      validator: (v) => (v?.contains('@') ?? false) ? null : 'Enter valid admin email',
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passCtrl,
                      enabled: !_isSubmitting,
                      obscureText: _obscurePass,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _submit(),
                      decoration: InputDecoration(
                        labelText: 'Admin Password',
                        prefixIcon: const Icon(Icons.lock_outline, color: AppTheme.primaryColor),
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePass ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: AppTheme.textMuted),
                          onPressed: _isSubmitting ? null : () => setState(() => _obscurePass = !_obscurePass),
                        ),
                      ),
                      validator: (v) => (v?.length ?? 0) >= 6 ? null : 'Min 6 characters',
                    ),
                    const SizedBox(height: 20),
                    if (_isSubmitting) ...[
                      _AuthLoadingBanner(message: _statusMessage),
                      const SizedBox(height: 16),
                    ],
                    Consumer<AuthProvider>(
                      builder: (ctx, auth, _) {
                        final busy = _isSubmitting || auth.loading;
                        return FilledButton(
                          onPressed: busy ? null : _submit,
                          style: FilledButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: AppTheme.primaryColor.withOpacity(0.85),
                            disabledForegroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: busy
                              ? const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(strokeWidth: 2.3, color: Colors.white),
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      'Signing In to Admin CMS...',
                                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                                    ),
                                  ],
                                )
                              : const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.login_rounded, size: 18, color: Colors.white),
                                    SizedBox(width: 8),
                                    Text('Sign In to Admin CMS', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                                  ],
                                ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Register Page (/register) ────────────────────────────────
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _obscure = true;
  bool _isSubmitting = false;
  String _statusMessage = 'Creating your LoksewaHero account...';

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_isSubmitting) return;
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    setState(() {
      _isSubmitting = true;
      _statusMessage = 'Creating your LoksewaHero candidate account...';
    });

    final auth = context.read<AuthProvider>();
    final error = await auth.register(
      _nameCtrl.text.trim(),
      _emailCtrl.text.trim(),
      _passCtrl.text.trim(),
    );
    if (!mounted) return;
    if (error == null) {
      setState(() {
        _statusMessage = 'Account created! Preparing your dashboard...';
      });
      context.read<QuestionProvider>().loadAll(forceRefresh: true);
      await Future.delayed(const Duration(milliseconds: 250));
      if (mounted) context.go(AppConstants.routeDashboard);
    } else {
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error), backgroundColor: AppTheme.iconRed),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 480;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(isSmall ? 14 : 24),
            child: _AuthCard(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _AuthHeader(
                      title: 'Create Candidate Account',
                      subtitle: 'Start your Lok Sewa preparation today',
                      icon: Icons.person_add_alt_1_rounded,
                    ),
                    const SizedBox(height: 28),
                    TextFormField(
                      controller: _nameCtrl,
                      enabled: !_isSubmitting,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        prefixIcon: Icon(Icons.person_outline, color: AppTheme.primaryColor),
                      ),
                      validator: (v) => (v?.trim().length ?? 0) >= 2 ? null : 'Enter your full name',
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailCtrl,
                      enabled: !_isSubmitting,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                        prefixIcon: Icon(Icons.email_outlined, color: AppTheme.primaryColor),
                      ),
                      validator: (v) => (v?.contains('@') ?? false) ? null : 'Enter valid email',
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passCtrl,
                      enabled: !_isSubmitting,
                      obscureText: _obscure,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline, color: AppTheme.primaryColor),
                        suffixIcon: IconButton(
                          icon: Icon(_obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: AppTheme.textMuted),
                          onPressed: _isSubmitting ? null : () => setState(() => _obscure = !_obscure),
                        ),
                      ),
                      validator: (v) => (v?.length ?? 0) >= 6 ? null : 'Min 6 characters',
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _confirmCtrl,
                      enabled: !_isSubmitting,
                      obscureText: _obscure,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _submit(),
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                        prefixIcon: Icon(Icons.lock_outline, color: AppTheme.primaryColor),
                      ),
                      validator: (v) => v == _passCtrl.text ? null : 'Passwords do not match',
                    ),
                    const SizedBox(height: 20),
                    if (_isSubmitting) ...[
                      _AuthLoadingBanner(message: _statusMessage),
                      const SizedBox(height: 16),
                    ],
                    Consumer<AuthProvider>(
                      builder: (ctx, auth, _) {
                        final busy = _isSubmitting || auth.loading;
                        return FilledButton(
                          onPressed: busy ? null : _submit,
                          style: FilledButton.styleFrom(
                            backgroundColor: AppTheme.iconRed,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: AppTheme.iconRed.withOpacity(0.85),
                            disabledForegroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: busy
                              ? const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(strokeWidth: 2.3, color: Colors.white),
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      'Creating Account, Please Wait...',
                                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                                    ),
                                  ],
                                )
                              : const Text('Create Candidate Account', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'By registering, you get Free plan access to all exam syllabi, preview model answers, and mock tests.',
                      style: TextStyle(color: AppTheme.textMuted, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Text('Already have an account? ', style: TextStyle(color: AppTheme.textMuted)),
                        TextButton(
                          onPressed: _isSubmitting ? null : () => context.go(AppConstants.routeLogin),
                          child: const Text('Sign In', style: TextStyle(color: AppTheme.iconRed, fontWeight: FontWeight.w700)),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: _isSubmitting ? null : () => context.go(AppConstants.routeHome),
                      child: const Text('← Back to Home', style: TextStyle(color: AppTheme.textMuted)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Shared Auth Widgets ──────────────────────────────────────
class _AuthLoadingBanner extends StatelessWidget {
  final String message;
  const _AuthLoadingBanner({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.iconRedLight,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.iconRed.withOpacity(0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2.2,
                  color: AppTheme.iconRed,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: const LinearProgressIndicator(
              minHeight: 4,
              backgroundColor: Colors.white,
              color: AppTheme.iconRed,
            ),
          ),
        ],
      ),
    );
  }
}

class _AuthCard extends StatelessWidget {
  final Widget child;
  const _AuthCard({required this.child});

  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 480;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 440),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppTheme.divider, width: 1.2),
        ),
        padding: EdgeInsets.all(isSmall ? 20 : 34),
        child: child,
      ),
    );
  }
}

class _AuthHeader extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  const _AuthHeader({required this.title, required this.subtitle, required this.icon});

  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 480;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.iconRedLight,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppTheme.iconRed.withOpacity(0.25)),
          ),
          child: Icon(icon, color: AppTheme.iconRed, size: 28),
        ),
        const SizedBox(height: 14),
        const Text('LoksewaHero', style: TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.w800, fontSize: 16)),
        const SizedBox(height: 6),
        Text(
          title,
          style: TextStyle(fontSize: isSmall ? 19 : 22, fontWeight: FontWeight.w800, color: AppTheme.textPrimary, letterSpacing: -0.4),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(subtitle, style: const TextStyle(color: AppTheme.textMuted, fontSize: 13), textAlign: TextAlign.center),
      ],
    );
  }
}
