import 'package:flutter/material.dart';
import 'View/  payment_page.dart';
import 'View/SplashScreen.dart';
import 'View/cart_page.dart';
import 'View/checkout_page.dart';
import 'location/map_location_picker.dart';

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
          seedColor: const Color(0xFF8B2A9B),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
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
