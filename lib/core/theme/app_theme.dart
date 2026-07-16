import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFF1E1E1E),
      colorScheme: const ColorScheme.dark(
        surface: Color(0xFF1F2128), // another background color
        onSurface: Color(0xFFFFFFFF), // text color
        surfaceContainerHighest: Color(0xFF242731), // bottom nav bar color
        primaryContainer: Color(0xFF2B2C33), // main container background color
        //#282A31   #2B2C33  
        onPrimaryContainer: Color(0xFFFFFFFF), // text on main container
        primary: Color(0xFFFFFFFF), // main button
        secondary: Color(0xFFDC8735),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      colorScheme: ColorScheme.light(
        surface: Color(0xFFFFFFFF), // another background color
        onSurface: Color(0xFF101010), // text color
        surfaceContainerHighest: Color(0xFFFFFFFF), // bottom nav bar color
        primary: Color(0xFFE28C37), // main button
        onPrimary: Color(0xFFFFFFFF), // text on main button
        secondary: Color(0xFFDC8735),
        // secondary color of button & text & border
        primaryContainer: Color(0xFFE7E7E8), // main container color
        onPrimaryContainer: Color(0xFF757575), // text on main container
        secondaryContainer: Color(0xFFFE8C00).withValues(alpha: 0.5),
        // secondary container color
      ),
    );
  }
}
