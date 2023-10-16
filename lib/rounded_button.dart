import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ordersubmit extends StatefulWidget {
  const ordersubmit({Key? key}) : super(key: key);

  @override
  State<ordersubmit> createState() => _ReviewOrder1State();
}

class _ReviewOrder1State extends State<ordersubmit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(253, 237, 237, 1.0),
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: const Text(
          'Review Order',
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
            const SizedBox(height: 20), // Add some spacing

            // Your Order Has Been Placed message
            Text(
              'Your Order Has Been Placed',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green, // You can change the color
              ),
            ),

            // Thank you message
            const SizedBox(height: 20), // Add some spacing
            Text(
              "Thank you for ordering with us! We'll contact you by email with your order details.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black, // You can change the color
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
