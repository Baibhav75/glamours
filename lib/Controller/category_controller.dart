import 'package:get/get.dart';
import '../Model/category_model.dart';
import '../utils/auth_service.dart';

class CategoryController extends GetxController {

  final AuthService _service = AuthService();

  var isLoading = false.obs;
  var categories = <CategoryData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;

      final result = await _service.getCategories();

      if (result != null && result.status) {
        categories.value = result.data;
      }

    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}