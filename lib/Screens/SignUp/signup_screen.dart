import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../../constants/constants.dart';
import '../Login/login_screen.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  String _username = '';
  String _selectedUserType = 'Users'; // Default user type

  bool isShowPassword = true;
  bool isShowConfirmPassword = true;

  // Function to handle signup
  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      if (_password != _confirmPassword) {
        // Passwords don't match
        // Handle the error here
        return;
      }

      try {
        // Create a new user with email and password
        final UserCredential userCredential =
        await _auth.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );

        // Get the UID of the registered user
        final String userUID = userCredential.user!.uid;

        // Store user data in Firestore with the UID
        await _firestore.collection('users').doc(userUID).set({
          'userEmail': _email,
          'userName': _username,
          'userType': _selectedUserType,
          // Add other user data fields here
        });

        // Send email verification
        await userCredential.user!.sendEmailVerification();

        // Navigate to the login page after successful signup
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()),
        );

        showMessage("Please check your email for account verification.");
      } catch (e) {
        // Handle signup errors and provide feedback to the user
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
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _username = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 12.0,
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
                  SizedBox(height: 12.0),
                  TextFormField(
                    obscureText: isShowConfirmPassword,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      suffixIcon: CupertinoButton(
                          onPressed: () {
                            setState(() {
                              isShowConfirmPassword = !isShowConfirmPassword;
                            });
                          },
                          padding: EdgeInsets.zero,
                          child: Icon(
                            isShowConfirmPassword
                                ? Icons.visibility
                                : Icons.visibility_off, // Toggle the icon
                            color: kTextColor,
                          )),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(60.0)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value != _password) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _confirmPassword = value;
                      });
                    },
                  ),
                  SizedBox(height: 12.0),
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        border: Border.all(color: kTextColor, width: 0),
                      ),
                      width: 300,
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton(
                            value: _selectedUserType,
                            onChanged: (value) {
                              setState(() {
                                _selectedUserType = value.toString();
                              });
                            },
                            items: [
                              'Users',
                              'Admin',
                              'Business Owner',
                              'Delivery'
                            ].map((type) {
                              return DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed:  _signUp,
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

// const kPrimaryColor = Color(0xFFB4D677);
// const kPrimaryLightColor = Color(0xFFA0D1C6);
// const kBackgroundColor = Color(0xFFF7F7F7);
// const kTextColor = Color(0xff555555);
// const kLinkTextColor = Color(0xFF0095FF);
// const kInputColor = Color(0xFFe3e3e3);
