import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/shared/app_colors.dart';
import 'package:donatem/shared/card_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/inputButton_1.dart';
import '../../../shared/inputTextArea_1.dart';
import '../../../shared/inputTextArea_2.dart';

class ItemImage extends StatefulWidget {
  // Item Id
  final String itemDocId;

  const ItemImage({super.key, required this.itemDocId});

  @override
  State<ItemImage> createState() => _ItemImageState();
}

class _ItemImageState extends State<ItemImage> {
  // Get current logged user id
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();

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
    await FirebaseFirestore.instance
        .collection('donation items')
        .doc(widget.itemDocId)
        .set(
      {
        // 'item_tags': itemTagController.text.trim(),
      },
      SetOptions(merge: true),
    );
    //pop loading circle
    Navigator.pop(context);
    // {
    //   await Navigator.push(context, MaterialPageRoute(
    //     builder: (context) {
    //       return const StepperHome();
    //     },
    //   ));
    // }
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
                  'Enter tags to make it easier for users to find',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 20),

                // Add image icon
                
                GestureDetector(
                  onTap: selectImage,
                  child: Container(
                      // margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(3.5),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.deepPurple.shade300)),
                      child: Icon(
                        Icons.date_range,
                        color: Colors.deepPurple.shade300,
                      )),
                ),
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
