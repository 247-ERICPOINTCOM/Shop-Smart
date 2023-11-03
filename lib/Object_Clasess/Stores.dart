import 'dart:convert';

StoresModel storesModelFromJson(String str) =>
    StoresModel.fromJson(json.decode(str));

String storesModelToJson(StoresModel data) => json.encode(data.toJson());

class StoresModel {
  StoresModel({
    required this.storeID,
    required this.storeImage,
    required this.storeName,
  });

  String storeID;
  String storeImage;
  String storeName;

  factory StoresModel.fromJson(Map<String, dynamic> json) => StoresModel(
    storeID: json["storeID"],
    storeImage: json["storeImage"],
    storeName: json["storeName"],
  );

  Map<String, dynamic> toJson() => {
    "storeID": storeID,
    "storeImage": storeImage,
    "storeName": storeName,
  };
}
