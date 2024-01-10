import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shopsmartly/Screens/Login/login_user_type.dart';
import 'package:shopsmartly/Screens/SignUp/sign_up_user_type.dart';
import 'package:shopsmartly/constants/constants.dart';
import '../Login/alert_dialog.dart';
import '../Login/login_screen.dart';
import '../SignUp/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 1.1,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: const <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Welcome",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: kTextColor),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Experience shopping with astonishingly low prices.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      )
                    ],
                  ),
                  InkWell(
                    splashColor: kPrimaryColor,
                    onDoubleTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AdminDialog();
                        },
                      );
                    },
                    child: Ink.image(
                      height: MediaQuery.of(context).size.height / 5,
                      image: AssetImage("assets/images/logo_high.png"),
                      width: 116,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Column(children: <Widget>[
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => UserSignUpType(),
                        //   ),
                        // );
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: UserSignUpType(),
                          withNavBar: false, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      },
                      color: kPrimaryLightColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 18),
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: UserLoginType(),
                          withNavBar: false, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      },
                      color: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                  ]),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
