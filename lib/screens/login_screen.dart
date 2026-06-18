import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/animated_gradient_background.dart';
import '../widgets/glass_card.dart';
import '../widgets/instagram_auth_dialog.dart';
import '../services/instagram_config.dart';
import '../services/secure_storage_service.dart';
import 'dashboard_shell.dart';

/// Instagram Login Screen with OAuth Integration
/// Uses Instagram Basic Display API for real authentication
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _loading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _checkExistingLogin();
  }

  Future<void> _checkExistingLogin() async {
    final isLoggedIn = await SecureStorageService.isLoggedIn();
    if (isLoggedIn && mounted) {
      _navigateToDashboard();
    }
  }

  void _onLoginWithInstagram() {
    // Check if Instagram API is configured
    if (!InstagramConfig.isConfigured) {
      setState(() {
        _errorMessage = 'Instagram API not configured! Please update lib/services/instagram_config.dart with your App ID and Secret. See INSTAGRAM_SETUP_GUIDE.md';
      });
      return;
    }

    // Use platform-aware authentication
    InstagramAuthDialog.authenticate(
      context,
      (success, error) {
        if (success) {
          _navigateToDashboard();
        } else {
          setState(() {
            _errorMessage = error ?? 'Login failed';
          });
        }
      },
    );
  }

  void _onDemoMode() {
    setState(() => _loading = true);
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      _navigateToDashboard();
    });
  }

  void _navigateToDashboard() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) => const DashboardShell(),
        transitionsBuilder: (_, anim, __, child) {
          final tween = Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero);
          return FadeTransition(
            opacity: anim,
            child: SlideTransition(position: tween.animate(anim), child: child),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedGradientBackground(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: GlassCard(
                padding: const EdgeInsets.all(28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(gradient: AppColors.brandGradient, borderRadius: BorderRadius.circular(20)),
                      child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 30),
                    ),
                    const SizedBox(height: 18),
                    const Text('Connect to Instagram',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    const Text(
                      'Login with your Instagram account to see real data',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 12.5),
                    ),
                    const SizedBox(height: 26),
                    if (_errorMessage != null) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.red.withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.error_outline, color: Colors.red, size: 18),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _errorMessage!,
                                style: const TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, size: 16, color: Colors.red),
                              onPressed: () => setState(() => _errorMessage = null),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    _instagramLoginButton(),
                    const SizedBox(height: 14),
                    const Row(
                      children: [
                        Expanded(child: Divider(color: AppColors.textFaint, thickness: 0.5)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text('OR', style: TextStyle(color: AppColors.textFaint, fontSize: 11)),
                        ),
                        Expanded(child: Divider(color: AppColors.textFaint, thickness: 0.5)),
                      ],
                    ),
                    const SizedBox(height: 14),
                    _demoButton(),
                    const SizedBox(height: 16),
                    const Text(
                      'Real Instagram login uses OAuth - your credentials are never stored in this app',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.textFaint, fontSize: 10.5),
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

  Widget _instagramLoginButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _onLoginWithInstagram,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            gradient: AppColors.brandGradient,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(color: AppColors.magenta.withOpacity(0.35), blurRadius: 22, offset: const Offset(0, 8)),
            ],
          ),
          child: const Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.camera_alt_rounded, color: Colors.white, size: 20),
                SizedBox(width: 10),
                Text('Login with Instagram',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _demoButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _loading ? null : _onDemoMode,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.surfaceLight.withOpacity(0.6),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white.withOpacity(0.12)),
          ),
          child: Center(
            child: _loading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(strokeWidth: 2.4, color: AppColors.textSecondary),
                  )
                : const Text('Continue with Demo Data',
                    style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600, fontSize: 14)),
          ),
        ),
      ),
    );
  }
}
