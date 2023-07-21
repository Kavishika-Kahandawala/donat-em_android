import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class Card2 extends StatelessWidget {
  // Org Name
  final String heading;
  // Event Heading
  final String subHeading;
  final String imageUrl;
  const Card2({super.key, required this.heading, required this.subHeading, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.deepPurple[100],
        ),
        child: Column(
          children: [
            // Image.asset(imageUrl, width: 40),
            Icon(LineIcons.byName('book')),
            const SizedBox(height: 10),
            
            // Heading
            Text(heading),
            const SizedBox(height: 10),

            // Sub Heading
            Text(subHeading)
          ],
        ),
      ),
    );
  }
}
