import '/Model/all_popular_clothes_model.dart';
import '/utils/auth_service.dart';
import 'package:get/get.dart';

class AllPopularClothesController extends GetxController {
  final AuthService _service = AuthService();

  /// 🔄 Loading
  final RxBool isLoading = false.obs;

  /// 📦 Product list
  final RxList<Product> productList = <Product>[].obs;

  /// ❌ Error message
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  /// 📡 API Call
  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _service.getProducts();

      if (response != null && response.status) {
        productList.assignAll(response.products);
      } else {
        errorMessage.value = "Failed to load products";
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  /// 🔄 Pull to Refresh
  Future<void> refreshProducts() async {
    await fetchProducts();
  }
}