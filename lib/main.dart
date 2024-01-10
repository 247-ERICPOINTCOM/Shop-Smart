import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmartly/Screens/custom_bottom_bar/CustomBottomBar.dart';
import 'package:shopsmartly/constants/constants.dart';
import 'package:shopsmartly/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:shopsmartly/provider/app_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Screens/Welcome/welcome_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

// Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Column(
          children: [
            Image.asset('assets/images/yellow.png'),
          ],
        ),
        backgroundColor: kBackgroundColor,
        splashIconSize: 370,
        duration: 3000,
        splashTransition: SplashTransition.rotationTransition,
        pageTransitionType: PageTransitionType.bottomToTop,
        animationDuration: Duration(seconds: 1),
        nextScreen: WelcomeScreen());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        title: 'Shop Smartly',
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
        // Change this to the initial route you prefer
        routes: {
          '/splash_screen': (context) => SplashScreen(),
          '/login': (context) => WelcomeScreen(),
        },
        home: SplashScreen(),
        // StreamBuilder(
        //     stream: FirebaseAuthHelper.instance.getAuthChange,
        //     builder: (context, snapshot) {
        //       if (snapshot.hasData) {
        //         // User is authenticated, shows CustomBottomBar
        //         return CustomBottomBar();
        //       } else {
        //         // User is not authenticated, show Welcome
        //         return SplashScreen();
        //       }
        //     }),
      ),
    );
  }
}
