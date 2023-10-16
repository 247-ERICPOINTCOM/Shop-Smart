import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> _handleNavigation(String userType) async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        final userData = await _firestore.collection('users').doc(currentUser.uid).get();
        final userTypeFromFirestore = userData.get('userType');

        if (userTypeFromFirestore == userType) {
          // User type matches, navigate to the corresponding page
          if (userType == 'User') {
            Navigator.pushNamed(context, 'UserLogin');
          } else if (userType == 'Business Owner') {
            Navigator.pushNamed(context, 'BusinessLogin');
          } else if (userType == 'Admin') {
            Navigator.pushNamed(context, 'AdminPage');
          }
        } else {
          // User type does not match, show an error message or handle it as needed
          print('User type does not match the selected option.');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Type Selection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _handleNavigation('User');
              },
              child: Text('User'),
            ),
            ElevatedButton(
              onPressed: () {
                _handleNavigation('Business Owner');
              },
              child: Text('Business Owner'),
            ),
            ElevatedButton(
              onPressed: () {
                _handleNavigation('Admin');
              },
              child: Text('Admin'),
            ),
          ],
        ),
      ),
    );
  }
}
