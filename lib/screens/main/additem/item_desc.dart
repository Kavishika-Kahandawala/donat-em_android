import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/main/additem/item_cat.dart';
import 'package:donatem/shared/card_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/app_colors.dart';
import '../../../shared/card_1.dart';
import '../../../shared/inputButton_1.dart';
import '../../../shared/inputTextArea_1.dart';
import '../../../shared/inputTextArea_2.dart';

class ItemDetails extends StatefulWidget {
  const ItemDetails({super.key});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  
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
        await FirebaseFirestore.instance.collection('donation items').add(
      {
        'product_name': itemNameController.text.trim(),
        'product_desc': itemDescController.text.trim(),
        'uid': uid,
        'status': 0,
      },
    );

    //pop loading circle
    Navigator.pop(context);
    {
      // await Navigator.push(context, MaterialPageRoute(
      //   builder: (context) {
      //     return ItemCategory(itemDocId: returnDocID.toString());
      //   },
      // ));
      Get.to(()=> const ItemCategory(), arguments: [returnDocID.id.toString()]);
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
                  'Add an item to donate',
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
                // SizedBox(
                //   child: Row(
                //     children: [
                //       Card2(
                //           heading: 'heading',
                //           subHeading: 'subHeading',
                //           imageUrl: 'books'),
                //       Card2(
                //           heading: 'heading',
                //           subHeading: 'subHeading',
                //           imageUrl: 'books'),
                          
                //     ],
                //   ),
                // ),

                InputTextArea1(
                  controller: itemNameController,
                  hintText: 'Item Name',
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                InputTextArea2(
                  controller: itemDescController,
                  hintText: 'Item Description',
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
