import 'package:flutter/material.dart';
import 'OnboardingScreen.dart';
import '../theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    
    if (!mounted) return;
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const OnboardingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.darkGradient,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Shopping bag icon with circular arrow
              Stack(
                alignment: Alignment.center,
                children: [
                  // Circular arrow
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.accentGold.withOpacity(0.4),
                        width: 3,
                      ),
                    ),
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentGold),
                      strokeWidth: 3,
                    ),
                  ),
                  // Shopping bag icon
                  const Icon(
                    Icons.shopping_bag_outlined,
                    size: 60,
                    color: AppColors.accentGold,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              // ShopUs text with icon
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.shopping_bag,
                    color: AppColors.accentGold,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'ShopUs',
                    style: TextStyle(
                      color: AppColors.accentGoldLight,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Tagline
              const Text(
                'Buy groceries and feed yourself',
                style: TextStyle(
                  color: AppColors.textWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
