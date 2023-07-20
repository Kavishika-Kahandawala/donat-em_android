import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GotMatchDet extends StatelessWidget {
  final String heading;
  final String subHeading;
  const GotMatchDet(
      {super.key, required this.heading, required this.subHeading});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            heading,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: Colors.black,
            ),
          ),
          Text(
            subHeading,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }
}
