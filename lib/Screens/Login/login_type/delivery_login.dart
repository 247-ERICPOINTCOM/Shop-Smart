import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shopsmartly/Screens/BusinessOwner_Screens/Dashboard_BO.dart';
import 'package:shopsmartly/Screens/Delivery_Dashboard/delivery_dashboard.dart';
import 'package:shopsmartly/Screens/Login/login_type/business_owner_login.dart';
import 'package:shopsmartly/Screens/Login/login_type/customer_login.dart';
import 'package:shopsmartly/Screens/SignUp/sign_up_user_type.dart';
import 'package:shopsmartly/Screens/custom_bottom_bar/CustomBottomBar.dart';
import 'package:shopsmartly/constants/constants.dart';

class DeliveryLogin extends StatefulWidget {
  const DeliveryLogin({super.key});

  @override
  _DeliveryLoginState createState() => _DeliveryLoginState();
}

class _DeliveryLoginState extends State<DeliveryLogin> {
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
            .collection('deliveries')
            .doc(userCredential.user!.uid)
            .get();

        if (userDoc.exists) {
          final String userType = userDoc['userType'];

          // Navigate to the user-specific page
          switch (userType) {
            case 'Users':
              showMessage("Please login here.");
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: CustomerLogin(),
                withNavBar: true, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.fade,
              );
              break;
            case 'admin' || 'Admin':
              Navigator.of(context).pop();
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Administrator'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[Text('Please use the other login.')],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );

              break;
            case 'Business Owner' || 'BusinessOwner':
              showMessage("Please login here.");
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: BusinessOwnerLogin(),
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
                  Text(
                    "Delivery Login",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                            color: kPrimaryLightColor,
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
                  SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserSignUpType()));
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
