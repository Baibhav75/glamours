import 'package:flutter/material.dart';

/// Centralized color theme for the entire application
/// Classic Black & Gold Luxury Theme - Professional and Elegant
class AppColors {
  // Primary Colors - Gold Theme (Main Brand Color)
  static const Color primaryGold = Color(0xFFD4AF37); // Classic Gold
  static const Color primaryGoldDark = Color(0xFFB8941F); // Darker Gold
  static const Color primaryGoldLight = Color(0xFFFFE082); // Light Gold
  static const Color primaryGoldVeryLight = Color(0xFFFFF3C4); // Very Light Gold
  
  // Accent Colors - Gold Theme (Aliases for consistency)
  static const Color accentGold = primaryGold; // Classic Gold accent
  static const Color accentGoldLight = primaryGoldLight; // Light Gold accent
  
  // Secondary Colors - Black Theme
  static const Color primaryBlack = Color(0xFF000000); // Pure Black
  static const Color primaryBlackDark = Color(0xFF0A0A0A); // Darker Black
  static const Color primaryBlackLight = Color(0xFF1C1C1C); // Light Black/Gray
  static const Color primaryBlackVeryLight = Color(0xFF2A2A2A); // Very Light Black
  
  // Background Colors
  static const Color backgroundBlack = Color(0xFF000000);
  static const Color backgroundDarkGray = Color(0xFF1C1C1C);
  static const Color backgroundMediumGray = Color(0xFF2A2A2A);
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color backgroundLightGray = Color(0xFFF5F5F5);
  static const Color backgroundOffWhite = Color(0xFFFAFAFA);
  
  // Gradient Colors - Classic Luxury Feel
  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      backgroundBlack,
      backgroundDarkGray,
    ],
  );
  
  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      primaryGold,
      primaryGoldDark,
    ],
  );
  
  static const LinearGradient goldToBlackGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      primaryGold,
      primaryBlack,
    ],
  );
  
  static const LinearGradient blackToGoldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      primaryBlack,
      primaryGoldDark,
    ],
  );
  
  // Onboarding Colors (Dark with Gold accents)
  static const Color onboardingDark = Color(0xFF1A1A1A);
  static const Color onboardingGold = primaryGold;
  static const Color onboardingGoldLight = primaryGoldLight;
  
  // Text Colors
  static const Color textBlack = Color(0xFF000000);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textGold = primaryGold;
  static const Color textGray = Color(0xFF757575);
  static const Color textLightGray = Color(0xFFBDBDBD);
  static const Color textDarkGray = Color(0xFF424242);
  
  // Border Colors
  static const Color borderGray = Color(0xFFE0E0E0);
  static const Color borderGold = primaryGold;
  static const Color borderDark = Color(0xFF333333);
  
  // Status Colors (with gold accents)
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color errorRed = Color(0xFFD32F2F);
  static const Color warningOrange = Color(0xFFFFB300);
  static const Color infoGold = primaryGold;
  
  // Product Colors (keeping for product details)
  static const Color productBlue = Color(0xFF4A4ECA);
  static const Color productPink = Color(0xFFE44498);
  static const Color productLightBlue = Color(0xFF4DB6F6);
  static const Color productYellow = Color(0xFFFFB300);
  
  // Shadow Colors
  static Color shadowLight = Colors.black.withOpacity(0.1);
  static Color shadowMedium = Colors.black.withOpacity(0.2);
  static Color shadowDark = Colors.black.withOpacity(0.3);
  static Color shadowGold = primaryGold.withOpacity(0.2);
  
  // Legacy support - map old purple to gold
  static const Color primaryPurple = primaryGold;
  static const Color primaryPurpleDark = primaryGoldDark;
  static const Color primaryPurpleLight = primaryGoldLight;
  static const Color primaryPurpleVeryLight = primaryGoldVeryLight;
  static const Color onboardingPink = onboardingDark;
  static const Color onboardingBlue = onboardingDark;
  static const Color onboardingPurple = onboardingDark;
  static const Color borderPurple = borderGold;
}
