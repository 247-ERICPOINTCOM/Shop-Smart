import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shopsmartly/constants/constants.dart';

class ReviewOrder1 extends StatefulWidget {
  const ReviewOrder1({Key? key}) : super(key: key);

  @override
  State<ReviewOrder1> createState() => _ReviewOrder1State();
}

class _ReviewOrder1State extends State<ReviewOrder1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: kBackgroundColor,
        title: const Text(
          'Review Order',
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
              const SizedBox(
                height: 60,
              ),
              const Material(
                elevation: 5,
                child: TextField(
                  cursorColor: kPrimaryLightColor,
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Write Your Review",
                    // enabledBorder: OutlineInputBorder(
                    //
                    // ),
                    focusedBorder: OutlineInputBorder(
                      //borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(width: 0, color: kPrimaryColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              FloatingActionButton.extended(
                label: const Text('Submit Purchase Review', style: TextStyle(fontSize: 16),), // <-- Text
                backgroundColor: kPrimaryLightColor,
                elevation: 0,
                onPressed: () {
                  Navigator.pushNamed(context, "");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
