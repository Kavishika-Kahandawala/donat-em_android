import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class Card3 extends StatelessWidget {
  // message Name
  final String heading;
  const Card3({super.key, required this.heading});

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(LineIcons.exclamationCircle, size: 40),
                    const SizedBox(height: 5),

                    // Heading
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'No $heading available right now. Please try again later',
                        textAlign: TextAlign.center,
                      ),
                    ),
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
