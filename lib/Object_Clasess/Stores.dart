import 'dart:convert';

StoresModel storesModelFromJson(String str) =>
    StoresModel.fromJson(json.decode(str));

String storesModelToJson(StoresModel data) => json.encode(data.toJson());

class StoresModel {
  StoresModel({
    required this.storeId,
    required this.storeImage,
    required this.storeName,
  });

  String storeId;
  String storeImage;
  String storeName;

  factory StoresModel.fromJson(Map<String, dynamic> json) => StoresModel(
    storeId: json["storeId"],
    storeImage: json["storeImage"],
    storeName: json["storeName"],
  );

  Map<String, dynamic> toJson() => {
    "storeId": storeId,
    "storeImage": storeImage,
    "storeName": storeName,
  };
}
