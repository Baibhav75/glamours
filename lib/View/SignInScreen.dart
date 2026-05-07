import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import '../Controller/loginController.dart';
import 'VerificationCodeScreen.dart';
import 'HomeScreen.dart';
import '../theme/app_colors.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final LoginController _controller = Get.put(LoginController());

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      if (_controller.isSignIn.value) {
        _controller.handleLogin();
      } else {
        _controller.handleSignUp();
      }
    }
  }

  void _handleForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const VerificationCodeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background image section - changes image based on mode
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Obx(() => AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Container(
                  key: ValueKey(_controller.isSignIn.value),
                  decoration: const BoxDecoration(
                    gradient: AppColors.darkGradient,
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: _controller.isSignIn.value
                            ? 'https://images.unsplash.com/photo-1556742502-ec7c0e9f34b1?w=800&q=80'
                            : 'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=800&q=80',
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: AppColors.backgroundDarkGray,
                          child: const Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: AppColors.backgroundDarkGray,
                          child: const Center(child: Icon(Icons.shopping_bag_outlined, size: 120, color: Colors.white70)),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              AppColors.backgroundBlack.withOpacity(0.8),
                              AppColors.primaryPurple.withOpacity(0.2),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
            ),
            // Content section
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              top: MediaQuery.of(context).size.height * 0.35,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.backgroundWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Obx(() => Text(
                          _controller.isSignIn.value ? 'Welcome back!' : 'Create Account',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textBlack,
                          ),
                        )),
                        const SizedBox(height: 24),
                        // Tabs
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  if (!_controller.isSignIn.value) _controller.toggleMode();
                                },
                                child: Obx(() => Column(
                                  children: [
                                    Text(
                                      'Sign In',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: _controller.isSignIn.value ? FontWeight.w600 : FontWeight.w400,
                                        color: _controller.isSignIn.value ? AppColors.primaryPurple : AppColors.textGray,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      height: 3,
                                      decoration: BoxDecoration(
                                        color: _controller.isSignIn.value ? AppColors.primaryPurple : Colors.transparent,
                                        borderRadius: const BorderRadius.all(Radius.circular(2)),
                                      ),
                                    ),
                                  ],
                                )),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  if (_controller.isSignIn.value) _controller.toggleMode();
                                },
                                child: Obx(() => Column(
                                  children: [
                                    Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: !_controller.isSignIn.value ? FontWeight.w600 : FontWeight.w400,
                                        color: !_controller.isSignIn.value ? AppColors.primaryPurple : AppColors.textGray,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      height: 3,
                                      decoration: BoxDecoration(
                                        color: !_controller.isSignIn.value ? AppColors.primaryPurple : Colors.transparent,
                                        borderRadius: const BorderRadius.all(Radius.circular(2)),
                                      ),
                                    ),
                                  ],
                                )),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        // Forms Section
                        Obx(() => _controller.isSignIn.value
                            ? _buildSignInFields()
                            : _buildSignUpFields()),
                        const SizedBox(height: 24),
                        // Sign In / Sign Up button
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: Obx(() => ElevatedButton(
                            onPressed: _controller.isLoading.value ? null : _handleSubmit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryPurple,
                              foregroundColor: AppColors.textBlack,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                            child: _controller.isLoading.value
                                ? const Center(child: CircularProgressIndicator(color: Colors.white))
                                : Text(
                                    _controller.isSignIn.value ? 'Sign In' : 'Sign Up',
                                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                          )),
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: Obx(() => Text(
                            _controller.isSignIn.value ? 'SignUp With Social' : 'Sign in With Social',
                            style: const TextStyle(fontSize: 14, color: AppColors.textGray),
                          )),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildSocialIcon('G', Colors.red),
                            const SizedBox(width: 16),
                            _buildSocialIcon('f', Colors.blue),
                            const SizedBox(width: 16),
                            _buildSocialIcon('in', Colors.blue.shade700),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: TextButton(
                            onPressed: () => Get.offAll(() => const HomeScreen()),
                            child: const Text(
                              'Continue as Guest',
                              style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignInFields() {
    return Column(
      children: [
        TextFormField(
          controller: _controller.usernameController,
          decoration: InputDecoration(
            labelText: 'Self ID',
            hintText: 'e.g., GFC1234567',
            filled: true,
            fillColor: AppColors.backgroundWhite,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primaryPurple, width: 2),
            ),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) return 'Please enter Self ID';
            return null;
          },
        ),
        const SizedBox(height: 16),
        Obx(() => TextFormField(
          controller: _controller.passwordController,
          obscureText: _controller.obscurePassword.value,
          decoration: InputDecoration(
            labelText: 'Password',
            filled: true,
            fillColor: AppColors.backgroundWhite,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primaryPurple, width: 2),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _controller.obscurePassword.value ? Icons.visibility_outlined : Icons.visibility_off_outlined,
              ),
              onPressed: _controller.togglePasswordVisibility,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) return 'Please enter password';
            return null;
          },
        )),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Obx(() => Checkbox(
                  value: _controller.rememberMe.value,
                  onChanged: (value) => _controller.rememberMe.value = value ?? false,
                  activeColor: AppColors.primaryPurple,
                )),
                const Text('Remember me', style: TextStyle(fontSize: 14)),
              ],
            ),
            TextButton(
              onPressed: _handleForgotPassword,
              child: const Text('Forgot password?', style: TextStyle(color: AppColors.primaryPurple, fontSize: 14)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSignUpFields() {
    return Column(
      children: [
        _buildTextField('Glamorous Identification ID*', _controller.glamorousIdController),
        const SizedBox(height: 16),
        _buildTextField('Sponser ID*', _controller.sponsorIdController),
        const SizedBox(height: 16),
        _buildTextField('Sponser Name', _controller.sponsorNameController, isRequired: false),
        const SizedBox(height: 16),
        _buildTextField('Full Name*', _controller.usernameController),
        const SizedBox(height: 16),
        _buildTextField('Email*', _controller.emailController, isEmail: true),
        const SizedBox(height: 16),
        _buildTextField('Mobile Number*', _controller.mobileController, isPhone: true),
        const SizedBox(height: 16),
        Obx(() => TextFormField(
          controller: _controller.passwordController,
          obscureText: _controller.obscurePassword.value,
          decoration: InputDecoration(
            label: RichText(
              text: const TextSpan(
                text: 'Password',
                style: TextStyle(color: AppColors.textGray, fontSize: 16),
                children: [
                  TextSpan(text: '*', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
            filled: true,
            fillColor: AppColors.backgroundWhite,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primaryPurple, width: 2),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _controller.obscurePassword.value ? Icons.visibility_outlined : Icons.visibility_off_outlined,
              ),
              onPressed: _controller.togglePasswordVisibility,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) return 'Please enter password';
            if (value.length < 6) return 'Password must be at least 6 characters';
            return null;
          },
        )),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isRequired = true, bool isEmail = false, bool isPhone = false}) {
    String cleanLabel = label.replaceAll('*', '');
    return TextFormField(
      controller: controller,
      keyboardType: isEmail ? TextInputType.emailAddress : (isPhone ? TextInputType.phone : TextInputType.text),
      decoration: InputDecoration(
        label: RichText(
          text: TextSpan(
            text: cleanLabel,
            style: const TextStyle(color: AppColors.textGray, fontSize: 16),
            children: [
              if (label.endsWith('*'))
                const TextSpan(text: '*', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
        filled: true,
        fillColor: AppColors.backgroundWhite,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryPurple, width: 2),
        ),
      ),
      validator: (value) {
        if (isRequired && (value == null || value.isEmpty)) {
          return 'Please enter $cleanLabel';
        }
        if (isEmail && value != null && value.isNotEmpty && !value.contains('@')) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  Widget _buildSocialIcon(String text, Color color) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
