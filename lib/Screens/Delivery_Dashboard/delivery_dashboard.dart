import 'package:flutter/material.dart';
import 'menu_delivery.dart';

void main() {
  runApp(DeliveryPanel());
}



class DeliveryPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/profile',
      routes: {
        '/profile': (context) => ProfileScreen(),
        '/orders': (context) => OrdersScreen(),
      },
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Menubar_Delivery(),
      backgroundColor: kBackgroundColor, // Change the background color to grey
      appBar: AppBar(
        backgroundColor: kPrimaryLightColor, // Change the app bar color to green
        title: Text('Delivery Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to your profile!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                style:ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor)
                    ,shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )
                    )),
              onPressed: () {
                Navigator.of(context).pushNamed('/orders');
              },
              child: Text('View Orders'),
            ),
          ],
        ),
      ),
    );
  }
}

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Order #001'),
            subtitle: Text('Status: Delivered'),
          ),
          ListTile(
            title: Text('Order #002'),
            subtitle: Text('Status: Processing'),
          ),
          // Add more order items as needed
        ],
      ),
    );
  }
}
