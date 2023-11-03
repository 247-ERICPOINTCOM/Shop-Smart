import 'dart:convert';
import 'package:geopoint/geopoint.dart';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    required this.productImage,
    required this.productID,
    required this.productName,
    required this.productPrice,
    required this.productDescription,
    required this.productQuantity,
    required this.businessOwnerUID,
    required this.productLocation,
    required this.productPickupLocation,
  });

  String productImage;
  String productID;
  String productName;
  double productPrice;
  String productDescription;
  int? productQuantity;
  String businessOwnerUID;
  GeoPoint productLocation; // Use GeoPoint for location
  String productPickupLocation; // Add pickup location field

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        productID: json["productID"],
        productName: json["productName"],
        productDescription: json["productDescription"],
        productImage: json["productImage"],
        productQuantity: json["productQuantity"],
        productPrice: double.parse(json["productPrice"].toString()),
        businessOwnerUID: json["businessOwnerUid"],
        productLocation: json["productLocation"],
        productPickupLocation: json["productPickupLocation"],
      );

  Map<String, dynamic> toJson() => {
        "productID": productID,
        "productName": productName,
        "productDescription": productDescription,
        "productImage": productImage,
        "productPrice": productPrice,
        "productQuantity": productQuantity,
        "businessOwnerUID": businessOwnerUID,
        "productLocation": productLocation,
        "productPickupLocation": productPickupLocation,
      };

  ProductModel copyWith({
    int? productQuantity,
  }) =>
      ProductModel(
        productID: productID,
        productName: productName,
        productDescription: productDescription,
        productImage: productImage,
        productQuantity: productQuantity ?? this.productQuantity,
        productPrice: productPrice,
        businessOwnerUID: businessOwnerUID,
        productLocation: productLocation,
        productPickupLocation: productPickupLocation,
      );
}
