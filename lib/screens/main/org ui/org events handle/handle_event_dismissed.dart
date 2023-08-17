import 'package:donatem/screens/main/navigation_bar.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HandleOrgEventDismissed extends StatefulWidget {
  const HandleOrgEventDismissed({super.key});

  @override
  State<HandleOrgEventDismissed> createState() => _HandleOrgEventDismissedState();
}

class _HandleOrgEventDismissedState extends State<HandleOrgEventDismissed> {
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
                    'Event ended',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'We hope you had a great time. We will be waiting for you to host an event again.',
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