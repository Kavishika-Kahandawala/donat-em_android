import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/main/org%20ui/start%20event/start_org_event_thanks.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:donatem/shared/inputTextArea_1.dart';
import 'package:donatem/shared/inputTextArea_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class StartOrgEventDesc extends StatefulWidget {
  const StartOrgEventDesc({super.key});

  @override
  State<StartOrgEventDesc> createState() => _StartOrgEventDescState();
}

class _StartOrgEventDescState extends State<StartOrgEventDesc> {
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
    String orgId;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((querySnapshot) async {
      orgId = querySnapshot.get('org_id');
      returnDocID =
          await FirebaseFirestore.instance.collection('org events').add(
        {
          'org_id': orgId,
          'event_name': itemNameController.text.trim(),
          'event_desc': itemDescController.text.trim(),
          'uid': uid,
          // Only For 'status' is like this as no category section to load. 
          //Later this should be 'status' = 0 (There's no status 2 in this process (User friendliness)).
          'status': 2,
        },
      );
    });

    //pop loading circle
    Navigator.pop(context);
    {
      // Select Categories <<<<<<<<<<<<<< NOT THIS >>>>>>>>>>> TODO:
      Get.to(() => const StartOrgEventThanks(),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Start an event',
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

                const SizedBox(
                  height: 30,
                ),

                InputTextArea1(
                  controller: itemNameController,
                  hintText: 'Event Name',
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                InputTextArea2(
                  controller: itemDescController,
                  hintText: 'Event Description',
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
