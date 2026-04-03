import 'package:get/get.dart';
import '/Model/all_popular_clothes_model.dart';
import '../utils/auth_service.dart';

class PopularCategoryController extends GetxController {
  final AuthService _authService = AuthService();
  final String catId;

  PopularCategoryController({required this.catId});

  var isLoading = false.obs;
  var productList = <Product>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProductsByCategory();
  }

  Future<void> fetchProductsByCategory() async {
    try {
      isLoading(true);
      errorMessage('');

      final response = await _authService.getProductsByCatId(catId);

      if (response != null && response.status == true) {
        productList.assignAll(response.products);
      } else {
        errorMessage('Failed to load products');
      }
    } catch (e) {
      errorMessage('An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshProducts() async {
    await fetchProductsByCategory();
  }
}
