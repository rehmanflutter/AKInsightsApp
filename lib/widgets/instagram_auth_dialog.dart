import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/instagram_config.dart';
import '../services/instagram_service.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';

/// Platform-aware Instagram authentication
/// Uses URL launcher with manual code entry (works on all platforms)
class InstagramAuthDialog {
  static Future<void> authenticate(
    BuildContext context,
    Function(bool success, String? error) onComplete,
  ) async {
    // Use web dialog approach for all platforms
    // This avoids WebView compilation issues and works universally
    _showWebAuthDialog(context, onComplete);
  }

  static void _showWebAuthDialog(
    BuildContext context,
    Function(bool success, String? error) onComplete,
  ) {
    final authCodeController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GlassCard(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: AppColors.brandGradient,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 24),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Instagram Login',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: AppColors.textSecondary),
                      onPressed: () {
                        Navigator.pop(context);
                        onComplete(false, 'Login cancelled');
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Web Authentication Flow',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  kIsWeb
                      ? '1. Click the button below to open Instagram login\n'
                        '2. Authorize the app\n'
                        '3. Copy the "code" from the redirect URL\n'
                        '4. Paste it here and click Submit'
                      : '1. Click the button below to open Instagram\n'
                        '2. Login and authorize the app\n'
                        '3. Instagram will show a redirect URL\n'
                        '4. Copy the code from the URL and paste it here',
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () => _launchInstagramAuth(),
                  icon: const Icon(Icons.open_in_new),
                  label: const Text('Open Instagram Login'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.purple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Paste Authorization Code:',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: authCodeController,
                  style: const TextStyle(color: AppColors.textPrimary),
                  decoration: InputDecoration(
                    hintText: 'Paste code here...',
                    hintStyle: const TextStyle(color: AppColors.textFaint),
                    filled: true,
                    fillColor: AppColors.surfaceLight.withOpacity(0.6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.purple, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    final code = authCodeController.text.trim();
                    if (code.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter the authorization code')),
                      );
                      return;
                    }
                    Navigator.pop(context);
                    await _handleAuthCode(code, onComplete);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.magenta,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Submit', style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Future<void> _launchInstagramAuth() async {
    final url = Uri.parse(InstagramConfig.getAuthorizationUrl());
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  static Future<void> _handleAuthCode(
    String code,
    Function(bool success, String? error) onComplete,
  ) async {
    try {
      // Exchange code for access token
      final tokenData = await InstagramService.getAccessToken(code);

      if (tokenData != null) {
        // Get long-lived token
        final shortToken = tokenData['access_token'];
        await InstagramService.getLongLivedToken(shortToken);

        // Fetch user profile
        await InstagramService.getUserProfile();

        onComplete(true, null);
      } else {
        onComplete(false, 'Failed to get access token. Please check your Instagram app configuration.');
      }
    } catch (e) {
      onComplete(false, 'Error: $e');
    }
  }

}
