import 'package:flutter/material.dart';

class TopTitles extends StatelessWidget {
  final String title, subtitle;

  const TopTitles({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const SizedBox(
        //   height: kToolbarHeight + 12,
        // ),
        if (title == "Delivery Login" || title == "Create Account" || title == "Forgot Password" || title == "Admin Login" || title == "Customer Login" || title == "Business Owner Login")
          GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.arrow_back_ios)),
        SizedBox(
          height: 12.0,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
      ],
    );
  }
}
