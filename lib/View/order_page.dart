import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/order_controller.dart';
import '../theme/app_colors.dart';
import 'order_details_page.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  final controller = Get.put(OrderController());

  int selectedTab = 0;

  List<String> tabs = [
    "Pending",
    "Progress",
    "Delivered"
  ];

  /// 🔥 FILTER FUNCTION
  List filteredOrders() {
    if (selectedTab == 0) {
      return controller.orders
          .where((e) => e.status == "Pending")
          .toList();
    } else if (selectedTab == 1) {
      return controller.orders
          .where((e) => e.status == "Progress")
          .toList();
    } else {
      return controller.orders
          .where((e) => e.status == "Delivered")
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text("Orders"),
        centerTitle: true,
      ),

      body: Column(
        children: [

          /// 🔥 TABS
          SizedBox(
            height: 45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tabs.length,
              itemBuilder: (context,index){

                bool selected = selectedTab == index;

                return GestureDetector(
                  onTap: (){
                    setState(() {
                      selectedTab = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.primaryGold
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      tabs[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: selected
                            ? AppColors.textBlack
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          /// 🔥 ORDER LIST
          Expanded(
            child: Obx(() {

              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              final data = filteredOrders();

              if (data.isEmpty) {
                return const Center(child: Text("No Orders Found"));
              }

              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context,index){

                  final item = data[index];

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal:16, vertical:8),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(blurRadius:4, color: Colors.black12)
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        /// 🔥 TOP ROW
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                item.productName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Text(
                              "₹${item.amount}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        /// 🔥 DETAILS
                        Text("Qty : ${item.qty}"),
                        Text("Order ID : ${item.orderId}"),

                        const SizedBox(height: 6),

                        Text(
                          item.date,
                          style: const TextStyle(color: Colors.grey),
                        ),

                        const SizedBox(height: 12),

                        /// 🔥 BUTTON + STATUS
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const OrderDetailsPage(),
                                  ),
                                );
                              },
                              child: const Text("View Details"),
                            ),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: item.status == "Pending"
                                    ? Colors.orange.withOpacity(0.1)
                                    : item.status == "Progress"
                                    ? Colors.blue.withOpacity(0.1)
                                    : Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                item.status,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: item.status == "Pending"
                                      ? Colors.orange
                                      : item.status == "Progress"
                                      ? Colors.blue
                                      : Colors.green,
                                ),
                              ),
                            )
                          ],
                        )

                      ],
                    ),
                  );
                },
              );
            }),
          )
        ],
      ),
    );
  }
}