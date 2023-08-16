import 'package:donatem/screens/main/navigation_bar.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewDonatablesDismissed extends StatefulWidget {
  const ViewDonatablesDismissed({super.key});

  @override
  State<ViewDonatablesDismissed> createState() => _ViewDonatablesDismissedState();
}

class _ViewDonatablesDismissedState extends State<ViewDonatablesDismissed> {
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
                    'Item has been deleted',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Your item has been deleted from the database.',
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