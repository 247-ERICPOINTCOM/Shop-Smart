import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shopsmartly/Screens/custom_bottom_bar/CustomBottomBar.dart';

import '../Admin_Screens/Dashboard_Admin.dart';
import '../BusinessOwner_Screens/Dashboard_BO.dart';
import '../Delivery_Dashboard/delivery_dashboard.dart';
import '../SignUp/signup_screen.dart';
import 'forget_password.dart';

// Define your colors
const kPrimaryColor = Color(0xFFB4D677);
const kPrimaryLightColor = Color(0xFFA0D1C6);
const kBackgroundColor = Color(0xFFF7F7F7);
const kTextColor = Color(0xff555555);
const kLinkTextColor = Color(0xFF0095FF);
const kInputColor = Color(0xFFe3e3e3);

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _email = '';
  String _password = '';
  bool isShowPassword = true;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Sign in with email and password
        final UserCredential userCredential = await _auth
            .signInWithEmailAndPassword(email: _email, password: _password);

        // Retrieve the user's user type from Firestore
        final DocumentSnapshot userDoc = await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        if (userDoc.exists) {
          final String userType = userDoc['userType'];

          // Navigate to the user-specific page
          switch (userType) {
            case 'Users':
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: CustomBottomBar(),
                withNavBar: true, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.fade,
              );
              break;
            case 'admin' || 'Admin':
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(builder: (context) => Dashboard_Admin()),
              // );
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: Dashboard_Admin(),
                withNavBar: false, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.fade,
              );
              break;
            case 'Business Owner' || 'BusinessOwner':
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(builder: (context) => Dashboard_BO()),
              // );
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: Dashboard_BO(),
                withNavBar: false, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.fade,
              );
              break;
            case 'Delivery' || 'delivery':
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(builder: (context) => DeliveryPanel()),
              // );
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: DeliveryPanel(),
                withNavBar: false, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.fade,
              );
              break;
            default:
              // Handle other user types or show an error
              break;
          }
        }
      } catch (e) {
        // Handle login errors and provide feedback to the user
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(e.toString()),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 3.0,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/logo.png"))),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  TextFormField(
                    obscureText: isShowPassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: CupertinoButton(
                          onPressed: () {
                            setState(() {
                              isShowPassword = !isShowPassword;
                            });
                          },
                          padding: EdgeInsets.zero,
                          child: Icon(
                            isShowPassword
                                ? Icons.visibility
                                : Icons.visibility_off, // Toggle the icon
                            color: kTextColor,
                          )),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(60.0)),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please input your password';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: _login,
                    // bg color
                    color: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CupertinoButton(
                      onPressed: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: ForgetPassword(),
                          withNavBar: false, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      },
                      child: Text(
                        "Forgot your Password ?",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupPage()));
                    },
                    color: kPrimaryLightColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: const Text("Sign Up",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
