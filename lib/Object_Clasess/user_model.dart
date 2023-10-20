import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.image,
    required this.userID,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.userStatus,
  });

  String? image;
  String userID;
  String userName;
  String userEmail;
  String userPhone;
  String userStatus;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userID: json["userID"],
    image: json["image"],
    userName: json["userName"],
    userEmail: json["userEmail"],
    userPhone: json["userPhone"],
    userStatus: json["userStatus"],
  );

  Map<String, dynamic> toJson() => {
    "userID": userID,
    "image": image,
    "userName": userName,
    "userEmail": userEmail,
    "userPhone": userPhone,
    "userStatus": userStatus,
  };

  UserModel copyWith({
    String? userName,
    image,
    userPhone,
    userStatus,
  }) =>
      UserModel(
        userID: userID,
        userEmail: userEmail,
        userName: userName ?? this.userName,
        image: image ?? this.image,
        userPhone: userPhone ?? this.userPhone,
        userStatus: userStatus ?? this.userStatus,
      );
}
