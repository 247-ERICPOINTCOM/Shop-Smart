import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Platform-Specific Code Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome to our app!',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              // Platform-specific widgets
              if (Platform.isAndroid)
                Text(
                  'This is Android-specific content',
                  style: TextStyle(color: Colors.green),
                )
              else if (Platform.isIOS)
                Text(
                  'This is iOS-specific content',
                  style: TextStyle(color: Colors.blue),
                )
              else if (kIsWeb)
                  Text(
                    'This is web-specific content',
                    style: TextStyle(color: Colors.red),
                  )
                else
                  Text(
                    'This is default content for other platforms',
                    style: TextStyle(color: Colors.grey),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
