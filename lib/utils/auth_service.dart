import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/AutoPoolMemberModel.dart';
import '../Model/LevelIncomeModel.dart';
import '../Model/LevelTeamListModel.dart';
import '../Model/PoolIncomeModel.dart';
import '../Model/ReferralLinkModel.dart';
import '../Model/RewardIncomeModel.dart';
import '../Model/ShoppingLevelIncomeModel.dart';
import '../Model/WelcomeLetterModel.dart';
import '../Model/WithdrawAmountModel.dart';
import '../Model/all_popular_clothes_model.dart';
import '../Model/category_model.dart';
import '../Model/change_password_model.dart';
import '../Model/order_model.dart';
import '../Model/profile_model.dart';
import '../Model/register_model.dart';
import '../Model/signin_model.dart';
import '../Model/wallet_model.dart';
import 'api_constants.dart';
import '/Model/UpdateProfileModel.dart';

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
    required String fullName,
    required String email,
    required String password,
    required String identifyId,
    required String sponserId,
  }) async {
    try {
      final url = ApiConstants.register();

      final body = {
        "FullName": fullName,
        "Email": email,
        "Password": password,
        "IdentifyId": identifyId,
        "SponserId": sponserId,
      };

      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return RegisterModel.fromJson(jsonDecode(response.body));
      } else {
        print("Error: ${response.body}");
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

  Future<AllPopularClothesResponse?> getProducts() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.getProducts),
      );

      print("API STATUS: ${response.statusCode}");
      print("API BODY: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        /// 🔥 important safety check
        final statusVal = data['status'] ?? data['Status'] ?? false;
        final bool parsedStatus = statusVal == true || statusVal == "true" || statusVal == "True";

        if (parsedStatus) {
          return AllPopularClothesResponse.fromJson(data);
        } else {
          print("API returned status false");
          return null;
        }
      } else {
        print("API failed with status code");
        return null;
      }
    } catch (e) {
      print("API ERROR: $e");
      return null;
    }
  }

  Future<AllPopularClothesResponse?> getProductsByCatId(String catId) async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.getProductsByCategory(catId)),
      );

      print("API STATUS: ${response.statusCode}");
      print("API BODY: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final statusVal = data['status'] ?? data['Status'] ?? false;
        final bool parsedStatus = statusVal == true || statusVal == "true" || statusVal == "True";

        if (parsedStatus) {
          return AllPopularClothesResponse.fromJson(data);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print("API ERROR: $e");
      return null;
    }
  }

  Future<OrderListModel?> getOrders(String selfId) async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.orderList(selfId)),
      );

      if (response.statusCode == 200) {
        return OrderListModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print("Order Error: $e");
    }

    return null;
  }

  // updated profile
  static Future<bool> updateProfile(UpdateProfileRequest request) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.updateProfile),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(request.toJson()),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {
        return true;
      } else {
        print("Error: ${data['message']}");
        return false;
      }

    } catch (e) {
      print("Exception: $e");
      return false;
    }
  }
  Future<List<RewardIncomeModel>> getRewardIncome() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.rewardIncome),
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == true) {
          List list = data['data'];

          return list
              .map((e) => RewardIncomeModel.fromJson(e))
              .toList();
        } else {
          throw Exception("API Error: ${data['message']}");
        }
      } else {
        throw Exception("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to fetch reward income: $e");
    }
  }

  Future<List<PoolIncomeModel>> getPoolIncome(String selfId) async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.poolIncome(selfId)),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == true) {
          List list = data['data'];

          return list
              .map((e) => PoolIncomeModel.fromJson(e))
              .toList();
        } else {
          throw Exception(data['message']);
        }
      } else {
        throw Exception("Server error ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Pool income fetch failed: $e");
    }
  }
  Future<List<LevelIncomeModel>> getLevelIncome(
      String selfId) async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.levelIncome(selfId)),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == true) {

          List list = data['data'];

          return list
              .map((e) => LevelIncomeModel.fromJson(e))
              .toList();

        } else {
          throw Exception(data['message']);
        }
      } else {
        throw Exception(
            "Server Error ${response.statusCode}");
      }
    } catch (e) {
      throw Exception(
          "Failed to fetch level income: $e");
    }
  }
  Future<List<WithdrawAmountModel>>
  getWithdrawAmount(String selfId) async {

    try {

      final response = await http.get(
        Uri.parse(
          ApiConstants.withdrawAmount(selfId),
        ),
      );

      if (response.statusCode == 200) {

        final data = jsonDecode(response.body);

        if (data['status'] == true) {

          List list = data['data'];

          return list
              .map(
                (e) => WithdrawAmountModel.fromJson(e),
          )
              .toList();

        } else {

          throw Exception(data['message']);
        }

      } else {

        throw Exception(
          "Server Error ${response.statusCode}",
        );
      }

    } catch (e) {

      throw Exception(
        "Withdraw fetch failed: $e",
      );
    }
  }

  Future<List<LevelTeamListModel>>
  getLevelTeamList(String selfId) async {

    try {

      final response = await http.get(
        Uri.parse(
          ApiConstants.levelTeamList(selfId),
        ),
      );

      if (response.statusCode == 200) {

        final data = jsonDecode(response.body);

        if (data['status'] == true) {

          List list = data['data'];

          return list
              .map(
                (e) =>
                LevelTeamListModel.fromJson(e),
          )
              .toList();

        } else {

          throw Exception(data['message']);
        }

      } else {

        throw Exception(
          "Server Error ${response.statusCode}",
        );
      }

    } catch (e) {

      throw Exception(
        "Level Team fetch failed: $e",
      );
    }
  }
  Future<ReferralLinkModel>
  getReferralLink(String selfId) async {

    try {

      final response = await http.get(
        Uri.parse(
          ApiConstants.referralLink(selfId),
        ),
      );

      if (response.statusCode == 200) {

        final data = jsonDecode(response.body);

        if (data['status'] == true) {

          return ReferralLinkModel.fromJson(
            data['data'],
          );

        } else {

          throw Exception(data['message']);
        }

      } else {

        throw Exception(
          "Server Error ${response.statusCode}",
        );
      }

    } catch (e) {

      throw Exception(
        "Referral link fetch failed: $e",
      );
    }
  }
  Future<WelcomeLetterModel>
  getWelcomeLetter(String selfId) async {

    try {

      final response = await http.get(
        Uri.parse(
          ApiConstants.welcomeLetter(selfId),
        ),
      );

      if (response.statusCode == 200) {

        final data = jsonDecode(response.body);

        if (data['status'] == true) {

          return WelcomeLetterModel.fromJson(
            data['data'],
          );

        } else {

          throw Exception(data['message']);
        }

      } else {

        throw Exception(
          "Server Error ${response.statusCode}",
        );
      }

    } catch (e) {

      throw Exception(
        "Welcome letter fetch failed: $e",
      );
    }
  }
  Future<List<AutoPoolMemberModel>>
  getAutoPoolList(

      String selfId,
      String type,

      ) async {

    try {

      final response = await http.get(

        Uri.parse(
          ApiConstants.autoPoolList(
            selfId,
            type,
          ),
        ),
      );

      if (response.statusCode == 200) {

        final data = jsonDecode(response.body);

        if (data['status'] == true) {

          List list = data['data'];

          return list

              .map(
                (e) =>
                AutoPoolMemberModel.fromJson(e),
          )

              .toList();

        } else {

          throw Exception(
            data['message'],
          );
        }

      } else {

        throw Exception(
          "Server Error ${response.statusCode}",
        );
      }

    } catch (e) {

      throw Exception(
        "Auto Pool fetch failed: $e",
      );
    }
  }



  Future<List<ShoppingLevelIncomeModel>>
  getShoppingLevelIncome(
      String selfId,
      ) async {

    try {

      final response = await http.get(

        Uri.parse(
          ApiConstants.shoppingLevelIncome(
            selfId,
          ),
        ),
      );

      if (response.statusCode == 200) {

        final data = jsonDecode(response.body);

        if (data['status'] == true) {

          List list = data['data'];

          return list

              .map(
                (e) =>
                ShoppingLevelIncomeModel
                    .fromJson(e),
          )

              .toList();

        } else {

          throw Exception(
            data['message'],
          );
        }

      } else {

        throw Exception(
          "Server Error ${response.statusCode}",
        );
      }

    } catch (e) {

      throw Exception(
        "Shopping Level Income fetch failed: $e",
      );
    }
  }
}
