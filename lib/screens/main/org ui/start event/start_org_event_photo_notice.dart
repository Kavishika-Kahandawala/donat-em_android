import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/main/org%20reg/org_reg_photo_upload.dart';
import 'package:donatem/screens/main/org%20ui/start%20event/start_org_event_thanks.dart';
import 'package:donatem/shared/app_agreement_text.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class StartOrgEventPhotoNotice extends StatelessWidget {
  const StartOrgEventPhotoNotice({super.key});

  void onTap() async {
    print(Get.arguments[0]);
    Get.to(() => const OrgRegPhotoUpload(), arguments: [Get.arguments[0].toString()]);
  }

  // skip button
  void skip() async {
    await FirebaseFirestore.instance
        .collection('org events')
        .doc(Get.arguments[0].toString())
        .set(
      {
        'event_banner': 'default',
        'status': 1,
      },
      SetOptions(merge: true),
    );
    await Get.to(() => const StartOrgEventThanks(), arguments: [Get.arguments[0].toString()]);
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
                    AppAgreementText.startOrgEventPhotoNotice,
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
