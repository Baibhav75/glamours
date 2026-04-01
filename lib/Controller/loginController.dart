import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../Services/auth_service.dart';
import '../Model/signin_model.dart';
import '../View/HomeScreen.dart';
import '../View/SignInScreen.dart';

class LoginController extends GetxController {
  final AuthService _authService = AuthService();
  
  var isLoading = false.obs;
  var isSignIn = true.obs; 
  var rememberMe = true.obs;
  var obscurePassword = true.obs;

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void toggleMode() {
    isSignIn.value = !isSignIn.value;
    rememberMe.value = isSignIn.value;
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  /// 🔓 LOGOUT & CLEAN DATA
  Future<void> logout() async {
    try {
      var box = Hive.box('authBox');
      await box.clear(); // 🔥 Completely wipe data
      
      Get.snackbar(
        'Logged Out',
        'You have been successfully logged out.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black87,
        colorText: Colors.white,
      );
      
      Get.offAll(() => const SignInScreen());
    } catch (e) {
      print("Logout Error: $e");
    }
  }

  /// 🚀 LOGIN
  Future<void> handleLogin() async {
    try {
      isLoading.value = true;
      
      // Cleanup previous potential stale data
      var box = Hive.box('authBox');
      await box.clear();

      final result = await _authService.login(
        usernameController.text.trim(),
        passwordController.text.trim(),
      );

      if (result != null && result.status && result.data != null) {
        if (rememberMe.value) {
          await box.put('isLoggedIn', true);
          await box.put('selfId', result.data!.selfId);
          await box.put('name', result.data!.fullName);
        }

        Get.snackbar(
          'Success',
          'Welcome back, ${result.data!.fullName}!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.offAll(() => const HomeScreen());
      } else {
        Get.snackbar(
          'Login Error',
          result?.message ?? 'Invalid credentials. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Network Error',
        'Could not connect to the server. Please check your internet.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// 📝 SIGN UP
  Future<void> handleSignUp() async {
    try {
      isLoading.value = true;
      final result = await _authService.register(
        name: usernameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (result != null && result.status) {
        Get.snackbar(
          'Account Created',
          'Please sign in with your new credentials.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        isSignIn.value = true; 
      } else {
        Get.snackbar(
          'Registration Error',
          result?.message ?? 'Failed to create account.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong during registration.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Removed onClose to prevent TextEditingController disposal conflicts during Hot Reload or rapid navigation
}
