import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    required this.categoryID,
    required this.categoryImage,
    required this.categoryName,
  });

  String categoryID;
  String categoryImage;
  String categoryName;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        categoryID: json["categoryID"],
        categoryImage: json["categoryImage"],
        categoryName: json["categoryName"],
      );

  Map<String, dynamic> toJson() => {
        "categoryID": categoryID,
        "categoryImage": categoryImage,
        "categoryName": categoryName,
      };
}
