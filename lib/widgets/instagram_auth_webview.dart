import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../services/instagram_config.dart';
import '../services/instagram_service.dart';

/// WebView for Instagram OAuth authentication
class InstagramAuthWebView extends StatefulWidget {
  final Function(bool success, String? error) onAuthComplete;

  const InstagramAuthWebView({
    super.key,
    required this.onAuthComplete,
  });

  @override
  State<InstagramAuthWebView> createState() => _InstagramAuthWebViewState();
}

class _InstagramAuthWebViewState extends State<InstagramAuthWebView> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() => _isLoading = true);
            _checkForRedirect(url);
          },
          onPageFinished: (String url) {
            setState(() => _isLoading = false);
          },
          onWebResourceError: (WebResourceError error) {
            print('WebView error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(InstagramConfig.getAuthorizationUrl()));
  }

  void _checkForRedirect(String url) {
    // Check if the URL contains the redirect URI
    if (url.startsWith(InstagramConfig.redirectUri)) {
      final uri = Uri.parse(url);

      // Check for authorization code
      final code = uri.queryParameters['code'];
      if (code != null) {
        _handleAuthorizationCode(code);
        return;
      }

      // Check for error
      final error = uri.queryParameters['error'];
      if (error != null) {
        widget.onAuthComplete(false, 'Authorization failed: $error');
      }
    }
  }

  Future<void> _handleAuthorizationCode(String code) async {
    try {
      // Exchange code for access token
      final tokenData = await InstagramService.getAccessToken(code);

      if (tokenData != null) {
        // Get long-lived token
        final shortToken = tokenData['access_token'];
        await InstagramService.getLongLivedToken(shortToken);

        // Fetch user profile
        await InstagramService.getUserProfile();

        widget.onAuthComplete(true, null);
      } else {
        widget.onAuthComplete(false, 'Failed to get access token');
      }
    } catch (e) {
      widget.onAuthComplete(false, 'Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login with Instagram'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            widget.onAuthComplete(false, 'Login cancelled');
          },
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
