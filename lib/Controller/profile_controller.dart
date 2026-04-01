import 'package:get/get.dart';
import '../Services/auth_service.dart';
import '../Model/profile_model.dart';

class ProfileController extends GetxController {

  final AuthService _service = AuthService();

  var isLoading = false.obs;

  /// 🔥 FIXED
  var profile = Rx<ProfileModel?>(null);

  Future<void> fetchProfile(String selfId) async {
    try {
      isLoading.value = true;

      final result = await _service.getProfile(selfId);

      if (result != null) {
        profile.value = result;
        if (result.data == null) {
          print("Fetch Profile: result received but data is null. Message: ${result.message}");
        } else {
          print("Fetch Profile: data received successfully for ${result.data!.fullName}");
        }
      } else {
        print("Fetch Profile failed: result is null (Service returned null or exception occurred)");
      }

    } catch (e) {
      print("Controller Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}