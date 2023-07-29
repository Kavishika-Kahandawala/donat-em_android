import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/main/rec%20reg/rec_reg_photo_notice.dart';
import 'package:donatem/shared/app_agreement_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/inputButton_1.dart';

class RecRegNotice extends StatelessWidget {
  RecRegNotice({super.key});

  final String uid = FirebaseAuth.instance.currentUser!.uid.toString();
  Future onTap() async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set(
      {
        'rec_reg_identity_photo_step': 0,
      },
      SetOptions(merge: true),
    );
    {
      await Get.to(() => const RecRegPhotoNotice());
    }
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
                    'User Agreement for signing up as a recipient',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    AppAgreementText.recRegNotice,
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
