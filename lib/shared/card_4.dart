import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class Card4 extends StatelessWidget {
  // Org Name
  final String heading;
  // Event Heading
  final String subHeading;
  final String imageUrl;
  const Card4(
      {super.key,
      required this.heading,
      required this.subHeading,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Material(
        child: InkWell(
          onTap: () {},
          child: Ink(
            width: MediaQuery.of(context).size.width * 0.80,
            color: Colors.deepPurple[100],
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        // Heading
                        Text(heading),
                        const SizedBox(height: 10),

                        // Sub Heading
                        Text(subHeading)
                      ],
                    ),
                    const Icon(LineIcons.chevronRight)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
