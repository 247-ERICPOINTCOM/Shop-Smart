import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shopsmartly/Screens/Login/login_screen.dart';
import 'package:shopsmartly/Screens/custom_bottom_bar/CustomBottomBar.dart';
import 'package:shopsmartly/constants/routes.dart';
import 'package:shopsmartly/widgets/primary_button/primary_button.dart';
import '../../../constants/constants.dart';
import '../../../constants/top_titles.dart';
import '../../../firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';

class CustomerSignUp extends StatefulWidget {
  const CustomerSignUp({super.key});

  @override
  State<CustomerSignUp> createState() => _CustomerSignUpState();
}

class _CustomerSignUpState extends State<CustomerSignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController userType = TextEditingController();
  bool isShowPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopTitles(
                title: "Create Account", subtitle: "Customer Sign Up"),
            SizedBox(
              height: 46.0,
            ),
            TextFormField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60.0),
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            TextFormField(
              controller: username,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60.0),
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            TextFormField(
              controller: firstName,
              decoration: InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60.0),
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            TextFormField(
              controller: lastName,
              decoration: InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60.0),
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            TextFormField(
              controller: phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60.0),
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            TextFormField(
              controller: password,
              obscureText: isShowPassword,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60.0),
                ),
                suffixIcon: CupertinoButton(
                    onPressed: () {
                      setState(() {
                        isShowPassword = !isShowPassword;
                      });
                    },
                    padding: EdgeInsets.zero,
                    child: Icon(
                      isShowPassword ? Icons.visibility : Icons.visibility_off,
                      // Toggle the icon
                      color: kPrimaryLightColor,
                    )),
              ),
            ),
            const SizedBox(
              height: 36.0,
            ),
            PrimaryButton(
              title: "Create account",
              onPressed: () async {
                bool isValidated = signUpValidation(
                  email.text,
                  username.text,
                  firstName.text,
                  lastName.text,
                  phone.text,
                  password.text,
                );
                if (isValidated) {
                  bool isLoggedIn = await FirebaseAuthHelper.instance.signUp(
                      email.text,
                      username.text,
                      firstName.text,
                      lastName.text,
                      phone.text,
                      password.text,
                      userType.text = 'Users',
                      context);
                  if (isLoggedIn) {
                    Routes.instance.pushAndRemoveUntil(
                        widget: const CustomBottomBar(), context: context);
                  }
                }
              },
            ),
            const SizedBox(
              height: 24.0,
            ),
            const Center(child: Text("Already have an account?")),
            const SizedBox(
              height: 5.0,
            ),
            Center(
                child: CupertinoButton(
                    onPressed: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: LoginPage(),
                        withNavBar: false, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    )))
          ],
        ),
      ),
    );
  }
}
