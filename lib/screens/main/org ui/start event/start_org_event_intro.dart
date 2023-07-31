import 'package:donatem/screens/main/org%20ui/start%20event/start_org_event_desc.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class StartOrgEventInto extends StatefulWidget {
  const StartOrgEventInto({super.key});

  @override
  State<StartOrgEventInto> createState() => _StartOrgEventIntoState();
}

void onTap() async {
    Get.to(()=> const StartOrgEventDesc());
  }

class _StartOrgEventIntoState extends State<StartOrgEventInto> {
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
                    'Let\'s start an event !',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Together, let\'s help each others who are in need',
                    style: GoogleFonts.poppins(
                      color: Colors.grey.shade400,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 60),
                  InputButton1(onTap: onTap, text: "Start an event"),],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
