import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class Intro1 extends StatelessWidget {
  const Intro1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      
      body: Center(
        child: 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.network(
                    'https://assets6.lottiefiles.com/packages/lf20_1a8dx7zj.json',repeat: false),
                    Text(
                'Have those stuff you no longer use?',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  // fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              ],
            ),
          ),
        
      ),
    );
  }
}
