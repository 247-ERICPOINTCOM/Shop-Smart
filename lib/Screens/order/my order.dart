import 'package:flutter/material.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 237, 237),
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: const Text('Orders',
          style: TextStyle(
            color: Color.fromARGB(255, 112, 112, 112),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body:Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5,10,5,10),
          child: Column(
            children: <Widget>[
              Card(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 20, 20, 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text('Order : Nsa65fg ',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 155, 155, 155)
                              ),),
                            const SizedBox(width: 80,),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "OrderDetails");
                              },
                              child: const Text(
                                'View Details ',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Color.fromARGB(255, 200, 227, 221)
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 165.0),
                          child: Text('Place On Mar 8, 2022',
                            style: TextStyle(
                              color: Color.fromARGB(255, 185, 185, 185),
                            ),
                          ),
                        ),
                        const Divider(
                          height: 10.0,
                          color: Colors.black12,
                        ),
                        Row(
                          children: [
                            Image.asset('assets/images/image.png',width: 60,),
                            const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Text('Lorem opseum',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 185, 185, 185),
                                    ),
                                  ),
                                  Text('Delivered  ',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 185, 185, 185),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10,),
                        FloatingActionButton.extended(
                          label: const Text('Review this order'), // <-- Text
                          backgroundColor: const Color.fromARGB(255, 180, 214, 119),
                          icon: const Icon( // <-- Icon
                            Icons.rate_review,
                            size: 24.0,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context,"ReviewOrder1");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40,),
              Card(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 20, 20, 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text('Order : Nsa65fg ',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 155, 155, 155)
                              ),),
                            const SizedBox(width: 80,),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "");
                              },
                              child: const Text(
                                'View Details ',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Color.fromARGB(255, 200, 227, 221)
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 165.0),
                          child: Text('Place On Mar 8, 2022',
                            style: TextStyle(
                              color: Color.fromARGB(255, 185, 185, 185),
                            ),
                          ),
                        ),
                        const Divider(
                          height: 10.0,
                          color: Colors.black12,
                        ),
                        Row(
                          children: [
                            Image.asset('assets/images/image.png',width: 60,),
                            const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Text('Lorem opseum',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 185, 185, 185),
                                    ),
                                  ),
                                  Text('Delivered  ',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 185, 185, 185),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10,),
                        FloatingActionButton.extended(
                          label: const Text('Review this order'), // <-- Text
                          backgroundColor: const Color.fromARGB(255, 180, 214, 119),
                          icon: const Icon( // <-- Icon
                            Icons.rate_review,
                            size: 24.0,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context,"ReviewOrder1");
                          },
                        ),                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ) ,
    );
  }
}
