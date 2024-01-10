import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import '../cart/cart.dart';
//import 'package:shop_smartly/Screens/cart/cart.dart';

class SelectAddress extends StatefulWidget {
  const SelectAddress({Key? key}) : super(key: key);

  @override
  State<SelectAddress> createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  int _currentindex = 0;
  List<Widget> _widgetOptions = <Widget>[
    // home(),
    // search(),
    ProductList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(247, 247, 247, 1.0),
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text(
          'Select Address',
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(height: 0, child: _widgetOptions.elementAt(_currentindex)),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 95, 0, 0),
            child: Divider(
              height: 8.0,
              color: Colors.black12,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(80, 0, 30, 0),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.add_circle_outline_rounded,
                    color: Color.fromARGB(255, 160, 209, 198),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context,
                        "MapSample"); // Navigate to the "MapSample" page
                  },
                ),
                Text(
                  'Add new address',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 8.0,
            color: Colors.black12,
          ),
          Expanded(
            child: Container(
                // Your content here
                ),
          ),
          Divider(
            height: 8.0,
            color: Colors.black12,
          ),
          TextButton(
            child: Text(
              "Continue to checkout",
              style: TextStyle(fontSize: 15),
            ),
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey,
              backgroundColor: Color.fromARGB(255, 180, 214, 119),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              minimumSize: Size(360, 50),
            ),
            onPressed: () {
              Navigator.pushNamed(context, "");
            },
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}
