import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/home_page.dart';
import 'theme/app_colors.dart';

void main() => runApp(const PortfolioApp());

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Majd Al-Khodari | Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.gold,
          brightness: Brightness.light,
          surface: AppColors.surface,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme).apply(
          bodyColor: AppColors.text,
          displayColor: AppColors.text,
        ),
      ),
      home: const HomePage(),
    );
  }
}
