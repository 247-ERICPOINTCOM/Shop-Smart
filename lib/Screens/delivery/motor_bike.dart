import 'package:flutter/material.dart';

class motorBike extends StatefulWidget {
  const motorBike({Key? key}) : super(key: key);

  @override
  State<motorBike> createState() => _motorBikeState();
}

class _motorBikeState extends State<motorBike> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(253, 237, 237, 1.0),
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: const Text(
          'Delivery Method ',
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      //hit Ctrl+space in intellij to know what are the options you can use in flutter widgets
      body:
      Container(
        padding: const EdgeInsets.fromLTRB(5,10,5,10),
        child: Column(
          children: <Widget>[
            Card(
              child: Container(
                padding: const EdgeInsets.fromLTRB(25, 0, 20, 0),
                child: Column(
                  children: <Widget>[
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB( 0,30, 70.0,0),
                          child: Column(
                            children: [
                              CircleAvatar(backgroundColor: Colors.grey, backgroundImage:
                              AssetImage('assets/images/user.png'),),
                              Image(image:
                              AssetImage('assets/images/rating.png',),
                                width: 40,
                                color: Colors.yellow,
                              ),
                            ],
                          ),
                        ),
                        Text('Joe Doe'),
                        SizedBox(width: 10,),
                        Text('10',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 62.0),
                          child: Text('7.2 km'),
                        )
                      ],
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey, backgroundColor: const Color.fromARGB(255, 180, 214, 119),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        minimumSize: const Size(100, 30),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context,"deliveryinfo");
                      },
                      child: const Text("Accept",
                        style: TextStyle(
                            fontSize: 15
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                padding: const EdgeInsets.fromLTRB(25, 0, 20, 0),
                child: Column(
                  children: <Widget>[
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB( 0,30, 70.0,0),
                          child: Column(
                            children: [
                              CircleAvatar(backgroundColor: Colors.grey, backgroundImage:
                              AssetImage('assets/images/user.png'),),
                              Image(image:
                              AssetImage('assets/images/rating.png',),
                                width: 40,
                                color: Colors.yellow,
                              ),
                            ],
                          ),
                        ),
                        Text('Joe Doe'),
                        SizedBox(width: 10,),
                        Text('10',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 62.0),
                          child: Text('3.2 km'),
                        )
                      ],
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey, backgroundColor: const Color.fromARGB(255, 180, 214, 119),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        minimumSize: const Size(100, 30),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context,"deliveryinfo");
                      },
                      child: const Text("Accept",
                        style: TextStyle(
                            fontSize: 15
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                padding: const EdgeInsets.fromLTRB(25, 0, 20, 0),
                child: Column(
                  children: <Widget>[
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB( 0,30, 70.0,0),
                          child: Column(
                            children: [
                              CircleAvatar(backgroundColor: Colors.grey, backgroundImage:
                              AssetImage('assets/images/user.png'),),
                              Image(image:
                              AssetImage('assets/images/rating.png',),
                                width: 40,
                                color: Colors.yellow,
                              ),
                            ],
                          ),
                        ),
                        Text('Joe Doe'),
                        SizedBox(width: 10,),
                        Text('10',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 62.0),
                          child: Text('7.2 km'),
                        )
                      ],
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey, backgroundColor: const Color.fromARGB(255, 180, 214, 119),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        minimumSize: const Size(100, 30),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context,"");
                      },
                      child: const Text("Accept",
                        style: TextStyle(
                            fontSize: 15
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
