import 'package:flutter/material.dart';

class OrderConfirmationPage extends StatelessWidget {
  const OrderConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.green, // Set background color to green
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.check_circle, // Use a checkmark icon to indicate success
                color: Colors.white, // Set icon color to white
                size: 100.0,
              ),
              SizedBox(height: 20.0),
              Text(
                'Success' '\nYour order has been placed.',
                textAlign: TextAlign.center, // Center the text horizontally
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