import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmartly/constants/constants.dart';
import 'package:shopsmartly/provider/app_provider.dart';

class AddressInformation extends StatefulWidget {
  const AddressInformation({Key? key}) : super(key: key);

  @override
  _AddressInformationState createState() => _AddressInformationState();
}

class _AddressInformationState extends State<AddressInformation> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Set Address',
            style: TextStyle(fontSize: 16),
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Full Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(60.0),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(60.0),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'City',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(60.0),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Address',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(60.0),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          MaterialButton(
            minWidth: 200,
            height: 60,
            onPressed: () {
              // Add your save logic here
            },
            // bg color
            color: kPrimaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: const Text(
              "Save",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
