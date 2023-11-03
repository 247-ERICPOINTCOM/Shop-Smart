// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shopsmartly/provider/provider.dart';
// //import 'package:shopsmartly/Screens/Welcome/welcome_screen.dart';
// import 'package:shopsmartly/rounded_button.dart';
// import 'Screens/Address/LocationSelectionScreen.dart';
// import 'Screens/Address/googleMap.dart';
// import 'Screens/Admin_Screens/Dashboard_Admin.dart';
// import 'Screens/Admin_Screens/Settings.dart';
// import 'Screens/Admin_Screens/admineditscreen.dart';
// import 'Screens/Admin_Screens/adminproduct.dart';
// import 'Screens/Admin_Screens/adminviewproduct.dart';
// import 'Screens/BusinessOwner_Screens/Dashboard_BO.dart';
// import 'Screens/BusinessOwner_Screens/Help_BO.dart';
// import 'Screens/BusinessOwner_Screens/businessadd.dart';
// import 'Screens/Delivery_Dashboard/delivery_dashboard.dart';
// import 'Screens/Delivery_Dashboard/registerform.dart';
// import 'Screens/Login/NavigationPage.dart';
// import 'Screens/Login/login_screen.dart';
// //import 'package:shopsmartly/Screens/proudect/proudect.dart';
// import 'package:shopsmartly/Screens/product/customer_reviews.dart';
// import 'package:shopsmartly/Screens/cart/cart.dart';
// import 'package:shopsmartly/Screens/address/select_address.dart';
// import 'package:shopsmartly/Screens/payment/payment.dart';
// import 'package:shopsmartly/Screens/delivery/delivery_method.dart';
// import 'package:shopsmartly/Screens/delivery/motor_bike.dart';
// import 'package:shopsmartly/Screens/delivery/deliveryinfo.dart';
// import 'package:shopsmartly/Screens/order/my order.dart';
// import 'package:shopsmartly/Screens/order/order detiles.dart';
// import 'package:shopsmartly/Screens/order/review order.dart';
// import 'package:shopsmartly/Screens/profile/my_profile.dart';
// import 'package:shopsmartly/Screens/order/track shipment.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'Screens/Login/user.dart';
// import 'Screens/SignUp/signup_screen.dart';
// import 'Screens/Welcome/welcome_screen.dart';
// import 'Screens/settings/paypalsetting.dart';
// import 'Screens/user_screen/User_Dashboard.dart';
// import 'firebase_helper/firebase_options/firebase_options.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => CartProvider(), // Create and provide CartProvider
//       child: MaterialApp(
//         home: MyApp(),
//       ),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         fontFamily: 'Montserrat',
//         primaryColor: Colors.deepOrange,
//         primarySwatch: Colors.deepOrange,
//       ),
//       initialRoute: "WelcomeScreen", // Change this to the initial route you prefer
//       routes: {
//         'welcome_screen': (context) => WelcomeScreen(),
//         'NavigationPage': (context) => NavigationPage(),
//         'CheckoutPage': (context) => CheckoutPage(),
//         'UserLogin': (context) => UserLogin(),
//         'LoginPage': (context) => LoginPage(),
//         //'product': (context) => product(),
//         'reviews': (context) => const reviews(),
//         'cart': (context) => ProductList(),
//         'selectAddress': (context) => const selectAddress(),
//         'MapWidget': (context) => MapWidget(),
//         'MapSample': (context) => MapSample(), // Define the 'MapSample' route
//         'BOAddProductScreen': (context) => BOAddProductScreen(),
//         'payment': (context) => payment(),
//         'deliveryMethod': (context) => const deliveryMethod(),
//         'deliveryinfo': (context) => const deliveryinfo(),
//         'MyOrders': (context) => const MyOrders(),
//         'OrderDetails': (context) => const OrderDetails(),
//         'myprofile1': (context) => const myprofile1(),
//         'ReviewOrder1': (context) => const ReviewOrder1(),
//         'trakshipment': (context) => const trakshipment(),
//         'motorBike': (context) => const motorBike(),
//         'Dashboard_Admin': (context) => const Dashboard_Admin(),
//         'AddProductScreen': (context) => AddProductScreen(),
//         'ViewUploadedDataScreen': (context) => ViewUploadedDataScreen(),
//         'ordersubmit': (context) => ordersubmit(),
//         'Help_BO': (context) => Help_BO(),
//         'SignupPage': (context) => SignupPage(),
//         'Dashboard_BO': (context) => Dashboard_BO(),
//         'UserPanelApp': (context) => UserPanelApp(),
//         'SettingsScreen': (context) => SettingsScreen(),
//         'DeliveryPanel': (context) => DeliveryPanel(),
//         'edit_product': (context) => EditProductScreen(productId: '',),
//       },
//       home: HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return WelcomeScreen();
//   }
// }
