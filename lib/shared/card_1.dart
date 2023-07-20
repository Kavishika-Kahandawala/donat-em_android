import 'package:flutter/material.dart';

class Card1 extends StatelessWidget {
  final Color backgroundColor;
  final String heading;
  final String subHeading;
  final String iconName;

  const Card1(
      {super.key,
      required this.backgroundColor,
      required this.heading,
      required this.subHeading,
      required this.iconName});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 155,
      // width: 192,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(heading),
          Text(subHeading),
          Expanded(child: Icon(iconName as IconData?))
        ],
      ),
    );
  }
}
