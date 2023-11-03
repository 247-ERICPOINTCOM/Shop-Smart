import 'package:flutter/material.dart';
import 'package:shopsmartly/Screens/cart/cart.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final int _selectedindex = 2;
  final List<Widget> _children = [];
  PageController pageController = PageController();

  void onTabbedBar(int index) {
    setState(() {});
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 247, 247, 1.0),
      appBar: AppBar(
          backgroundColor: Colors.grey[100],
          title: const Column(
            children: <Widget>[
              Text(
                'Order ID - NSA7856 ',
                style: TextStyle(
                  color: Color.fromARGB(255, 112, 112, 112),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                'Place On Mar 8, 2022',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
            ],
          )),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 213, 213, 213),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
              color: Color.fromARGB(255, 88, 88, 88),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined,
                color: Color.fromARGB(255, 88, 88, 88)),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart,
                color: Color.fromARGB(255, 88, 88, 88)),
            label: '',
          ),
        ],
        currentIndex: _selectedindex,
        selectedItemColor: const Color.fromARGB(255, 155, 155, 155),
        onTap: onTabbedBar,
      ),
      body: PageView(
        controller: pageController,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Shipping Address ",
                  style: TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 112, 112, 112)),
                ),
                const Text(
                  "John Doe",
                  style: TextStyle(color: Color.fromARGB(255, 155, 155, 155)),
                ),
                const Text(
                  "Med, Saudi Arabia",
                  style: TextStyle(color: Color.fromARGB(255, 155, 155, 155)),
                ),
                const Divider(
                  height: 50,
                ),
                const Text(
                  "Mobile Number   ",
                  style: TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 112, 112, 112)),
                ),
                const Text(
                  "+966 000 0000",
                  style: TextStyle(color: Color.fromARGB(255, 155, 155, 155)),
                ),
                const Divider(
                  height: 50,
                ),
                Row(
                  children: [
                    const Text(
                      'Shipment 1: NSA7856',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 112, 112, 112),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey,
                        backgroundColor:
                            const Color.fromARGB(255, 180, 214, 119),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        minimumSize: const Size(160, 50),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, "trakshipment");
                      },
                      child: const Text(
                        " Trak shipment",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
                const Text(
                  'Invoice',
                  style: TextStyle(
                      fontSize: 12,
                      decoration: TextDecoration.underline,
                      color: Color.fromARGB(255, 200, 227, 221)),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Row(
                  children: [
                    Text(
                      "DELIVERED",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 112, 112, 112)),
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    Column(
                      children: [
                        Text(
                          "Delivered on Sun,Jan 30",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 112, 112, 112)),
                        ),
                        Text(
                          "Delivered by Joe doe ",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 112, 112, 112)),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(
                  height: 12,
                ),
                Card(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Store Name ',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 155, 155, 155)),
                          ),
                          Row(
                            children: [
                              const Text(
                                'Lorem opseum',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 155, 155, 155)),
                              ),
                              const SizedBox(
                                width: 60,
                              ),
                              Image.asset(
                                'assets/images/image.png',
                                width: 70,
                              )
                            ],
                          ),
                          const Text(
                            '15',
                            style: TextStyle(
                                color: Color.fromARGB(255, 112, 112, 112)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Qty 1',
                            style: TextStyle(
                                color: Color.fromARGB(255, 112, 112, 112)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Text('Payment Method'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
