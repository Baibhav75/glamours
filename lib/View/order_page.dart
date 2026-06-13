import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Model/order_model.dart';
import '../controller/order_controller.dart';
import '../theme/app_colors.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final controller = Get.put(OrderController());
  int selectedTab = 0;

  List<String> tabs = ["Pending", "Progress", "Delivered"];

  /// FILTER FUNCTION
  List<OrderItem> filteredOrders() {
    if (selectedTab == 0) {
      return controller.orders
          .where((e) => e.orderStatus.toLowerCase() == "pending")
          .toList();
    } else if (selectedTab == 1) {
      return controller.orders
          .where((e) => e.orderStatus.toLowerCase() == "progress")
          .toList();
    } else {
      return controller.orders
          .where((e) => e.orderStatus.toLowerCase() == "delivered")
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Orders",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white, // AppBar title text white
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primaryGold,
        foregroundColor: Colors.white, // Set foreground color to white
        iconTheme: const IconThemeData(color: Colors.white), // Back button white
      ),
      body: Column(
        children: [
          /// TABS SECTION
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            height: 45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: tabs.length,
              itemBuilder: (context, index) {
                bool selected = selectedTab == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTab = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    decoration: BoxDecoration(
                      color: selected ? AppColors.primaryGold : Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: selected ? AppColors.primaryGold : Colors.grey.shade300,
                        width: 1.5,
                      ),
                      boxShadow: selected
                          ? [
                        BoxShadow(
                          color: AppColors.primaryGold.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        )
                      ]
                          : null,
                    ),
                    child: Text(
                      "${tabs[index]} (${getCountByStatus(tabs[index])})",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: selected ? Colors.white : Colors.grey.shade700, // Selected tab text white
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 4),

          /// ORDER LIST
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryGold),
                  ),
                );
              }

              final data = filteredOrders();

              if (data.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inbox_outlined,
                        size: 80,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "No Orders Found",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: DataTable(
                      headingRowColor: MaterialStateProperty.all(
                        AppColors.primaryGold,
                      ),
                      headingTextStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.white, // Header text white
                      ),
                      dataRowMinHeight: 60,
                      dataRowMaxHeight: 80,
                      columnSpacing: 16,
                      horizontalMargin: 16,
                      columns: const [
                        DataColumn(label: Text("Sr No")),
                        DataColumn(label: Text("Create Date")),
                        DataColumn(label: Text("Order ID")),
                        DataColumn(label: Text("Customer Name")),
                        DataColumn(label: Text("Mobile")),
                        DataColumn(label: Text("Product")),
                        DataColumn(label: Text("Qty")),
                        DataColumn(label: Text("Amount")),
                        DataColumn(label: Text("Pay Mode")),
                        DataColumn(label: Text("Screenshot")),
                        DataColumn(label: Text("Status")),
                        DataColumn(label: Text("Invoice")),
                      ],
                      rows: data.asMap().entries.map<DataRow>((entry) {
                        int index = entry.key;
                        OrderItem item = entry.value;
                        return DataRow(
                          cells: [
                            /// Sr No
                            DataCell(
                              Container(
                                width: 40,
                                alignment: Alignment.center,
                                child: Text(
                                  "${index + 1}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: Colors.black87, // Sr no text color
                                  ),
                                ),
                              ),
                            ),
                            /// Create Date
                            DataCell(
                              Text(
                                formatDate(item.createDate),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            /// Order ID
                            DataCell(
                              Text(
                                item.orderID,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            /// Customer Name
                            DataCell(
                              Text(
                                item.customerName,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            /// Mobile
                            DataCell(
                              Text(
                                item.customerNumber,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            /// Product
                            DataCell(
                              SizedBox(
                                width: 150,
                                child: Text(
                                  item.productName,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black87,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            /// Qty
                            DataCell(
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  item.qty,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blue.shade700,
                                  ),
                                ),
                              ),
                            ),
                            /// Amount
                            DataCell(
                              Text(
                                "₹${item.totalOrderAmount}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            /// Pay Mode
                            DataCell(
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: item.paymentMode.toLowerCase() == "online"
                                      ? Colors.purple.shade50
                                      : Colors.orange.shade50,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  item.paymentMode,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: item.paymentMode.toLowerCase() == "online"
                                        ? Colors.purple.shade700
                                        : Colors.orange.shade700,
                                  ),
                                ),
                              ),
                            ),
                            /// Screenshot
                            DataCell(
                              item.paymentScreenshot != null && item.paymentScreenshot!.isNotEmpty
                                  ? GestureDetector(
                                onTap: () {
                                  _showScreenshotDialog(context, item.paymentScreenshot!);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.image,
                                        size: 16,
                                        color: Colors.blue.shade700,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        "View",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.blue.shade700,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                                  : Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  "No SS",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                            ),
                            /// Status
                            DataCell(
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: getStatusColor(item.orderStatus).withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: getStatusColor(item.orderStatus),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      item.orderStatus,
                                      style: TextStyle(
                                        color: getStatusColor(item.orderStatus),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            /// Invoice Button
                            DataCell(
                              ElevatedButton.icon(
                                onPressed: () {
                                  _generateInvoice(item);
                                },
                                icon: const Icon(
                                  Icons.receipt,
                                  size: 16,
                                  color: Colors.white, // Icon white
                                ),
                                label: const Text(
                                  "Invoice",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white, // Button text white
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryGold,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  minimumSize: const Size(70, 32),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  int getCountByStatus(String status) {
    String statusLower = status.toLowerCase();
    return controller.orders
        .where((e) => e.orderStatus.toLowerCase() == statusLower)
        .length;
  }

  String formatDate(String dateStr) {
    if (dateStr.isEmpty) return "";
    try {
      DateTime date = DateTime.parse(dateStr);
      return "${date.day}/${date.month}/${date.year}";
    } catch (e) {
      return dateStr;
    }
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "pending":
        return Colors.orange;
      case "progress":
        return Colors.blue;
      case "delivered":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void _showScreenshotDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Payment Screenshot",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrl,
                    height: 400,
                    width: 300,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        color: Colors.grey.shade200,
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.broken_image,
                                size: 50,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 8),
                              Text("Failed to load image"),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGold,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Close"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _generateInvoice(OrderItem order) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Generate Invoice",
            style: TextStyle(color: Colors.black87),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Order ID: ${order.orderID}", style: const TextStyle(color: Colors.black87)),
              const SizedBox(height: 8),
              Text("Customer: ${order.customerName}", style: const TextStyle(color: Colors.black87)),
              const SizedBox(height: 8),
              Text("Amount: ₹${order.totalOrderAmount}", style: const TextStyle(color: Colors.black87)),
              const SizedBox(height: 8),
              Text("Product: ${order.productName}", style: const TextStyle(color: Colors.black87)),
              const SizedBox(height: 8),
              Text("Quantity: ${order.qty}", style: const TextStyle(color: Colors.black87)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Invoice generated for Order ${order.orderID}"),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGold,
                foregroundColor: Colors.white,
              ),
              child: const Text("Generate"),
            ),
          ],
        );
      },
    );
  }
}