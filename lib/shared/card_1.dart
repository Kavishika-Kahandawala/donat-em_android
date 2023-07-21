import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // height: 155,
        // width: 192,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(heading),
            Text(subHeading),
            // Expanded(
            //   child: Icon(
            //     LineIcons.byName(iconName),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
