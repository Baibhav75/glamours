import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/category_model.dart';
import '../Model/change_password_model.dart';
import '../Model/profile_model.dart';
import '../Model/register_model.dart';
import '../Model/signin_model.dart';
import '../Model/wallet_model.dart';
import '../utils/api_constants.dart';

class AuthService {
  Future<SignInModel?> login(String selfId, String password) async {
    try {
      final url = ApiConstants.login(selfId, password);
      print("🚀 Attempting Login at URL: $url");

      final response = await http.get(Uri.parse(url));
      print("📡 Response Status Code: ${response.statusCode}");
      print("📦 Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return SignInModel.fromJson(data);
      } else {
        print("❌ Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("💥 Exception in AuthService.login: $e");
      return null;
    }
  }
  /// 📝 REGISTER
  Future<RegisterModel?> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final url = ApiConstants.register();

      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "UserName": name,
          "Email": email,
          "Password": password,
        }),
      );

      if (response.statusCode == 200) {
        return RegisterModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print("Register Error: $e");
    }
    return null;
  }

  // profile
  Future<ProfileModel?> getProfile(String selfId) async {
    try {
      final url = ApiConstants.getProfile(selfId);

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return ProfileModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print("Profile Error: $e");
    }
    return null;
  }
  // changePassword
  Future<bool> changePassword(ChangePasswordModel model) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.changePassword()),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(model.toJson()),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == true) {
          return true;
        }
      }

    } catch (e) {
      print("Change Password Error: $e");
    }

    return false;
  }

  Future<WalletModel?> getWallet(String selfId) async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.wallet(selfId)),
      );

      if (response.statusCode == 200) {
        return WalletModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print("Wallet Error: $e");
    }

    return null;
  }

  Future<CategoryModel?> getCategories() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.categories()),
      );

      if (response.statusCode == 200) {
        return CategoryModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print("Category Error: $e");
    }

    return null;
  }







}