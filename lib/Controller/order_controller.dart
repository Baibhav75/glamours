import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../Model/order_model.dart';
import '../utils/auth_service.dart';

class OrderController extends GetxController {

  final AuthService _service = AuthService();

  var isLoading = false.obs;
  var orders = <OrderItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;

      final box = Hive.box('authBox');
      String? selfId = box.get('selfId');

      print("SelfId: $selfId"); // 🔥 ADD HERE

      if (selfId == null) return;

      final result = await _service.getOrders(selfId);

      /// 🔥 ADD HERE
      print("API Result: ${result?.message}");
      print("Orders Count: ${result?.data.length}");

      if (result != null && result.status) {

        List<OrderItem> temp = [];

        for (var group in result.data) {
          temp.addAll(group.orders);
        }

        print("Flatten Orders Count: ${temp.length}"); // 🔥 ADD

        orders.value = temp;
      }

    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}