import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/main/org%20reg/org_reg_photo_notice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/inputButton_1.dart';
import '../../../shared/inputTextArea_1.dart';
import '../../../shared/inputTextArea_2.dart';

class OrgRegGetDetails extends StatefulWidget {
  const OrgRegGetDetails({super.key});

  @override
  State<OrgRegGetDetails> createState() => _OrgRegGetDetailsState();
}

class _OrgRegGetDetailsState extends State<OrgRegGetDetails> {
  // Input controllers
  final itemNameController = TextEditingController();
  final itemDescController = TextEditingController();

  List<int> selectedItems = [];

// Get current logged user id
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();
  dynamic returnDocID;

  // Next method
  Future nextStep() async {
    // show loading icon
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    returnDocID =
        await FirebaseFirestore.instance.collection('organizations').add(
      {
        'org_name': itemNameController.text.trim(),
        'org_desc': itemDescController.text.trim(),
        'uid': uid,
        'status': 0,
      },
    );

    await FirebaseFirestore.instance.collection('users').doc(uid).set(
      {
        'org_reg_status': 2,
      },
      SetOptions(merge: true),
    );

    //pop loading circle
    Navigator.pop(context);
    {
      Get.to(() => const OrgRegPhotoNotice(),
          arguments: [returnDocID.id.toString()]);
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
                  'Apply as an Organization',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                Text(
                  'Together, let\'s help each others who are in need',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.grey.shade400,
                  ),
                ),

                InputTextArea1(
                  controller: itemNameController,
                  hintText: 'Organization Name',
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                InputTextArea2(
                  controller: itemDescController,
                  hintText: 'Organization Description',
                  obscureText: false,
                  minLines: 5,
                  maxLines: 5,
                ),
                const SizedBox(height: 20),

                // Next  button
                InputButton1(
                  onTap: nextStep,
                  text: 'Next',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
