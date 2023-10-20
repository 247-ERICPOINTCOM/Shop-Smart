import 'package:flutter/material.dart';
import 'package:shopsmartly/Screens/Delivery_Dashboard/registerform.dart';
import 'package:shopsmartly/my_flutter_app_icons.dart';
import '../BusinessOwner_Screens/Help_BO.dart';
import '../Login/login_screen.dart';
import '../profile/my_profile.dart';
import 'delivery_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

const kBackgroundColor = Color(0xFFF7F7F7);
const kTextColor = Color(0xFFa0a0a0);
const kInputColor = Color(0xFFe3e3e3);
const kRedColor = Color(0xFFE88276);
const kyellowColor = Color(0xFFF5d287);
const kBlackColor = Color(0xFF000000);
var admin = 'Delivery';

class Menubar_Delivery extends StatefulWidget {
  const Menubar_Delivery({Key? key}) : super(key: key);

  @override
  _Menubar_DeliveryState createState() => _Menubar_DeliveryState();
}

class _Menubar_DeliveryState extends State<Menubar_Delivery> {
  String userEmail = ''; // Store the user's email

  @override
  void initState() {
    super.initState();
    // Fetch the user's email when the widget is initialized
    fetchUserEmail();
  }

  void fetchUserEmail() async {
    // Use Firebase Authentication to get the currently authenticated user.
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Get the user's UID.
      final uid = user.uid;

      // Fetch the user's email from Firestore based on the UID.
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists) {
        // Retrieve the user's email from Firestore.
        final email = userDoc.get('email');

        // Update the userEmail state.
        setState(() {
          userEmail = email;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            child: Center(
              child: UserAccountsDrawerHeader(
                accountName: Text(admin, style: const TextStyle(color: kBlackColor)),
                accountEmail: Text(userEmail, style: const TextStyle(color: kBlackColor)),
                currentAccountPicture: const CircleAvatar(
                  child: ClipOval(
                    child: Icon(MyFlutterApp.user_circle, size: 70),
                  ),
                ),
                decoration: const BoxDecoration(color: kBackgroundColor),
              ),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(MyFlutterApp.dashboard, size: 20, color: kBlackColor),
            title: const Text('Dashboard', style: TextStyle(color: kBlackColor, fontWeight: FontWeight.bold)),
            onTap: () => selectedItem(context, 0),
          ),
          ListTile(
            leading: const Icon(MyFlutterApp.user_circle, size: 20, color: kBlackColor),
            title: const Text('My Profile', style: TextStyle(color: kBlackColor, fontWeight: FontWeight.bold)),
            onTap: () => selectedItem(context, 1),
          ),
          ListTile(
            leading: const Icon(MyFlutterApp.dashboard, size: 20, color: kBlackColor),
            title: const Text('Registration', style: TextStyle(color: kBlackColor, fontWeight: FontWeight.bold)),
            onTap: () => selectedItem(context, 2),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(MyFlutterApp.logout, size: 20, color: kBlackColor),
            title: const Text('Logout', style: TextStyle(color: kBlackColor, fontWeight: FontWeight.bold)),
            onTap: () => selectedItem(context, 3),
          ),
          ListTile(
            leading: const Icon(Icons.help_outline_outlined, size: 20, color: kBlackColor),
            title: const Text('Help', style: TextStyle(color: kBlackColor, fontWeight: FontWeight.bold)),
            onTap: () => selectedItem(context, 4),
          ),
        ],
      ),
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DeliveryPanel(),
        ));
        print('dashboard');
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const myprofile1(),
        ));
        print('my profile'); // This Screen does not build yet
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DeliveryRegistrationForm(),
        ));
        print('registration');
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LoginPage(),
        ));
        print('logout'); // This Screen does not build yet
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const Help_BO(),
        ));
        print('Help');
        break;
    }
  }
}
