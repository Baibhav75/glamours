class OrderListModel {
  final bool status;
  final String message;
  final List<OrderDateGroup> data;

  OrderListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory OrderListModel.fromJson(Map<String, dynamic> json) {
    return OrderListModel(
      status: json['status'] ?? false,
      message: json['message'] ?? "",
      data: (json['data'] as List? ?? [])
          .map((e) => OrderDateGroup.fromJson(e))
          .toList(),
    );
  }
}

class OrderDateGroup {
  final String date;
  final List<OrderItem> orders;

  OrderDateGroup({
    required this.date,
    required this.orders,
  });

  factory OrderDateGroup.fromJson(Map<String, dynamic> json) {
    return OrderDateGroup(
      date: json['Date'] ?? "",
      orders: (json['Orders'] as List? ?? [])
          .map((e) => OrderItem.fromJson(e))
          .toList(),
    );
  }
}

class OrderItem {
  final int id;
  final String orderId;
  final String productName;
  final String qty;
  final String amount;
  final String status;
  final String date;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.productName,
    required this.qty,
    required this.amount,
    required this.status,
    required this.date,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['Id'] ?? 0,

      orderId: json['OrderID'] ?? "",

      productName: json['ProductName'] ?? "No Product",

      /// 🔥 FIX (important)
      qty: json['QTY']?.toString() ?? "0",

      /// 🔥 FIX (important)
      amount: json['SellingPrice']?.toString() ?? "0",

      status: json['OrderStatus'] ?? "Unknown",

      date: json['CreateDate'] ?? "",
    );
  }
}