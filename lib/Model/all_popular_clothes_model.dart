class AllPopularClothesResponse {
  final bool status;
  final String message;
  final List<Product> products;

  AllPopularClothesResponse({
    required this.status,
    required this.message,
    required this.products,
  });

  factory AllPopularClothesResponse.fromJson(Map<String, dynamic> json) {
    final statusVal = json['status'] ?? json['Status'] ?? false;
    final bool parsedStatus = statusVal == true || statusVal == "true" || statusVal == "True";

    return AllPopularClothesResponse(
      status: parsedStatus,
      message: json['message'] ?? json['Message'] ?? '',
      products: ((json['data'] ?? json['Data'] ?? []) as List)
          .map((e) => Product.fromJson(e))
          .toList(),
    );
  }
}

class Product {
  final int id;
  final String productId;
  final String productName;
  final String mrp;
  final String sellingPrice;
  final String description;
  final String image1;
  final String? videoUrl;

  final String? catId;
  final String? subCatId;
  final String? gst;
  final String? productType;
  final int? franchisePrice;
  final int? productPoint;

  Product({
    required this.id,
    required this.productId,
    required this.productName,
    required this.mrp,
    required this.sellingPrice,
    required this.description,
    required this.image1,
    this.videoUrl,
    this.catId,
    this.subCatId,
    this.gst,
    this.productType,
    this.franchisePrice,
    this.productPoint,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['ID'] ?? 0,
      productId: json['ProductId']?.toString() ?? '',
      productName: json['ProductName']?.toString() ?? '',
      mrp: json['MRP']?.toString() ?? '0',
      sellingPrice: json['SellingPrice']?.toString() ?? '0',
      description: json['Description']?.toString() ?? '',
      image1: json['Image1']?.toString() ?? '',
      videoUrl: json['VideoURL']?.toString(),
      catId: json['CatId']?.toString(),
      subCatId: json['SubCatId']?.toString(),
      gst: json['GST']?.toString(),
      productType: json['ProductType']?.toString(),
      franchisePrice: json['FranchisePrice'] != null ? int.tryParse(json['FranchisePrice'].toString()) : null,
      productPoint: json['ProductPoint'] != null ? int.tryParse(json['ProductPoint'].toString()) : null,
    );
  }
}