class OrderListModel {
  final bool status;
  final String message;
  final List<OrderDateGroup> data;

  OrderListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory OrderListModel.fromJson(
      Map<String, dynamic> json) {
    return OrderListModel(
      status: json['status'] ?? false,
      message: json['message'] ?? "",
      data: (json['data'] as List? ?? [])
          .map(
            (e) => OrderDateGroup.fromJson(e),
      )
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

  factory OrderDateGroup.fromJson(
      Map<String, dynamic> json,
      ) {
    return OrderDateGroup(
      date: json['Date'] ?? "",
      orders: (json['Orders'] as List? ?? [])
          .map(
            (e) => OrderItem.fromJson(e),
      )
          .toList(),
    );
  }
}

class OrderItem {
  final int id;
  final String orderID;
  final String customerName;
  final String customerNumber;
  final String shippingAddress;
  final String createDate;
  final String orderStatus;
  final String paymentMode;
  final String totalOrderAmount;
  final String productName;
  final String qty;
  final String sellingPrice;
  final String? paymentScreenshot;

  OrderItem({
    required this.id,
    required this.orderID,
    required this.customerName,
    required this.customerNumber,
    required this.shippingAddress,
    required this.createDate,
    required this.orderStatus,
    required this.paymentMode,
    required this.totalOrderAmount,
    required this.productName,
    required this.qty,
    required this.sellingPrice,
    this.paymentScreenshot,
  });

  factory OrderItem.fromJson(
      Map<String, dynamic> json) {
    return OrderItem(
      id: json['Id'] ?? 0,
      orderID: json['OrderID'] ?? "",
      customerName:
      json['CustomerName'] ?? "",
      customerNumber:
      json['CustomerNumber'] ?? "",
      shippingAddress:
      json['ShippingAddress'] ?? "",
      createDate:
      json['CreateDate'] ?? "",
      orderStatus:
      json['OrderStatus'] ?? "",
      paymentMode:
      json['PaymentMode'] ?? "",
      totalOrderAmount:
      json['TotalOrderAmount'] ?? "",
      productName:
      json['ProductName'] ?? "",
      qty: json['QTY'] ?? "",
      sellingPrice:
      json['SellingPrice'] ?? "",
      paymentScreenshot:
      json['PaymentScreenshot'],
    );
  }
}