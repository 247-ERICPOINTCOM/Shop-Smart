import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopsmartly/Screens/SignUp/signup_screen.dart';
import '../../constants/constants.dart';
import 'package:firebase_database/firebase_database.dart';

import 'forget_password.dart';

const kPrimaryColor = Color(0xFFB4D677);
const kPrimaryLightColor = Color(0xFFA0D1C6);
const kBackgroundColor = Color(0xFFF7F7F7);
const kTextColor = Color(0xff555555);
const kLinkTextColor = Color(0xFF0095FF);
const kInputColor = Color(0xFFe3e3e3);

final FirebaseAuth _auth = FirebaseAuth.instance;
final DatabaseReference _database = FirebaseDatabase.instance.reference();

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

class UserLogin extends StatefulWidget {
  const UserLogin({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<UserLogin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: kBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 20,
          color: kTextColor,
        ),
      ),
      body: SizedBox(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const Column(
                    children: <Widget>[
                      Text(
                        "Admin Login",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: kTextColor,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Login as an admin",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            emailController.text = value;
                          },
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter your email',
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextField(
                          obscureText: true,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            passwordController.text = value;
                          },
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter your password.',
                          ),
                        ),
                        const SizedBox(
                          height: 24.0,
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 3, left: 3),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: () async {
                              setState(() {
                                showSpinner = true;
                              });

                              try {
                                final userCredential =
                                await _auth.signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );

                                if (userCredential.user != null) {
                                  // Check if the entered email exists in the 'users' node
                                  bool isUser = await checkUser(emailController.text);

                                  if (isUser) {
                                    Navigator.pushNamed(context, 'UserPanelScreen');
                                  } else {
                                    // Show an error message if the user is not found
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('User not found.'),
                                      ),
                                    );
                                  }
                                }
                              } catch (e) {
                                print(e);
                              } finally {
                                setState(() {
                                  showSpinner = false;
                                });
                              }
                            },

                            color: kPrimaryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigate to the forget password screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgetpassPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontSize: 16,
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Divider(
                          thickness: 1.5,
                          endIndent: 8,
                          indent: 39,
                        ),
                      ),
                      Text(
                        "OR",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                      Flexible(
                        child: Divider(
                          thickness: 1.5,
                          indent: 8,
                          endIndent: 38,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupPage(),
                        ),
                      );
                    },
                    color: kPrimaryLightColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Modify this function to check for user credentials in the 'users' node
  Future<bool> checkUser(String email) async {
    DataSnapshot snapshot =
    (await _database.child('users').child(email).once()) as DataSnapshot;
    return snapshot.value != null;
  }
}