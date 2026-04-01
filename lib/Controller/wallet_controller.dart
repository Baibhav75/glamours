import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../Model/wallet_model.dart';
import '../Services/auth_service.dart';

class WalletController extends GetxController {
  final AuthService _service = AuthService();

  var isLoading = false.obs;
  var wallet = Rxn<WalletModel>();

  @override
  void onInit() {
    super.onInit();
    refreshWallet();
  }

  Future<void> refreshWallet() async {
    final box = Hive.box('authBox');
    String? selfId = box.get('selfId');

    if (selfId != null) {
      print("WalletController: Fetching wallet for SelfId: $selfId");
      await fetchWallet(selfId);
    } else {
      print("WalletController: No SelfId found in Hive storage.");
    }
  }

  Future<void> fetchWallet(String selfId) async {
    try {
      isLoading.value = true;

      final result = await _service.getWallet(selfId);

      if (result != null) {
        wallet.value = result;
        if (result.status) {
          print("WalletController: Wallet data fetched successfully.");
        } else {
          print("WalletController: API returned status false. Message: ${result.message}");
        }
      } else {
        print("WalletController: Result is null (Service returned null).");
      }
    } catch (e) {
      print("WalletController Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}