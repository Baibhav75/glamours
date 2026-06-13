class CartModel {

  final int id;
  final String productId;
  final String productName;
  final String uniqueId;
  final double listedPrice;
  final double sellingPrice;
  final int qty;
  final String image;
  final String gst;
  final String productPoint;
  final dynamic productPercentage;

  CartModel({

    required this.id,
    required this.productId,
    required this.productName,
    required this.uniqueId,
    required this.listedPrice,
    required this.sellingPrice,
    required this.qty,
    required this.image,
    required this.gst,
    required this.productPoint,
    required this.productPercentage,
  });

  factory CartModel.fromJson(
      Map<String, dynamic> json) {

    return CartModel(

      id: json['ID'] ?? 0,

      productId:
      json['ProductID'] ?? '',

      productName:
      json['ProductName'] ?? '',

      uniqueId:
      json['UniqueID'] ?? '',

      listedPrice:
      (json['listedPrice'] ?? 0)
          .toDouble(),

      sellingPrice:
      (json['SellingPrice'] ?? 0)
          .toDouble(),

      qty: json['QTY'] ?? 1,

      image: json['Image'] ?? '',

      gst: json['GST'] ?? '',

      productPoint:
      json['ProductPoint'] ?? '',

      productPercentage:
      json['ProductPercentage'],
    );
  }
}