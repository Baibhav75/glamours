class ProductDetailsResponse {
  bool status;
  String message;
  String categoryName;
  String subCategoryName;
  bool isInCart;
  int qty;
  ProductDetails productDetails;

  ProductDetailsResponse({
    required this.status,
    required this.message,
    required this.categoryName,
    required this.subCategoryName,
    required this.isInCart,
    required this.qty,
    required this.productDetails,
  });

  factory ProductDetailsResponse.fromJson(
      Map<String, dynamic> json) {
    return ProductDetailsResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? "",
      categoryName: json['CategoryName'] ?? "",
      subCategoryName:
      json['SubCategoryName'] ?? "",
      isInCart: json['IsInCart'] ?? false,
      qty: json['QTY'] ?? 1,
      productDetails: ProductDetails.fromJson(
        json['ProductDetails'],
      ),
    );
  }
}

class ProductDetails {
  int id;
  String productId;
  String productName;
  String image1;
  String description;
  String sellingPrice;
  String mrp;
  String catId;
  String subCatId;
  String gst;
  String? sku;
  String currentDate;

  ProductDetails({
    required this.id,
    required this.productId,
    required this.productName,
    required this.image1,
    required this.description,
    required this.sellingPrice,
    required this.mrp,
    required this.catId,
    required this.subCatId,
    required this.gst,
    this.sku,
    required this.currentDate,
  });

  factory ProductDetails.fromJson(
      Map<String, dynamic> json) {
    return ProductDetails(
      id: json['ID'] ?? 0,
      productId: json['ProductId'] ?? "",
      productName: json['ProductName'] ?? "",
      image1: json['Image1'] ?? "",
      description: json['Description'] ?? "",
      sellingPrice:
      json['SellingPrice'] ?? "0",
      mrp: json['MRP'] ?? "0",
      catId: json['CatId'] ?? "",
      subCatId: json['SubCatId'] ?? "",
      gst: json['GST'] ?? "",
      sku: json['SKU'],
      currentDate:
      json['CurrentDate'] ?? "",
    );
  }
}