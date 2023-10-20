import 'package:flutter/material.dart';
import 'package:shopsmartly/my_flutter_app_icons.dart';
import '../Admin_Screens/Add_Order.dart';
import '../Admin_Screens/adminproduct.dart';
import '../Login/login_screen.dart';
import '../profile/my_profile.dart';
//import '../proudect/proudect.dart';
import 'Dashboard_BO.dart';
import 'Help_BO.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'businessadd.dart'; // Import Firebase Auth

const kBackgroundColor = Color(0xFFF7F7F7);
const kTextColor = Color(0xFFa0a0a0);
const kInputColor = Color(0xFFe3e3e3);
const kRedColor = Color(0xFFE88276);
const kyellowColor = Color(0xFFF5d287);
const kBlackColor = Color(0xFF000000);

class Menubar_BO extends StatefulWidget {
  const Menubar_BO({Key? key}) : super(key: key);

  @override
  _Menubar_BOState createState() => _Menubar_BOState();
}

class _Menubar_BOState extends State<Menubar_BO> {
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
      // Get the user's email.
      final email = user.email;

      // Update the userEmail state.
      setState(() {
        userEmail = email!;
      });
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
                accountName: Text('Business Owner', style: TextStyle(color: kBlackColor)),
                accountEmail: Text(userEmail, style: TextStyle(color: kBlackColor)),
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
            leading: const Icon(MyFlutterApp.shopping_bag, size: 20, color: kBlackColor),
            title: const Text('Product', style: TextStyle(color: kBlackColor, fontWeight: FontWeight.bold)),
            onTap: () => selectedItem(context, 2),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(MyFlutterApp.logout, size: 20, color: kBlackColor),
            title: const Text('Logout', style: TextStyle(color: kBlackColor, fontWeight: FontWeight.bold)),
            onTap: () => selectedItem(context, 3),
          ),
          ListTile(
            leading: const Icon(MyFlutterApp.cog_2, size: 20, color: kBlackColor),
            title: const Text('Setting', style: TextStyle(color: kBlackColor, fontWeight: FontWeight.bold)),
            onTap: () => selectedItem(context, 4),
          ),
          ListTile(
            leading: const Icon(Icons.help_outline_outlined, size: 20, color: kBlackColor),
            title: const Text('Help', style: TextStyle(color: kBlackColor, fontWeight: FontWeight.bold)),
            onTap: () => selectedItem(context, 5),
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
          builder: (context) => const Dashboard_BO(),
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
          builder: (context) => BOAddProductScreen(),
        ));
        print('product');
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LoginPage(),
        ));
        print('logout'); // This Screen does not build yet
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const Dashboard_BO(), // This Screen does not build yet
        ));
        print('setting');
        break;
      case 5:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const Help_BO(),
        ));
        print('Help');
        break;
    }
  }
}
