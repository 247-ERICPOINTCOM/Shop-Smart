import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../settings/Generalseting.dart';
import '../settings/payondeliver.dart';
import '../settings/paypalsetting.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final List<String> _tabs = ["General", "Pay on Delivery", "PayPal"];
  final List<Widget> _pages = [
    GeneralSettingsPage(),
    PayOnDeliverySettingsPage(),
    CheckoutPage(),
  ];

  void _saveSettings() async {
    // Save the settings to Firebase Firestore.
    // Replace this with your Firestore configuration and logic.

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Example: Saving a user's settings.
      await firestore.collection('users').doc('user_id').set({
        'generalSettings': _pages[0], // Replace with your general settings logic.
        'payOnDeliverySettings': _pages[1], // Replace with your Pay on Delivery settings logic.
        'paypalSettings': _pages[2], // Replace with your PayPal settings logic.
        // Add Stripe settings or other settings here if needed.
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Settings saved successfully!')),
      );
    } catch (error) {
      print('Error saving settings: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving settings. Please try again later.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
          actions: [
            // Add a "Save" button to the app bar.
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _saveSettings,
            ),
          ],
          bottom: TabBar(
            tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
          ),
        ),
        body: TabBarView(
          children: _pages,
        ),
      ),
    );
  }
}
