import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'SignInScreen.dart';
import '../theme/app_colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      title: 'Choose product',
      description:
          'Topcommerce is a online store. Its has into the 50k+ Products, you can buy every into a products in easy way.',
      imageColor: AppColors.onboardingDark, // Dark background with gold accents
      icon: Icons.shopping_cart_outlined,
      imageUrl: 'https://images.unsplash.com/photo-1556742502-ec7c0e9f34b1?w=800&q=80', // Shopping women
    ),
    OnboardingData(
      title: 'Make Payment',
      description:
          'Topcommerce is a online store. Its has into the 50k+ Products, you can buy every into a products in easy way.',
      imageColor: AppColors.onboardingDark, // Dark background with gold accents
      icon: Icons.payment_outlined,
      imageUrl: 'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=800&q=80', // Payment/shopping
    ),
    OnboardingData(
      title: 'Enjoy Shoping',
      description:
          'Topcommerce is a online store. Its has into the 50k+ Products, you can buy every into a products in easy way.',
      imageColor: AppColors.onboardingDark, // Dark background with gold accents
      icon: Icons.shopping_bag_outlined,
      imageUrl: 'https://images.unsplash.com/photo-1556742502-ec7c0e9f34b1?w=800&q=80', // Happy shopping
    ),
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _skipOnboarding() {
    _completeOnboarding();
  }

  void _completeOnboarding() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _buildOnboardingPage(_pages[index]);
                },
              ),
            ),
            // Page indicator and buttons
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // Page indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (index) => _buildPageIndicator(index == _currentPage),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Next button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryGold,
                        foregroundColor: AppColors.textBlack,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Skip button
                  TextButton(
                    onPressed: _skipOnboarding,
                    child: const Text(
                      'Skip for Now',
                      style: TextStyle(
                        color: AppColors.textBlack,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(OnboardingData data) {
    return Column(
      children: [
        // Image section with curved bottom
        Expanded(
          flex: 3,
          child: Stack(
            children: [
              // Network image with background color
              Container(
                width: double.infinity,
                color: data.imageColor,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: data.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: data.imageColor,
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: data.imageColor,
                        child: Center(
                          child: Icon(
                            data.icon,
                            size: 120,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ),
                    // Gradient overlay with gold accent
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            AppColors.backgroundBlack.withOpacity(0.8),
                            AppColors.primaryGold.withOpacity(0.3),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Curved white shape at bottom
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipPath(
                  clipper: CurvedClipper(),
                  child: Container(
                    height: 60,
                    color: AppColors.backgroundWhite,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Text section
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            color: AppColors.backgroundWhite,
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textBlack,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  data.description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.textBlack,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPageIndicator(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.primaryGold
            : AppColors.primaryGold.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String description;
  final Color imageColor;
  final IconData icon;
  final String imageUrl;

  OnboardingData({
    required this.title,
    required this.description,
    required this.imageColor,
    required this.icon,
    required this.imageUrl,
  });
}

class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.6);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height * 0.6,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
