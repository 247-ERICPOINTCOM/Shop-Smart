// import 'package:flutter/material.dart';
// import 'package:shopsmartly/Screens/Admin_Screens/Dashboard_Admin.dart';
// import 'package:shopsmartly/my_flutter_app_icons.dart';
// import 'package:shopsmartly/Screens/Admin_Screens/Delivery_List.dart';
// import '../../Object_Clasess/User.dart';
// import '../../constants/constants.dart';
// import '../Admin_Screens/Settings.dart';
// import '../Admin_Screens/adminviewproduct.dart';
// import '../cart/cart.dart';
// import '../profile/my_profile.dart';
//
// //import '../proudect/proudect.dart';
// import '../settings/paypalsetting.dart';
// import '../userproduct.dart';
// import 'User_Dashboard.dart';
// import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
// import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
//
// // const kBackgroundColor = Color(0xFFF7F7F7);
// // const kTextColor = Color(0xFFa0a0a0);
// // const kInputColor = Color(0xFFe3e3e3);
// // const kRedColor = Color(0xFFE88276);
// // const kyellowColor = Color(0xFFF5d287);
// // const kBlackColor = Color(0xFF000000);
// //var user = 'User';
//
// class Menubar_user extends StatefulWidget {
//   const Menubar_user({Key? key}) : super(key: key);
//
//   @override
//   _Menubar_userState createState() => _Menubar_userState();
// }
//
// class _Menubar_userState extends State<Menubar_user> {
//   String userEmail = ''; // Store the user's email
//
//   @override
//   void initState() {
//     super.initState();
//     // Fetch the user's email when the widget is initialized
//     fetchUserEmail();
//   }
//
//   void fetchUserEmail() async {
//     // Use Firebase Authentication to get the currently authenticated user.
//     final user = FirebaseAuth.instance.currentUser;
//
//     if (user != null) {
//       // Get the user's UID.
//       final uid = user.uid;
//
//       // Fetch the user's email from Firestore based on the UID.
//       final userDoc =
//           await FirebaseFirestore.instance.collection('users').doc(uid).get();
//
//       if (userDoc.exists) {
//         // Retrieve the user's email from Firestore.
//         final email = userDoc.get('email');
//
//         // Update the userEmail state.
//         setState(() {
//           userEmail = email;
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           Container(
//             child: Center(
//               child: UserAccountsDrawerHeader(
//                 accountName:
//                     Text(user, style: const TextStyle(color: kBlackColor)),
//                 accountEmail:
//                     Text(userEmail, style: const TextStyle(color: kBlackColor)),
//                 currentAccountPicture: const CircleAvatar(
//                   child: ClipOval(
//                     child: Icon(MyFlutterApp.user_circle, size: 70),
//                   ),
//                 ),
//                 decoration: const BoxDecoration(color: kBackgroundColor),
//               ),
//             ),
//           ),
//           const Divider(),
//           ListTile(
//             leading: const Icon(MyFlutterApp.dashboard,
//                 size: 20, color: kBlackColor),
//             title: const Text('Dashboard',
//                 style:
//                     TextStyle(color: kBlackColor, fontWeight: FontWeight.bold)),
//             onTap: () => selectedItem(context, 0),
//           ),
//           ListTile(
//             leading: const Icon(MyFlutterApp.user_circle,
//                 size: 20, color: kBlackColor),
//             title: const Text('My Profile',
//                 style:
//                     TextStyle(color: kBlackColor, fontWeight: FontWeight.bold)),
//             onTap: () => selectedItem(context, 1),
//           ),
//           ListTile(
//             leading: const Icon(MyFlutterApp.shopping_bag,
//                 size: 20, color: kBlackColor),
//             title: const Text('Product',
//                 style:
//                     TextStyle(color: kBlackColor, fontWeight: FontWeight.bold)),
//             onTap: () => selectedItem(context, 2),
//           ),
//           ListTile(
//             leading:
//                 const Icon(MyFlutterApp.truck, size: 20, color: kBlackColor),
//             title: const Text('Delivery',
//                 style:
//                     TextStyle(color: kBlackColor, fontWeight: FontWeight.bold)),
//             onTap: () => selectedItem(context, 3),
//           ),
//           const Divider(),
//           ListTile(
//             leading:
//                 const Icon(MyFlutterApp.logout, size: 20, color: kBlackColor),
//             title: const Text('Logout',
//                 style:
//                     TextStyle(color: kBlackColor, fontWeight: FontWeight.bold)),
//             onTap: () => selectedItem(context, 4),
//           ),
//           ListTile(
//             leading:
//                 const Icon(MyFlutterApp.logout, size: 20, color: kBlackColor),
//             title: const Text('Payment',
//                 style:
//                     TextStyle(color: kBlackColor, fontWeight: FontWeight.bold)),
//             onTap: () => selectedItem(context, 5),
//           ),
//           ListTile(
//             leading:
//                 const Icon(MyFlutterApp.cog_2, size: 20, color: kBlackColor),
//             title: const Text('Setting',
//                 style:
//                     TextStyle(color: kBlackColor, fontWeight: FontWeight.bold)),
//             onTap: () => selectedItem(context, 6),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void selectedItem(BuildContext context, int index) {
//     Navigator.of(context).pop();
//
//     switch (index) {
//       case 0:
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => UserPanelApp(),
//         ));
//         print('dashboard');
//         break;
//       case 1:
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => const myprofile1(),
//         ));
//         print('my profile'); // This Screen does not build yet
//         break;
//       case 2:
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => ProductList(), // This Screen does not build yet
//         ));
//         print('ViewUploadedDataScreen');
//         break;
//       case 3:
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => Delivery_List(),
//         ));
//         print('delivery');
//         break;
//       case 4:
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) =>
//               const Dashboard_Admin(), // This Screen does not build yet
//         ));
//         print('logout');
//         break;
//       case 5:
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) =>
//               const CheckoutPage(), // This Screen does not build yet
//         ));
//         print('payment');
//         break;
//       case 6:
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) =>
//               SettingsScreen(), // This Screen does not build yet
//         ));
//         print('setting');
//         break;
//     }
//   }
// }
