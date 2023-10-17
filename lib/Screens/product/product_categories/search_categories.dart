import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shopsmartly/Screens/user_screen/User_Dashboard.dart';
import 'package:shopsmartly/constants/constants.dart';
import 'package:shopsmartly/constants/routes.dart';
import '../../../firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import '../../../my_flutter_app_icons.dart';
import '../../user_screen/Menubar_user.dart';
import 'widgets/single_dash_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String userEmail = '';

  @override
  void initState() {
    super.initState();
    // Fetch the user's email when the widget is initialized
    fetchUserEmail();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;

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
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text("Yes", style: TextStyle(color: Colors.red),),
              onPressed: () {
                // // Perform logout action here
                // FirebaseAuthHelper.instance.signOut();
                // Navigator.of(context).pop(); // Close the dialog
                //
                // // Push the login screen route after successful logout
                // Navigator.of(context).pushReplacementNamed('/welcome_screen');
              },
            ),
          ],
        );
      },
    );
  }

  void fetchUserEmail() async {
    // Use Firebase Authentication to get the currently authenticated user.
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Get the user's UID.
      final uid = user.uid;

      // Fetch the user's email from Firestore based on the UID.
      final userDoc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();

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

  // void getData() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
  //   await appProvider.callBackFunction();
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  // @override
  // void initState() {
  //   getData();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.image_search),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
              icon: Icon(Icons.list_outlined))
        ],
        title: Container(
          //padding: EdgeInsets.all(12),
          child: TextFormField(
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.all(10),
              filled: true,
              hintText: "Search",
              fillColor: kPrimaryColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              suffixIcon: Icon(
                Icons.search,
                size: 30,
              ),
            ),
          ),
        ),
      ),
      endDrawer: Drawer(
        // This is the drawer that will appear on the right
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              child: Center(
                child: UserAccountsDrawerHeader(
                  accountName:
                  Text(user, style: const TextStyle(color: kBlackColor)),
                  accountEmail: Text(userEmail,
                      style: const TextStyle(color: kBlackColor)),
                  currentAccountPicture: const CircleAvatar(
                    child: ClipOval(
                      child: Icon(Icons.person_outline, size: 70),
                    ),
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
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: UserPanelApp(),
                  withNavBar: true,
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
              title: Text('Logout'),
              leading: Icon(
                Icons.logout,
                color: kPrimaryLightColor,
              ),
              onTap: () {
                _showLogoutConfirmationDialog(context); // Show the confirmation dialog
              },
            ),
            // Add more items as needed
          ],
        ),
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.count(
                shrinkWrap: true,
                primary: false,
                padding: EdgeInsets.zero,
                crossAxisCount: 2,
                children: [
                  SingleCardItem(
                    title: "Home",
                    onPressed: () {
                      // Routes.instance.push(
                      //   widget: UserView(),
                      //   context: context,
                      // );
                    },
                  ),
                  SingleCardItem(
                    title: "Groceries",
                    onPressed: () {
                      // Routes.instance.push(
                      //   widget: UserView(),
                      //   context: context,
                      // );
                    },
                  ),
                  SingleCardItem(
                    title: "Electronics",
                    onPressed: () {
                      // Routes.instance.push(
                      //   widget: CategoriesView(),
                      //   context: context,
                      // );
                    },
                  ),
                  SingleCardItem(
                    title: "Men",
                    onPressed: () {
                      // Routes.instance.push(
                      //   widget: ProductView(),
                      //   context: context,
                      // );
                    },
                  ),
                  SingleCardItem(
                    title: "Women",
                    onPressed: () {},
                  ),
                  SingleCardItem(
                    title: "Kids",
                    onPressed: () {
                      // Routes.instance.push(
                      //   widget: OrderList(
                      //     title: "Pending",
                      //   ),
                      //   context: context,
                      // );
                    },
                  ),
                  SingleCardItem(
                    title: "Toys",
                    onPressed: () {
                      // Routes.instance.push(
                      //   widget: OrderList(
                      //     title: "Delivery",
                      //   ),
                      //   context: context,
                      // );
                    },
                  ),
                  SingleCardItem(
                    title: "Accessories",
                    onPressed: () {
                      // Routes.instance.push(
                      //   widget: OrderList(
                      //     title: "Cancelled",
                      //   ),
                      //   context: context,
                      // );
                    },
                  ),
                  SingleCardItem(
                    title: "Tools",
                    onPressed: () {
                      // Routes.instance.push(
                      //   widget: OrderList(
                      //     title: "Completed",
                      //   ),
                      //   context: context,
                      // );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
