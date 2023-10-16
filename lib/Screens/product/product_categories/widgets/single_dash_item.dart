import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopsmartly/constants/constants.dart';

class SingleCardItem extends StatelessWidget {
  final String title;
  final void Function()? onPressed;

  const SingleCardItem(
      {super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: kPrimaryLightColor,
          ),
          width: double.infinity,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
