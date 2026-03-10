import 'package:flutter/material.dart';
import 'View/  payment_page.dart';
import 'View/SplashScreen.dart';
import 'View/cart_page.dart';
import 'View/checkout_page.dart';
import 'location/map_location_picker.dart';
import 'theme/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShopUs - Ecommerce App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryGold,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        primaryColor: AppColors.primaryGold,
        scaffoldBackgroundColor: AppColors.backgroundWhite,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.backgroundBlack,
          foregroundColor: AppColors.textWhite,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryGold,
            foregroundColor: AppColors.textBlack,
            elevation: 2,
          ),
        ),
      ),
      home: const SplashScreen(),
        routes: {
          "checkout": (context) => const CheckoutPage(),
          "payment": (context) => const PaymentPage(),
          "map": (context) => const MapLocationPicker(),
        }
    );
  }
}
