import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// colors
const kPrimaryColor = Color(0xFFB4D677);
const kPrimaryLightColor = Color(0xFFA0D1C6);
const kBackgroundColor = Color(0xFFF7F7F7);
const kTextColor = Color(0xff555555);
const kLinkTextColor = Color(0xFF0095FF);
const kInputColor = Color(0xFFe3e3e3);
var user = 'User';

void showMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.pink,
      textColor: Colors.white,
      fontSize: 16.0);
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Builder(builder: (context) {
      return SizedBox(
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: kPrimaryColor,
            ),
            const SizedBox(
              height: 18.0,
            ),
            Container(
                margin: const EdgeInsets.only(left: 7),
                child: const Text("Loading...")),
          ],
        ),
      );
    }),
  );

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

bool loginValidation(String email, String password) {
  if (email.isEmpty && password.isEmpty) {
    showMessage("Both fields are empty");
    return false;
  } else if (email.isEmpty) {
    showMessage("E-mail is empty");
    return false;
  } else if (password.isEmpty) {
    showMessage("Password is empty");
    return false;
  } else {
    return true;
  }
}

bool signUpValidation(
    String email, String password, String name, String phone, String house) {
  if (email.isEmpty && password.isEmpty && name.isEmpty && phone.isEmpty) {
    showMessage("All fields are empty");
    return false;
  } else if (name.isEmpty) {
    showMessage("Name field is empty");
    return false;
  } else if (email.isEmpty) {
    showMessage("E-mail field is empty");
    return false;
  } else if (phone.isEmpty) {
    showMessage("Phone Number field is empty");
    return false;
  } else if (house.isEmpty) {
    showMessage("House Address field is empty");
    return false;
  } else if (password.isEmpty) {
    showMessage("Password field is empty");
    return false;
  } else {
    return true;
  }
}

// fonts
