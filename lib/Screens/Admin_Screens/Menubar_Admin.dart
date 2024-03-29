import 'package:flutter/material.dart';
import 'package:shopsmartly/Screens/Admin_Screens/Dashboard_Admin.dart';
import 'package:shopsmartly/Screens/Admin_Screens/productlistadded.dart';
import 'package:shopsmartly/Screens/Admin_Screens/user_view/user_view.dart';
import 'package:shopsmartly/my_flutter_app_icons.dart';
import 'package:shopsmartly/Screens/Admin_Screens/Delivery_List.dart';

import '../BusinessOwner_Screens/businessadd.dart';
import '../Login/login_screen.dart';
import '../cart/cart.dart';
import '../profile/my_profile.dart';

//import '../proudect/proudect.dart';
import '../userproduct.dart';
import 'Settings.dart';
import 'Users_List.dart';

const kPrimaryColor = Color(0xFFB4D677);
const kPrimaryLightColor = Color(0xFFA0D1C6);
const kBackgroundColor = Color(0xFFF7F7F7);
const kTextColor = Color(0xFFa0a0a0);
const kInputColor = Color(0xFFe3e3e3);
const kRedColor = Color(0xFFE88276);
const kyellowColor = Color(0xFFF5d287);
const kBlackColor = Color(0xFF000000);
var admin = 'Admin';

class Menubar_Admin extends StatelessWidget {
  const Menubar_Admin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
              child: Center(
                  child: UserAccountsDrawerHeader(
            accountName: Text(
              admin,
              style: const TextStyle(color: kBlackColor),
            ),
            accountEmail: const Text(''),
            currentAccountPicture: const CircleAvatar(
              child: ClipOval(
                child: Icon(
                  Icons.person,
                  size: 70,
                ),
              ),
            ),
            decoration: const BoxDecoration(color: kBackgroundColor),
          ))),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.dashboard,
              size: 20,
              color: kPrimaryLightColor,
            ),
            title: const Text('Dashboard',
                style:
                    TextStyle(color: kBlackColor, fontWeight: FontWeight.bold)),
            onTap: () => selectedItem(context, 0),
          ),
          ListTile(
            leading: const Icon(
              Icons.people_alt_rounded,
              size: 20,
              color: kPrimaryLightColor,
            ),
            title: const Text('My Profile ',
                style:
                    TextStyle(color: kBlackColor, fontWeight: FontWeight.bold)),
            onTap: () => selectedItem(context, 1),
          ),
          ListTile(
            leading: const Icon(
              Icons.shopping_bag,
              size: 20,
              color: kPrimaryLightColor,
            ),
            title: const Text('Product',
                style:
                    TextStyle(color: kBlackColor, fontWeight: FontWeight.bold)),
            onTap: () => selectedItem(context, 2),
          ),
          ListTile(
            leading: const Icon(
              Icons.add_rounded,
              size: 20,
              color: kPrimaryLightColor,
            ),
            title: const Text('ProductAdded List',
                style:
                    TextStyle(color: kBlackColor, fontWeight: FontWeight.bold)),
            onTap: () => selectedItem(context, 3),
          ),
          ListTile(
            leading: const Icon(
              Icons.supervised_user_circle,
              size: 20,
              color: kPrimaryLightColor,
            ),
            title: const Text('Users',
                style:
                    TextStyle(color: kBlackColor, fontWeight: FontWeight.bold)),
            onTap: () => selectedItem(context, 4),
          ),
          ListTile(
            leading: const Icon(
              Icons.delivery_dining,
              size: 20,
              color: kPrimaryLightColor,
            ),
            title: const Text('Delivery',
                style:
                    TextStyle(color: kBlackColor, fontWeight: FontWeight.bold)),
            onTap: () => selectedItem(context, 5),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.logout,
              size: 20,
              color: kPrimaryLightColor,
            ),
            title: const Text('Logout',
                style:
                    TextStyle(color: kBlackColor, fontWeight: FontWeight.bold)),
            onTap: () => selectedItem(context, 6),
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              size: 20,
              color: kPrimaryLightColor,
            ),
            title: const Text('Setting ',
                style:
                    TextStyle(color: kBlackColor, fontWeight: FontWeight.bold)),
            onTap: () => selectedItem(context, 7),
          ),
          ListTile(
            leading: const Icon(
              Icons.supervised_user_circle,
              size: 20,
              color: kPrimaryLightColor,
            ),
            title: const Text('Users',
                style:
                    TextStyle(color: kBlackColor, fontWeight: FontWeight.bold)),
            onTap: () => selectedItem(context, 8),
          ),
        ], //children
      ),
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const Dashboard_Admin(),
        ));
        print('dashboard');
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const myprofile1(),
        ));
        print('my profile'); //this Screen does not build yet
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductList(), //this Screen does not build yet
        ));
        print('product');
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Productslist(),
        ));
        print('AddedProductslist'); //this Screen does not build yet
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const UserListScreen(),
        ));
        print('users');
        break;
      case 5:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Delivery_List(),
        ));
        print('delivery');
        break;
      case 6:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LoginPage(), //this Screen does not build yet
        ));
        print('logout');
        break;
      case 7:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              SettingsScreen(), //this Screen does not build yet
        ));
        print('setting');
        break;
      case 8:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              UserView(), //this Screen does not build yet
        ));
        print('User Information');
        break;
    }
  }
}
