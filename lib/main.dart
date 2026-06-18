import 'package:ak_insights_app/screens/simplified_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'services/instagram_data_provider.dart';

void main() {
  runApp(const AKInsightsApp());
}

class AKInsightsApp extends StatelessWidget {
  const AKInsightsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InstagramDataProvider()..initialize(),
      child: MaterialApp(
        title: 'AK Insights',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        home: const SimplifiedLoginScreen(),
      ),
    );
  }
}
