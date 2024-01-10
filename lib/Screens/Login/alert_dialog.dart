import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shopsmartly/Screens/Admin_Screens/admin_login.dart';
import 'package:shopsmartly/constants/constants.dart';

class AdminDialog extends StatefulWidget {
  const AdminDialog({Key? key}) : super(key: key);

  @override
  _AdminDialogState createState() => _AdminDialogState();
}

class _AdminDialogState extends State<AdminDialog> {
  final TextEditingController _passwordController = TextEditingController();
  final String correctPassword = "your_password"; // Set your desired password here

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: const Text('Administrator')),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            //Text('Please enter the password to proceed:'),
            TextField(
              controller: _passwordController,
              obscureText: true, // Hide the entered text
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Submit'),
          onPressed: () {
            if (_passwordController.text == correctPassword) {
              // Password is correct, navigate to the next screen
              Navigator.of(context).pop(); // Close the dialog
              // Add your navigation logic here
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: AdminLogin(),
                withNavBar: true, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.fade,
              );
            } else {
              // Incorrect password, you can show an error message or do something else
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: kLinkTextColor,
                  content: Text('Incorrect password.', style: TextStyle(color: Colors.white),),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
