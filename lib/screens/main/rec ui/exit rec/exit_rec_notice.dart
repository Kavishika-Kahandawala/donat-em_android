import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/main/org%20reg/org_reg_desc.dart';
import 'package:donatem/screens/main/rec%20ui/exit%20rec/exit_rec_sorry_to_see_you_go.dart';
import 'package:donatem/shared/app_agreement_text.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ExitRecNotice extends StatefulWidget {
  const ExitRecNotice({super.key});

  @override
  State<ExitRecNotice> createState() => _ExitRecNoticeState();
}

class _ExitRecNoticeState extends State<ExitRecNotice> {
  //Get current logged user id
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  Future deleteData() async {
    // show loading icon
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    // change data in collection 'users'
    await FirebaseFirestore.instance.collection('users').doc(uid).set(
      {
        'receiver_reg_status': 0,
      },
      SetOptions(merge: true),
    );
    // delete data in collection 'users'
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'rec_reg_identity_photo_type': FieldValue.delete(),
      'rec_reg_identity_photo_step': FieldValue.delete()
    });
    //delete data in collection 'rec reg identity'
    await FirebaseFirestore.instance
        .collection('rec reg identity')
        .doc(uid)
        .delete();
    //pop loading circle
    Navigator.pop(context);
    {
      Get.to(() => const ExitRecSorryToGoNotice());
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
                    'Please read the following carefully before proceeding',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    AppAgreementText.exitRecNotice,
                    style: GoogleFonts.poppins(
                      color: Colors.grey.shade400,
                      fontSize: 20,
                    ),
                    // textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 60),
                  Divider(thickness: 1, color: Colors.grey.shade300),
                  Text(
                    'By continuing I agree to above conditions and I am responsible for my actions.',
                    style: GoogleFonts.poppins(
                      color: Colors.grey.shade400,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  InputButton1(
                      onTap: deleteData, text: "Exit From the program"),

                  // textAlign: TextAlign.left,
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ));
  }
}
