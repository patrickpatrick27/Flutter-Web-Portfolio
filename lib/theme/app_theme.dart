import 'package:flutter/material.dart';

class AppTheme {
  // --- Colors ---
  static const Color primaryColor = Color(0xFF6200EE); 
  static const Color accentColor = Color(0xFF03DAC5); 
  
  // CHANGED: Pure white background for better contrast
  static const Color background = Colors.white;   
  
  // Sensor Specific Colors
  static const Color tempColor = Color(0xFFFF6B6B);    
  static const Color phColor = Color(0xFF4D96FF);      
  static const Color gravityColor = Color(0xFF6BCB77); 

  // --- Text Styles ---
  static const TextStyle headerStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
    letterSpacing: -0.5,
  );

  static const TextStyle subHeaderStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.black54,
  );

  static const TextStyle valueStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  // --- Global Theme Data ---
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: background, // Now White
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        secondary: accentColor,
        background: background,
      ),
      
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      
      // CHANGED: Stronger Shadow for Cards
      cardTheme: CardThemeData(
        color: Colors.white, // Cards stay white
        surfaceTintColor: Colors.white, // Prevents "tinting" on Material 3
        elevation: 8, // Higher elevation = More "Pop"
        shadowColor: Colors.black26, // Darker shadow so it's visible on white
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}