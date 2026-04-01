import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/Model/change_password_model.dart';
import '/Services/auth_service.dart';

class ChangePasswordController extends GetxController {

  final AuthService _service = AuthService();

  var isLoading = false.obs;

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {

    final box = Hive.box('authBox');
    String selfId = box.get('selfId');

    final model = ChangePasswordModel(
      selfId: selfId,
      oldPassword: oldPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );

    try {
      isLoading.value = true;

      final success = await _service.changePassword(model);

      if (success) {
        Get.snackbar("Success", "Password changed successfully");
        Get.back();
      } else {
        Get.snackbar("Error", "Failed to change password");
      }

    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}