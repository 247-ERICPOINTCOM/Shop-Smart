import 'package:flutter/material.dart';

class OrderFailedPage extends StatelessWidget {
  const OrderFailedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red, // Set background color to green
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.warning, // Use a checkmark icon to indicate success
                color: Colors.white, // Set icon color to white
                size: 100.0,
              ),
              SizedBox(height: 20.0),
              Text(
                'Payment was Unsuccessful.',
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white, // Set text color to white
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
