import 'package:flutter/material.dart';
import '../cart/cart.dart';

class reviews extends StatefulWidget {
  const reviews({Key? key}) : super(key: key);

  @override
  State<reviews> createState() => _reviewsState();
}

class _reviewsState extends State<reviews> {
  int _currentindex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    // home(),
    // search(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(253, 237, 237, 1.0),
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: const Text(
          'Customers reviews',
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'cart'),
        ],
        currentIndex: _currentindex,
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.grey[350],
        onTap: _changeitem,
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
              child: ListTile(
                leading: Image.asset(
                  'assets/images/image.png',
                ),
                title: const Text("Lorem opseum"),
                subtitle: Row(
                  children: [
                    Image.asset(
                      'assets/images/rating.png',
                      width: 40,
                      color: Colors.amber,
                    ),
                    const Text("3 reviews"),
                  ],
                ),
              ),
            ),
          ),
          const Card(
            elevation: 8,
            child: ListTile(
              leading: Icon(
                Icons.star,
                color: Colors.amber,
              ),
              title: Text("rawan"),
              subtitle: Text("i like it"),
            ),
          ),
          const Card(
            elevation: 8,
            child: ListTile(
              leading: Icon(
                Icons.star_half,
                color: Colors.amber,
              ),
              title: Text("Mohammed"),
              subtitle: Text("i like it"),
            ),
          ),
          const Card(
            elevation: 8,
            child: ListTile(
              leading: Icon(
                Icons.star,
                color: Colors.amber,
              ),
              title: Text("Ali"),
              subtitle: Text("love it"),
            ),
          ),
        ],
      ),
    );
  }

  void _changeitem(int value) {
    print(value);
    setState(() {
      _currentindex = value;
    });
  }
}
