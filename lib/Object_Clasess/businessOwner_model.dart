import 'dart:convert';

BusinessOwnerModel userModelFromJson(String str) => BusinessOwnerModel.fromJson(json.decode(str));

String userModelToJson(BusinessOwnerModel data) => json.encode(data.toJson());

class BusinessOwnerModel {
  BusinessOwnerModel({
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

  factory BusinessOwnerModel.fromJson(Map<String, dynamic> json) => BusinessOwnerModel(
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

  BusinessOwnerModel copyWith({
    String? userName,
    userImage,
    userPhone,
    userType,
    userFirstName,
    userLastName,
  }) =>
      BusinessOwnerModel(
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
