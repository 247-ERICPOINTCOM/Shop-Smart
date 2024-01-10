import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shopsmartly/constants/constants.dart';
import 'package:shopsmartly/provider/app_provider.dart';
import 'package:shopsmartly/provider/provider.dart';
import 'dart:io';
import 'package:shopsmartly/widgets/primary_button/primary_button.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? image;

  void takePicture() async {
    XFile? value = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 40);
    if (value != null) {
      setState(() {
        image = File(value.path);
      });
    }
  }

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  ///Temporary for design display
  String userEmail = '';
  String user = 'User';

  @override
  void initState() {
    super.initState();
    // // Fetch the user's email when the widget is initialized
    // fetchUserEmail();
  }

  ///This email display is temporary, it's here just to show the email. Will be change properly using the provider.
  // void fetchUserEmail() async {
  //   // Use Firebase Authentication to get the currently authenticated user.
  //   final user = FirebaseAuth.instance.currentUser;
  //
  //   if (user != null) {
  //     // Get the user's UID.
  //     final uid = user.uid;
  //
  //     // Fetch the user's email from Firestore based on the UID.
  //     final userDoc =
  //         await FirebaseFirestore.instance.collection('users').doc(uid).get();
  //
  //     if (userDoc.exists) {
  //       // Retrieve the user's email from Firestore.
  //       final email = userDoc.get('email');
  //
  //       // Update the userEmail state.
  //       setState(() {
  //         userEmail = email;
  //       });
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        forceMaterialTransparency: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  appProvider.getUserInformation.userImage == null
                      ? CupertinoButton(
                          onPressed: () {
                            takePicture();
                          },
                          child: CircleAvatar(
                            radius: 45,
                            child: const Icon(Icons.camera_alt),
                          ),
                        )
                      : CupertinoButton(
                          onPressed: () {
                            takePicture();
                          },
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(appProvider.getUserInformation.userImage!),
                          ),
                        ),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: Text(appProvider.getUserInformation.userName),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(appProvider.getUserInformation.userEmail),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Text(
                      'Personal Information :',
                      style: TextStyle(fontSize: 18, color: kTextColor),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {

                    },
                    child: const Text(
                      'Edit',
                      style: TextStyle(
                        fontSize: 15,
                          decoration: TextDecoration.underline,
                          color: kPrimaryLightColor
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("First Name"),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  controller: firstName,
                  decoration: InputDecoration(
                    hintText: appProvider.getUserInformation.userFirstName,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Last Name"),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  controller: lastName,
                  decoration: InputDecoration(
                    hintText: appProvider.getUserInformation.userLastName,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Email"),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: email,
                  decoration: InputDecoration(
                    hintText: appProvider.getUserInformation.userEmail,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Phone Number"),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: phoneNumber,
                  decoration: InputDecoration(
                    hintText: appProvider.getUserInformation.userPhone,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text(
                  'Security Information :',
                  style: TextStyle(fontSize: 18, color: kTextColor),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // You can adjust alignment as needed
                children: [
                  MaterialButton(
                    minWidth: 100,
                    height: 40,
                    color: kPrimaryLightColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    onPressed: () {
                      // Add the onPressed action for the first button
                    },
                    child: const Text(
                      "Change Password",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  MaterialButton(
                    minWidth: 100,
                    height: 40,
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    onPressed: () {
                      // Add the onPressed action for the second button
                    },
                    child: const Text(
                      "Delete Account",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 80.0,
              ),
            ],
          )),
    );
  }
}
