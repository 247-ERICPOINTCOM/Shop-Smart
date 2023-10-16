class User {
  final int userID;
  final String userName;
  final String userStatus;


  const User({
    required this.userID,
    required this.userName,
    required this.userStatus

  });

  User copy({
    int? userID,
    int? userName,
    String? userStatus,


  }) =>
      User(
        userID: this.userID,
        userName: this.userName,
        userStatus: this.userStatus,
      );


}
