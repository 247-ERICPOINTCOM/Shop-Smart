import 'package:flutter/material.dart';
import 'package:shopsmartly/Screens/map_address/address_widget.dart';
import '../../constants/constants.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:slide_popup_dialog_null_safety/slide_popup_dialog.dart' as slideDialog;

class AddressMenu extends StatefulWidget {
  const AddressMenu({super.key});

  @override
  State<AddressMenu> createState() => _AddressMenuState();
}

class _AddressMenuState extends State<AddressMenu> {
  void _showDialog() {
    slideDialog.showSlideDialog(
      context: context,
      child: AddressInformation(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Address'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  // Add your logic for handling the "Add new address" button here
                  _showDialog();
                },
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.blue, // Choose the desired color
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Add new address",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            MaterialButton(
              minWidth: double.infinity,
              height: 60,
              onPressed: () {
                // PersistentNavBarNavigator.pushNewScreen(
                //   context,
                //   screen: UserLoginType(),
                //   withNavBar: false, // OPTIONAL VALUE. True by default.
                //   pageTransitionAnimation: PageTransitionAnimation.fade,
                // );
              },
              color: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Text(
                "Continue to checkout",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
