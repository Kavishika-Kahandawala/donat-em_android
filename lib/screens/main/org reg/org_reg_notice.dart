import 'package:donatem/screens/main/org%20reg/org_reg_desc.dart';
import 'package:donatem/shared/app_agreement_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../shared/inputButton_1.dart';

class OrgRegNotice extends StatelessWidget {
  const OrgRegNotice({super.key});


  void onTap() async {
    Get.to(() => const OrgRegGetDetails());
  }

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
                  Text(
                    'User Agreement signing up as an organization',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    AppAgreementText.orgRegNotice,
                    style: GoogleFonts.poppins(
                      color: Colors.grey.shade400,
                      fontSize: 20,
                    ),
                    // textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 60),
                  Divider(thickness: 1, color: Colors.grey.shade300),
                  Text(
                    'By continuing you agree to the Donat\'em terms and conditions',
                    style: GoogleFonts.poppins(
                      color: Colors.grey.shade400,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  InputButton1(onTap: onTap, text: "Continue"),

                  // textAlign: TextAlign.left,
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ));
  }
}
