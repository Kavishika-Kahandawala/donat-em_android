import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/main/additem/item_tags.dart';
import 'package:donatem/shared/app_colors.dart';
import 'package:donatem/shared/card_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/inputButton_1.dart';

class ItemCategory extends StatefulWidget {
  // Item Id
  final String itemDocId;

  const ItemCategory({super.key, required this.itemDocId});

  @override
  State<ItemCategory> createState() => _ItemCategoryState();
}

class _ItemCategoryState extends State<ItemCategory> {

  // Input controllers
  final itemNameController = TextEditingController();
  // Get current logged user id
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  // Next method
  Future nextStep(String categoryName) async {
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
        'item_category': categoryName,
      },
      SetOptions(merge: true),
    );
    //pop loading circle
    Navigator.pop(context);
    {
      await Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return ItemTags(itemDocId: widget.itemDocId);
        },
      ));
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
                  'Pick category',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 20),

                //A category Card
                GestureDetector(
                  onTap: () => nextStep('educational'),
                  child: const Card1(
                      backgroundColor: AppColors.deepPurple,
                      heading: 'Educational',
                      subHeading: '',
                      iconName: 'Icons.book'),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
