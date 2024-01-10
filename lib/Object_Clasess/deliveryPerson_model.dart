import 'dart:convert';

DeliveryPersonModel userModelFromJson(String str) => DeliveryPersonModel.fromJson(json.decode(str));

String userModelToJson(DeliveryPersonModel data) => json.encode(data.toJson());

class DeliveryPersonModel {
  DeliveryPersonModel({
    this.userImage,
    required this.userID,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.userType,
    required this.userFirstName,
    required this.userLastName,
  });

  String? userImage;
  String userID;
  String userName;
  String userEmail;
  String userPhone;
  String userType;
  String userFirstName;
  String userLastName;

  factory DeliveryPersonModel.fromJson(Map<String, dynamic> json) => DeliveryPersonModel(
    userID: json["userID"],
    userImage: json["userImage"],
    userName: json["userName"],
    userEmail: json["userEmail"],
    userPhone: json["userPhone"],
    userType: json["userType"],
    userFirstName: json["userFirstName"],
    userLastName: json["userLastName"],
  );

  Map<String, dynamic> toJson() => {
    "userID": userID,
    "userImage": userImage,
    "userName": userName,
    "userEmail": userEmail,
    "userPhone": userPhone,
    "userType": userType,
    "userFirstName": userFirstName,
    "userLastName": userLastName,
  };

  DeliveryPersonModel copyWith({
    String? userName,
    userImage,
    userPhone,
    userType,
    userFirstName,
    userLastName,
  }) =>
      DeliveryPersonModel(
        userID: userID,
        userEmail: userEmail,
        userName: userName ?? this.userName,
        userImage: userImage ?? this.userImage,
        userPhone: userPhone ?? this.userPhone,
        userType: userType ?? this.userType,
        userFirstName: userFirstName ?? this.userFirstName,
        userLastName: userLastName ?? this.userLastName,
      );
}
