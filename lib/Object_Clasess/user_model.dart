import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.userImage,
    required this.userID,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.userType,
  });

  String? userImage;
  String userID;
  String userName;
  String userEmail;
  String userPhone;
  String userType;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userID: json["userID"],
        userImage: json["userImage"],
        userName: json["userName"],
        userEmail: json["userEmail"],
        userPhone: json["userPhone"],
        userType: json["userType"],
      );

  Map<String, dynamic> toJson() => {
        "userID": userID,
        "userImage": userImage,
        "userName": userName,
        "userEmail": userEmail,
        "userPhone": userPhone,
        "userType": userType,
      };

  UserModel copyWith({
    String? userName,
    userImage,
    userPhone,
    userType,
  }) =>
      UserModel(
        userID: userID,
        userEmail: userEmail,
        userName: userName ?? this.userName,
        userImage: userImage ?? this.userImage,
        userPhone: userPhone ?? this.userPhone,
        userType: userType ?? this.userType,
      );
}
