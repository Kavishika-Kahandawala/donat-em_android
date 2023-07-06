import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputButton1 extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const InputButton1({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15.0),  //change button size
        // margin: const EdgeInsets.symmetric(horizontal: 25.0), //aligning horizontally with same gap
        decoration: BoxDecoration(
          color: Colors.deepPurple, //button color
          borderRadius: BorderRadius.circular(8), //circular touch
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 15,
              // fontWeight: FontWeight.bold [TOdo]
            ),
          ),
        ),
      ),
    );
  }
}
