import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shopsmartly/Object_Clasess/businessOwner_model.dart';
import 'package:shopsmartly/Screens/Admin_Screens/Dashboard_Admin.dart';
import 'package:shopsmartly/Screens/BusinessOwner_Screens/Dashboard_BO.dart';
import 'package:shopsmartly/Screens/Login/login_screen.dart';
import 'package:shopsmartly/Screens/Login/login_type/business_owner_login.dart';
import 'package:shopsmartly/Screens/Login/login_type/customer_login.dart';
import 'package:shopsmartly/Screens/Login/login_type/delivery_login.dart';
import 'package:shopsmartly/constants/constants.dart';

import '../../Object_Clasess/deliveryPerson_model.dart';
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

  Future<bool> adminLogin(
      String email, String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);

      // Retrieve the user's user type from Firestore
      final DocumentSnapshot userDoc = await _firestore
          .collection('admin')
          .doc(userCredential.user!.uid)
          .get();

      if (userDoc.exists) {
        final String userType = userDoc['userType'];

        // Navigate to the user-specific page
        switch (userType) {
          case 'admin' || 'Admin':
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: Dashboard_Admin(),
              withNavBar: false, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.fade,
            );
            break;
          default:
          // Handle other user types or show an error
        }
      }
      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop();
      showMessage(error.code.toString());
      return false;
    }
  }

  Future<bool> deliveryLogin(
      String email, String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);

      // Retrieve the user's user type from Firestore
      final DocumentSnapshot userDoc = await _firestore
          .collection('deliveries')
          .doc(userCredential.user!.uid)
          .get();

      if (userDoc.exists) {
        final String userType = userDoc['userType'];

        // Navigate to the user-specific page
        switch (userType) {
          case 'Delivery Person':
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: Dashboard_BO(),
              withNavBar: false, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.fade,
            );
            break;
          default:
            {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Error"),
                    content: Text('Bruh'),
                    actions: <Widget>[
                      TextButton(
                        child: Text("OK"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }
          // Handle other user types or show an error
        }
      }
      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop();
      showMessage(error.code.toString());
      return false;
    }
  }

  Future<bool> ownerLogin(
      String email, String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);

      // Retrieve the user's user type from Firestore
      final DocumentSnapshot userDoc = await _firestore
          .collection('businessOwner')
          .doc(userCredential.user!.uid)
          .get();

      if (userDoc.exists) {
        final String userType = userDoc['userType'];

        // Navigate to the user-specific page
        switch (userType) {
          case 'Business Owner':
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: Dashboard_BO(),
              withNavBar: false, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.fade,
            );
            break;
          default:
            {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Error"),
                    content: Text('Bruh'),
                    actions: <Widget>[
                      TextButton(
                        child: Text("OK"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }
          // Handle other user types or show an error
        }
      }
      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop();
      showMessage(error.code.toString());
      return false;
    }
  }

  ///Code for to be logged in until manually logged out.

  Future signUp(
      String email,
      String username,
      String firstName,
      String lastName,
      String phone,
      String password,
      String userType,
      BuildContext context) async {
    try {
      showLoaderDialog(context);
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      UserModel userModel = UserModel(
          userID: userCredential.user!.uid,
          userName: username,
          userFirstName: firstName,
          userLastName: lastName,
          userEmail: email,
          userPhone: phone,
          userType: userType,
          userBudget: 50);

      // Send email verification
      await userCredential.user!.sendEmailVerification();

      // Save user data to Firestore
      await _firestore
          .collection("users")
          .doc(userModel.userID)
          .set(userModel.toJson());

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => CustomerLogin()),
        (Route<dynamic> route) => false,
      );
      showMessage("Account created. Please check your email for verification.");
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop(); // Close the loader dialog
      showMessage(error.code.toString());
    }
  }

  Future signUpBusinessOwner(
      String email,
      String username,
      String firstName,
      String lastName,
      String phone,
      String password,
      String userType,
      BuildContext context) async {
    try {
      showLoaderDialog(context);
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      BusinessOwnerModel businessOwnerModel = BusinessOwnerModel(
          userID: userCredential.user!.uid,
          userName: username,
          userFirstName: firstName,
          userLastName: lastName,
          userEmail: email,
          userPhone: phone,
          userType: userType);

      // Send email verification
      await userCredential.user!.sendEmailVerification();

      // Save user data to Firestore
      await _firestore
          .collection("businessOwner")
          .doc(businessOwnerModel.userID)
          .set(businessOwnerModel.toJson());

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => BusinessOwnerLogin()),
        (Route<dynamic> route) => false,
      );
      showMessage("Account created. Please check your email for verification.");
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop(); // Close the loader dialog
      showMessage(error.code.toString());
    }
  }

  Future signUpDelivery(
      String email,
      String username,
      String firstName,
      String lastName,
      String phone,
      String password,
      String userType,
      BuildContext context) async {
    try {
      showLoaderDialog(context);
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      DeliveryPersonModel deliveryPersonModel = DeliveryPersonModel(
          userID: userCredential.user!.uid,
          userName: username,
          userFirstName: firstName,
          userLastName: lastName,
          userEmail: email,
          userPhone: phone,
          userType: userType);

      // Send email verification
      await userCredential.user!.sendEmailVerification();

      // Save user data to Firestore
      await _firestore
          .collection("deliveries")
          .doc(deliveryPersonModel.userID)
          .set(deliveryPersonModel.toJson());

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => DeliveryLogin()),
        (Route<dynamic> route) => false,
      );
      showMessage("Account created. Please check your email for verification.");
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop(); // Close the loader dialog
      showMessage(error.code.toString());
    }
  }

  void signOut() async {
    await _auth.signOut();
  }
}
