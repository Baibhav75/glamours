import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'OnboardingScreen.dart';
import 'HomeScreen.dart';
import '../theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _textOpacityAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    /// 🎬 Animation Controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    /// 🔥 Scale (Zoom effect)
    _scaleAnimation = Tween<double>(
      begin: 5.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    /// 🔥 Logo Fade
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.1, 0.8, curve: Curves.easeIn),
      ),
    );

    /// 🔥 Text Fade (delayed)
    _textOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    /// 🔥 Slight rotation
    _rotationAnimation = Tween<double>(
      begin: -0.2,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    /// ▶ Start animation
    _controller.forward();

    /// 🔐 Navigate
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    var box = Hive.isBoxOpen('authBox')
        ? Hive.box('authBox')
        : await Hive.openBox('authBox');

    bool isLoggedIn = box.get('isLoggedIn', defaultValue: false);
    String? selfId = box.get('selfId');

    if (!mounted) return;

    if (isLoggedIn && selfId != null && selfId.isNotEmpty) {
      Get.offAll(() => const HomeScreen());
    } else {
      Get.offAll(() => const OnboardingScreen());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.darkGradient,
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  /// 🔥 Animated Logo
                  Opacity(
                    opacity: _opacityAnimation.value,
                    child: Transform.rotate(
                      angle: _rotationAnimation.value,
                      child: Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),

                            /// 🌫️ Glass background (semi-transparent)
                            color: Colors.white.withOpacity(0.05),

                            /// 🌈 Soft gradient overlay
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.15),
                                Colors.white.withOpacity(0.02),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),

                            /// ✨ Premium border
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                              width: 1.5,
                            ),

                            /// 🔥 Soft glow shadow
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                              BoxShadow(
                                color: AppColors.accentGold.withOpacity(0.15),
                                blurRadius: 25,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Image.asset(
                            'assets/images/glamourlogo.png',

                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  /// 🔥 App Name
                  Opacity(
                    opacity: _textOpacityAnimation.value,
                    child: const Text(
                      'Glamorous',
                      style: TextStyle(
                        color: AppColors.accentGoldLight,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// 🔥 Subtitle
                  Opacity(
                    opacity: _textOpacityAnimation.value,
                    child: const Text(
                      'Buy groceries and feed yourself',
                      style: TextStyle(
                        color: AppColors.textWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),

                  /// 🔥 Loader
                  Opacity(
                    opacity: _controller.value > 0.7 ? 1.0 : 0.0,
                    child: const CircularProgressIndicator(
                      color: AppColors.accentGold,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}