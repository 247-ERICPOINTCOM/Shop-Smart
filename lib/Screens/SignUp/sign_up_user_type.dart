import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopsmartly/Screens/SignUp/sign_up_screen/sign_up_business_owner.dart';
import 'package:shopsmartly/Screens/SignUp/sign_up_screen/sign_up_customer.dart';
import 'package:shopsmartly/Screens/SignUp/sign_up_screen/sign_up_delivery.dart';
import 'package:shopsmartly/constants/constants.dart';



class UserSignUpType extends StatelessWidget {
  const UserSignUpType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
            color: kTextColor,
          ),
        ),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      // InkWell(
                      //   splashColor: kPrimaryLightColor,
                      //   onTap: () {
                      //     showMessage('Admin Go here');
                      //   },
                      //   child: Ink.image(
                      //     height: MediaQuery.of(context).size.height / 6,
                      //     image: AssetImage("assets/images/logo_high.png"),
                      //     width: 100,
                      //     fit: BoxFit.contain,
                      //     // decoration: const BoxDecoration(
                      //     //   image: DecorationImage(
                      //     //     image:
                      //     //   ),
                      //     // ),
                      //   ),
                      // ),
                      Text(
                        "Sign up as",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: kTextColor),
                      ),
                      SizedBox(height: 70),
                      // Text(
                      //   "Experience shopping with astonishingly low prices.",
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(color: Colors.grey, fontSize: 15),
                      // )
                    ],
                  ),
                  // the logo image container
                  // Container(
                  //   height: MediaQuery.of(context).size.height / 5,
                  //   decoration: const BoxDecoration(
                  //     image: DecorationImage(
                  //       image: AssetImage("assets/images/logo_high.png"),
                  //     ),
                  //   ),
                  // ),
                  Column(children: <Widget>[
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CustomerSignUp()));
                      },
                      // bg color
                      color: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: const Text(
                        "Customer",
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BusinessOwnerSignUp()));
                      },
                      // bg color
                      color: kPrimaryLightColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: const Text(
                        "Business Owner",
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DeliverySignUp()));
                      },
                      // bg color
                      color: kLinkTextColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: const Text(
                        "Delivery Person",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 50),
                  ]),
                ]),
          ),
        ));
  }
}
