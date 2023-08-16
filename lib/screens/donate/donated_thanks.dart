import 'package:donatem/screens/main/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart%20%20';

import '../../shared/inputButton_1.dart';

class DonatedThanks extends StatefulWidget {
  const DonatedThanks({super.key});

  @override
  State<DonatedThanks> createState() => _DonatedThanksState();
}

class _DonatedThanksState extends State<DonatedThanks> {
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
                    'Thank you for you donation',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Together',
                    style: GoogleFonts.poppins(
                      color: Colors.grey.shade400,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 60),
                  InputButton1(onTap: (){
                    Get.to(() => const MainPageUI());
                  }, text: "Add more Items"),
                  const SizedBox(height: 20),
                  InputButton1(onTap: (){
                    Get.to(() => const MainPageUI());
                  }, text: "Go to Home"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}