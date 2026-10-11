import 'package:flutter/material.dart';

class AppTheme {
  // Pure White + Black & Red Minimalist Palette (Chakra UI / Material UI Style)
  static const Color primaryColor = Color(0xFF111111);      // Pure Jet Black
  static const Color primaryLight = Color(0xFF27272A);      // Zinc 800 (Black variant)
  static const Color primaryDark = Color(0xFF09090B);       // Deepest Black
  static const Color iconRed = Color(0xFFDC2626);           // Crimson Red (Primary Icon/Accent)
  static const Color iconRedDark = Color(0xFF991B1B);       // Dark Red variant
  static const Color iconRedLight = Color(0xFFFEE2E2);      // Soft Red tint for icon backgrounds

  // Legacy aliases mapped strictly to Black, Red, and Neutral Grayscale (NO blue/gold/green/orange)
  static const Color accentGold = Color(0xFFDC2626);        // Mapped to Crimson Red
  static const Color accentGoldLight = Color(0xFFFEE2E2);   // Mapped to Soft Red tint
  static const Color successGreen = Color(0xFF111111);      // Mapped to Jet Black
  static const Color errorRed = Color(0xFFDC2626);          // Crimson Red
  static const Color warningAmber = Color(0xFFDC2626);      // Mapped to Crimson Red
  static const Color bgLight = Color(0xFFFFFFFF);           // Pure White
  static const Color bgSurface = Color(0xFFFAFAFA);         // Subtle Off-White Surface
  static const Color bgCard = Color(0xFFFFFFFF);            // Pure White Card
  static const Color textPrimary = Color(0xFF09090B);       // Crisp Black
  static const Color textBody = Color(0xFF18181B);          // Zinc 900
  static const Color textMuted = Color(0xFF71717A);         // Zinc 500
  static const Color divider = Color(0xFFE4E4E7);           // Chakra/MUI 1px Hairline Border
  static const Color freeBadge = Color(0xFF52525B);         // Neutral Gray
  static const Color basicBadge = Color(0xFF111111);        // Black
  static const Color premiumBadge = Color(0xFFDC2626);      // Red

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: bgLight,
      canvasColor: bgLight,
      cardColor: bgCard,
      dividerColor: divider,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        onPrimary: Colors.white,
        secondary: iconRed,
        onSecondary: Colors.white,
        surface: bgCard,
        onSurface: textPrimary,
        background: bgLight,
        onBackground: textPrimary,
        error: iconRed,
        onError: Colors.white,
        surfaceTint: Colors.transparent,
      ),
      iconTheme: const IconThemeData(
        color: primaryColor,
        size: 20,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 46, fontWeight: FontWeight.w800, color: textPrimary, letterSpacing: -1.0,
        ),
        displayMedium: TextStyle(
          fontSize: 36, fontWeight: FontWeight.w800, color: textPrimary, letterSpacing: -0.8,
        ),
        displaySmall: TextStyle(
          fontSize: 28, fontWeight: FontWeight.w700, color: textPrimary, letterSpacing: -0.5,
        ),
        headlineLarge: TextStyle(
          fontSize: 24, fontWeight: FontWeight.w700, color: textPrimary, letterSpacing: -0.4,
        ),
        headlineMedium: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w700, color: textPrimary,
        ),
        headlineSmall: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w600, color: textBody,
        ),
        titleLarge: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w600, color: textBody,
        ),
        bodyLarge: TextStyle(fontSize: 15, color: textBody, height: 1.6),
        bodyMedium: TextStyle(fontSize: 14, color: textBody, height: 1.55),
        bodySmall: TextStyle(fontSize: 12, color: textMuted, height: 1.4),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: textPrimary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        shape: Border(bottom: BorderSide(color: divider, width: 1)),
        iconTheme: IconThemeData(color: textPrimary),
        titleTextStyle: TextStyle(
          color: textPrimary, fontSize: 18, fontWeight: FontWeight.w700, letterSpacing: -0.3,
        ),
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: divider, width: 1),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textPrimary,
          backgroundColor: Colors.white,
          side: const BorderSide(color: divider, width: 1.2),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryColor, width: 1.8),
        ),
        labelStyle: const TextStyle(color: textMuted, fontSize: 13.5),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.white,
        selectedColor: primaryColor,
        secondarySelectedColor: primaryColor,
        side: const BorderSide(color: divider),
        labelStyle: const TextStyle(fontSize: 12.5, color: textPrimary, fontWeight: FontWeight.w500),
        secondaryLabelStyle: const TextStyle(fontSize: 12.5, color: Colors.white, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      navigationRailTheme: const NavigationRailThemeData(
        backgroundColor: Colors.white,
        selectedIconTheme: IconThemeData(color: iconRed, size: 22),
        unselectedIconTheme: IconThemeData(color: textMuted, size: 20),
        selectedLabelTextStyle: TextStyle(color: textPrimary, fontWeight: FontWeight.w700, fontSize: 12),
        unselectedLabelTextStyle: TextStyle(color: textMuted, fontWeight: FontWeight.w500, fontSize: 12),
        indicatorColor: iconRedLight,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        indicatorColor: iconRedLight,
        iconTheme: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const IconThemeData(color: iconRed, size: 22);
          }
          return const IconThemeData(color: textMuted, size: 20);
        }),
      ),
      dividerTheme: const DividerThemeData(
        color: divider,
        thickness: 1,
        space: 1,
      ),
    );
  }
}
