import 'package:donatem/shared/inputButton_1.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/got_match_det_text.dart';

class GotMatchUI extends StatefulWidget {
  const GotMatchUI({super.key});

  @override
  State<GotMatchUI> createState() => _GotMatchUIState();
}

class _GotMatchUIState extends State<GotMatchUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // Text -> Possible match found
              Text(
                'We found a possible match on your item',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),

              // User uploaded image
              Image.asset('lib/assets/images/image1.jpg', width: 40),

              // Details
              //
              // Item Name
              const GotMatchDet(
                  heading: 'Item Name : ', subHeading: 'sample subtext'),
                  // Item Category
              const GotMatchDet(
                  heading: 'Category : ', subHeading: 'sample subtext'),
                  InputButton1(onTap: onTap, text: 'View Details')
            ],
            
          )),
        ),
      ),
    );
  }
}
