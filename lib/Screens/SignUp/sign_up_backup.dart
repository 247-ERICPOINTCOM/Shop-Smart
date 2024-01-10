// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:shopsmartly/Screens/custom_bottom_bar/CustomBottomBar.dart';
// import 'package:shopsmartly/constants/constants.dart';
// import 'package:shopsmartly/constants/routes.dart';
// import 'package:shopsmartly/widgets/primary_button/primary_button.dart';
// import '../../../firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
//
// class SignUp extends StatefulWidget {
//   const SignUp({super.key});
//
//   @override
//   State<SignUp> createState() => _SignUpState();
// }
//
// class _SignUpState extends State<SignUp> {
//   TextEditingController userEmail = TextEditingController();
//   TextEditingController userFirstName = TextEditingController();
//   TextEditingController userLastName = TextEditingController();
//   TextEditingController userName = TextEditingController();
//   TextEditingController userPhone = TextEditingController();
//   TextEditingController userPassword = TextEditingController();
//   TextEditingController userTypeCustomer = TextEditingController();
//
//   bool isShowPassword = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: 46.0,
//             ),
//             TextFormField(
//               controller: userFirstName,
//               decoration: const InputDecoration(
//                 hintText: "First Name",
//                 prefixIcon: Icon(
//                   Icons.person_outline,
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 12.0,
//             ),
//             TextFormField(
//               controller: userLastName,
//               decoration: const InputDecoration(
//                 hintText: "Last Name",
//                 prefixIcon: Icon(
//                   Icons.person_outline,
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 12.0,
//             ),
//             TextFormField(
//               controller: userName,
//               decoration: const InputDecoration(
//                 hintText: "Username",
//                 prefixIcon: Icon(
//                   Icons.person_outline,
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 12.0,
//             ),
//             TextFormField(
//               controller: userEmail,
//               keyboardType: TextInputType.emailAddress,
//               decoration: const InputDecoration(
//                 hintText: "E-mail Address",
//                 prefixIcon: Icon(
//                   Icons.email_outlined,
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 12.0,
//             ),
//             TextFormField(
//               controller: userPhone,
//               inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//               keyboardType: TextInputType.phone,
//               decoration: const InputDecoration(
//                 hintText: "Phone Number",
//                 prefixIcon: Icon(
//                   Icons.phone_outlined,
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 12.0,
//             ),
//             TextFormField(
//               controller: userPassword,
//               obscureText: isShowPassword,
//               decoration: InputDecoration(
//                 hintText: "Password",
//                 prefixIcon: Icon(
//                   Icons.password_sharp,
//                 ),
//                 suffixIcon: CupertinoButton(
//                     onPressed: () {
//                       setState(() {
//                         isShowPassword = !isShowPassword;
//                       });
//                     },
//                     padding: EdgeInsets.zero,
//                     child: Icon(
//                       isShowPassword ? Icons.visibility : Icons.visibility_off,
//                       // Toggle the icon
//                       color: Colors.pink,
//                     )),
//               ),
//             ),
//             const SizedBox(
//               height: 36.0,
//             ),
//             PrimaryButton(
//               title: "Create an account",
//               onPressed: () async {
//                 bool isValidated = signUpValidation(
//                   userEmail.text,
//                   userPassword.text,
//                   userName.text,
//                   userFirstName.text,
//                   userLastName.text,
//                   userPhone.text,
//                 );
//                 if (isValidated) {
//                   bool isLoggedIn = await FirebaseAuthHelper.instance.signUp(
//                       userEmail.text,
//                       userName.text,
//                       userFirstName.text,
//                       userLastName.text,
//                       userPhone.text,
//                       context);
//                   if (isLoggedIn) {
//                     Routes.instance.pushAndRemoveUntil(
//                         widget: CustomBottomBar(), context: context);
//                   }
//                 }
//               },
//             ),
//             const SizedBox(
//               height: 24.0,
//             ),
//             const Center(child: Text("Already have an account?")),
//             const SizedBox(
//               height: 5.0,
//             ),
//             Center(
//                 child: CupertinoButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: Text(
//                       "Login",
//                       style: TextStyle(color: Theme.of(context).primaryColor),
//                     )))
//           ],
//         ),
//       ),
//     );
//   }
// }
