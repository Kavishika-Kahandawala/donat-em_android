import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/authenticate/reg_steppers/step_photo_upload.dart';
import 'package:donatem/screens/authenticate/reg_steppers/stepper_home.dart';
import 'package:donatem/shared/app_agreement_text.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';



class RegStepPhotoNotice extends StatefulWidget {
  
  const RegStepPhotoNotice({super.key});

  @override
  State<RegStepPhotoNotice> createState() => _RegStepPhotoNoticeState();
}

class _RegStepPhotoNoticeState extends State<RegStepPhotoNotice> {
   // Get current logged user id
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  void onTap() async {
    Get.to(() => const RegStepPhotoUpload());
  }

  // skip button
  void skip() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(
      {
        'profile_picture': 'default',
        'reg_step': 2,
      },
      SetOptions(merge: true),
    );
    await Get.to(() => const StepperHome());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Add a profile photo',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 40),
            Text(
              AppAgreementText.userPhotoNotice,
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
        );
  }
}
