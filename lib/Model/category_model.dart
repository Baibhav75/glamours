class CategoryModel {
  final bool status;
  final String message;
  final List<CategoryData> data;

  CategoryModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List)
          .map((e) => CategoryData.fromJson(e))
          .toList(),
    );
  }
}

class CategoryData {
  final int id;
  final String catId;
  final String name;
  final String image;

  CategoryData({
    required this.id,
    required this.catId,
    required this.name,
    required this.image,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      id: json['ID'],
      catId: json['CatId'],
      name: json['CategoryName'],
      image: json['Image'],
    );
  }
}