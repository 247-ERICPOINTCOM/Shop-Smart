import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopsmartly/Screens/Admin_Screens/Dashboard_Admin.dart';
import 'package:shopsmartly/constants/constants.dart';
import 'package:shopsmartly/constants/routes.dart';
import 'package:shopsmartly/constants/top_titles.dart';
import 'package:shopsmartly/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:shopsmartly/widgets/primary_button/primary_button.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _LoginState();
}

class _LoginState extends State<AdminLogin> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isShowPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopTitles(title: "Admin Login", subtitle: ""),
              SizedBox(
                height: 46.0,
              ),
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                  hintText: "E-mail Address",
                  prefixIcon: Icon(
                    Icons.email_outlined,
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                  labelText: 'Password',
                  prefixIcon: Icon(
                    Icons.password_sharp,
                  ),
                  suffixIcon: CupertinoButton(
                      onPressed: () {
                        setState(() {
                          isShowPassword = !isShowPassword;
                        });
                      },
                      padding: EdgeInsets.zero,
                      child: Icon(
                        isShowPassword
                            ? Icons.visibility
                            : Icons.visibility_off, // Toggle the icon
                        color: kPrimaryLightColor,
                      )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              PrimaryButton(
                title: "Login",
                onPressed: () async {
                  bool isValidated = loginValidation(email.text, password.text);
                  if (isValidated) {
                    bool isLoggedIn = await FirebaseAuthHelper.instance
                        .adminLogin(email.text, password.text, context);
                    if (isLoggedIn) {
                      Routes.instance.pushAndRemoveUntil(
                          widget: Dashboard_Admin(), context: context);
                    }
                  }
                },
              ),
              const SizedBox(
                height: 24.0,
              ),
              const SizedBox(
                height: 12.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
