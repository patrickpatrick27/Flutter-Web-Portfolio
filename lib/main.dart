import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'theme/app_theme.dart'; // Import your new theme

void main() {
  runApp(const MyPortfolio());
}

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Dave's Portfolio",
      debugShowCheckedModeBanner: false,
      
      // APPLY THEME HERE
      theme: AppTheme.lightTheme, 
      
      home: const HomeScreen(),
    );
  }
}