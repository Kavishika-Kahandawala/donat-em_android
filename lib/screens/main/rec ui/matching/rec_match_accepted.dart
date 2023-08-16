import 'package:donatem/screens/main/navigation_bar.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart%20%20';

class RecMatchAccepted extends StatefulWidget {
  const RecMatchAccepted({super.key});

  @override
  State<RecMatchAccepted> createState() => _RecMatchAcceptedState();
}

class _RecMatchAcceptedState extends State<RecMatchAccepted> {
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
                    'Item has been accepted',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'You can now contact the donor to arrange for pickup/delivery of the item.',
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
