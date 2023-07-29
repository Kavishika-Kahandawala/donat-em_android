import 'package:donatem/screens/main/org%20reg/org_reg_photo_upload.dart';
import 'package:donatem/screens/main/org%20reg/org_reg_thanks.dart';
import 'package:donatem/shared/app_agreement_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/inputButton_1.dart';

class OrgRegPhotoNotice extends StatelessWidget {
  const OrgRegPhotoNotice({super.key});

  void onTap() async {
    print(Get.arguments[0]);
    Get.to(() => const OrgRegPhotoUpload(), arguments: [Get.arguments[0].toString()]);
  }
  void skip() async {
    Get.to(() => const OrgRegThanks(), arguments: [Get.arguments[0].toString()]);
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
                    'Add a photo of your organization',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    AppAgreementText.orgRegPhotoNotice,
                    style: GoogleFonts.poppins(
                      color: Colors.grey.shade400,
                      fontSize: 20,
                    ),
                    // textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 100),
                  InputButton1(onTap: skip, text: "Skip"),
                  const SizedBox(height: 15),
                  InputButton1(onTap: onTap, text: "Continue"),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ));
  }
}
