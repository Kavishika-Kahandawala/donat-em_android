import 'package:donatem/screens/main/navigation_bar.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OrgRegThanks extends StatelessWidget {
  const OrgRegThanks({super.key});

  void onTap() async {
    Get.to(() => const HomeUI());
  }

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
                    'Thank you for signing up as an organization',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'We received your application and will review it as soon as possible. We might contact you via Email.',
                    style: GoogleFonts.poppins(
                      color: Colors.grey.shade400,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 60),
                  InputButton1(onTap: onTap, text: "Complete Process"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
