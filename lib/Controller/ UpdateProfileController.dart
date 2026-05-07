import 'package:get/get.dart';
import '/Model/UpdateProfileModel.dart';
import '/utils/auth_service.dart';

class Profilecontroller extends GetxController {

  var isLoading = false.obs;

  Future<void> updateUserProfile(UpdateProfileRequest request) async {
    try {
      isLoading.value = true;

      bool success = await AuthService.updateProfile(request);

      if (success) {
        Get.snackbar("Success", "Profile Updated Successfully");
      } else {
        Get.snackbar("Error", "Update Failed");
      }

    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}