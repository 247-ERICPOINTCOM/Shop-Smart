import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopsmartly/Screens/Login/login_screen.dart';
import 'package:shopsmartly/constants/constants.dart';

import '../../Object_Clasess/user_model.dart';

class FirebaseAuthHelper {
  static FirebaseAuthHelper instance = FirebaseAuthHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get getAuthChange => _auth.authStateChanges();

  // Future<bool> login(
  //     String email, String password, BuildContext context) async {
  //   try {
  //     showLoaderDialog(context);
  //     await _auth.signInWithEmailAndPassword(email: email, password: password);
  //     Navigator.of(context).pop();
  //     return true;
  //   } on FirebaseAuthException catch (error) {
  //     Navigator.of(context).pop();
  //     showMessage(error.code.toString());
  //     return false;
  //   }
  // } ///Code for to be logged in until manually logged out.

  Future signUp(
      String name, String email, String password, String house, String phone, BuildContext context) async {
    try {
      showLoaderDialog(context);
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      UserModel userModel =
      UserModel(userID: userCredential.user!.uid, userName: '', userEmail: '', userPhone: '', userType: '',  );

      // Send email verification
      await userCredential.user!.sendEmailVerification();

      // Save user data to Firestore
      await _firestore.collection("users").doc(userModel.userID).set(userModel.toJson());

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false,
      );
      showMessage("Account created. Please check your email for verification.");
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop(); // Close the loader dialog
      showMessage(error.code.toString());
    }
  }

  void signOut() async{
    await _auth.signOut();
  }

}
