import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:shopsmartly/Screens/Address/googleMap.dart';
import 'package:shopsmartly/Screens/Address/select_address.dart';
import 'package:shopsmartly/Screens/budget_tracker/budget_tracker.dart';
import 'package:shopsmartly/Screens/budget_tracker/budget_tracker_widget.dart';
import 'package:shopsmartly/Screens/cart/cart.dart';
import 'package:shopsmartly/Screens/map_address/address_menu.dart';
import 'package:shopsmartly/Screens/profile/user_profile.dart';
import 'package:shopsmartly/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:shopsmartly/provider/app_provider.dart';
import '../../constants/constants.dart';
import '../user_screen/User_Dashboard.dart';
import 'package:slide_popup_dialog_null_safety/slide_popup_dialog.dart'
    as slideDialog;

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Logout"),
          content: Text("Are you sure you want to log out?"),
          actions: <Widget>[
            TextButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Yes",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                FirebaseAuthHelper.instance.signOut();
                //Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/login');
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialog() {
    slideDialog.showSlideDialog(
      context: context,
      child: BudgetTrackerTest(),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            child: Center(
              child: UserAccountsDrawerHeader(
                accountName: Text(appProvider.getUserInformation.userName,
                    style: const TextStyle(color: kTextColor)),
                accountEmail: Text(appProvider.getUserInformation.userEmail,
                    style: const TextStyle(color: kTextColor)),
                currentAccountPicture:
                    appProvider.getUserInformation.userImage == null
                        ? Icon(
                            Icons.person_outline,
                            size: 70,
                          )
                        : CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                appProvider.getUserInformation.userImage!),
                          ),
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text('My Profile'),
            leading: Icon(
              Icons.person,
              color: kPrimaryLightColor,
            ),
            onTap: () {
              Navigator.of(context).pop();
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: EditProfile(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.fade,
              );
            },
          ),
          ListTile(
            title: Text('My Orders'),
            leading: Icon(
              Icons.shopping_cart_outlined,
              color: kPrimaryLightColor,
            ),
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: OrdersScreen(),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.fade,
              );
            },
          ),
          ListTile(
            title: Text('My Budget'),
            leading: Icon(
              Icons.attach_money,
              color: kPrimaryLightColor,
            ),
            onTap: () {
              _showDialog();
            },
          ),
          ListTile(
            title: Text('Temp Map'),
            leading: Icon(
              Icons.map,
              color: kPrimaryLightColor,
            ),
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: MapSample(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.fade,
              );
            },
          ),
          ListTile(
            title: Text('Tester Cart'),
            leading: Icon(
              Icons.attach_money,
              color: kPrimaryLightColor,
            ),
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: MyApp(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.fade,
              );
            },
          ),
          ListTile(
            title: Text('Logout'),
            leading: Icon(
              Icons.logout,
              color: kPrimaryLightColor,
            ),
            onTap: () {
              _showLogoutConfirmationDialog(context);
            },
          ),
        ],
      ),
    );
  }
}
