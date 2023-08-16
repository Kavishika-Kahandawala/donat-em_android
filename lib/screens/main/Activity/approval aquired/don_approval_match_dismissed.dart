import 'package:donatem/screens/main/navigation_bar.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DonRecMatchDismissed extends StatefulWidget {
  const DonRecMatchDismissed({super.key});

  @override
  State<DonRecMatchDismissed> createState() => _DonRecMatchDismissedState();
}

class _DonRecMatchDismissedState extends State<DonRecMatchDismissed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Item has been dismissed',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Current selected recipient has been removed from the list. Please select another recipient to donate to.',
                    style: GoogleFonts.poppins(
                      color: Colors.grey.shade400,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 60),
                  InputButton1(onTap: (){
                    Get.to(()=> const HomeUI());
                  }, text: "Complete Process"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}