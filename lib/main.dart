import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmartly/Screens/custom_bottom_bar/CustomBottomBar.dart';
import 'package:shopsmartly/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:shopsmartly/provider/provider.dart';

//import 'package:shopsmartly/Screens/Welcome/welcome_screen.dart';
import 'package:shopsmartly/rounded_button.dart';
import 'Screens/Address/LocationSelectionScreen.dart';
import 'Screens/Address/googleMap.dart';
import 'Screens/Admin_Screens/Dashboard_Admin.dart';
import 'Screens/Admin_Screens/Settings.dart';
import 'Screens/Admin_Screens/admineditscreen.dart';
import 'Screens/Admin_Screens/adminproduct.dart';
import 'Screens/Admin_Screens/adminviewproduct.dart';
import 'Screens/BusinessOwner_Screens/Dashboard_BO.dart';
import 'Screens/BusinessOwner_Screens/Help_BO.dart';
import 'Screens/BusinessOwner_Screens/businessadd.dart';
import 'Screens/Delivery_Dashboard/delivery_dashboard.dart';
import 'Screens/Login/NavigationPage.dart';
import 'Screens/Login/login_screen.dart';

//import 'package:shopsmartly/Screens/proudect/proudect.dart';
import 'package:shopsmartly/Screens/product/customer_reviews.dart';
import 'package:shopsmartly/Screens/cart/cart.dart';
import 'package:shopsmartly/Screens/address/select_address.dart';
import 'package:shopsmartly/Screens/payment/payment.dart';
import 'package:shopsmartly/Screens/delivery/delivery_method.dart';
import 'package:shopsmartly/Screens/delivery/motor_bike.dart';
import 'package:shopsmartly/Screens/delivery/deliveryinfo.dart';
import 'package:shopsmartly/Screens/order/my order.dart';
import 'package:shopsmartly/Screens/order/order detiles.dart';
import 'package:shopsmartly/Screens/order/review order.dart';
import 'package:shopsmartly/Screens/profile/my_profile.dart';
import 'package:shopsmartly/Screens/order/track shipment.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Screens/Login/user.dart';
import 'Screens/SignUp/signup_screen.dart';
import 'Screens/Welcome/welcome_screen.dart';
import 'Screens/settings/paypalsetting.dart';
import 'Screens/user_screen/User_Dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

// Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(), // Create and provide CartProvider
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
        ),
        fontFamily: 'Montserrat',
        primaryColor: Color(0xFFB4D677),
        primarySwatch: MaterialColor(
          0xFFA0D1C6,
          <int, Color>{
            50: Color(0xFFA0D1C6), // Shades for various UI components
            100: Color(0xFFA0D1C6),
            200: Color(0xFFA0D1C6),
            300: Color(0xFFA0D1C6),
            400: Color(0xFFA0D1C6),
            500: Color(0xFFA0D1C6), // Primary color
            600: Color(0xFFA0D1C6),
            700: Color(0xFFA0D1C6),
            800: Color(0xFFA0D1C6),
            900: Color(0xFFA0D1C6),
          },
        ),
      ),
      initialRoute: "welcome_screen",
      // Change this to the initial route you prefer
      routes: {
        'welcome_screen': (context) => WelcomeScreen(),
        'NavigationPage': (context) => NavigationPage(),
        'CheckoutPage': (context) => CheckoutPage(),
        'UserLogin': (context) => UserLogin(),
        'LoginPage': (context) => LoginPage(),
        //'product': (context) => product(),
        'reviews': (context) => const reviews(),
        'cart': (context) => ProductList(),
        'selectAddress': (context) => const selectAddress(),
        'MapWidget': (context) => MapWidget(),
        'MapSample': (context) => MapSample(), // Define the 'MapSample' route
        'BOAddProductScreen': (context) => BOAddProductScreen(),
        'payment': (context) => payment(),
        'deliveryMethod': (context) => const deliveryMethod(),
        'deliveryinfo': (context) => const deliveryinfo(),
        'MyOrders': (context) => const MyOrders(),
        'OrderDetails': (context) => const OrderDetails(),
        'myprofile1': (context) => const myprofile1(),
        'ReviewOrder1': (context) => const ReviewOrder1(),
        'trakshipment': (context) => const trakshipment(),
        'motorBike': (context) => const motorBike(),
        'Dashboard_Admin': (context) => const Dashboard_Admin(),
        'AddProductScreen': (context) => AddProductScreen(),
        'ViewUploadedDataScreen': (context) => ViewUploadedDataScreen(),
        'ordersubmit': (context) => ordersubmit(),
        'Help_BO': (context) => Help_BO(),
        'SignupPage': (context) => SignupPage(),
        'Dashboard_BO': (context) => Dashboard_BO(),
        'UserPanelApp': (context) => UserPanelApp(),
        'SettingsScreen': (context) => SettingsScreen(),
        'DeliveryPanel': (context) => DeliveryPanel(),
        'edit_product': (context) => EditProductScreen(
              productId: '',
            ),
      },
      home: StreamBuilder(
          stream: FirebaseAuthHelper.instance.getAuthChange,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // User is authenticated, shows CustomBottomBar
              return CustomBottomBar();
            } else {
              // User is not authenticated, show Welcome
              return WelcomeScreen();
            }
          }),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WelcomeScreen();
  }
}
