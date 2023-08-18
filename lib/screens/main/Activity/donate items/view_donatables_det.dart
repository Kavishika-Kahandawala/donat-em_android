import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/main/Activity/donate%20items/view_donatables_dismissed.dart';
import 'package:donatem/screens/main/navigation_bar.dart';
import 'package:donatem/screens/qr/uni_qr.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewDonatablesItemItemDetails extends StatefulWidget {
  const ViewDonatablesItemItemDetails({super.key});

  @override
  State<ViewDonatablesItemItemDetails> createState() =>
      _ViewDonatablesItemItemDetailsState();
}

class _ViewDonatablesItemItemDetailsState
    extends State<ViewDonatablesItemItemDetails> {
  // firebase uid
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();
  String itemId = '';
  String itemCategory = '';
  String itemSubCategory = '';
  String productName = '';
  String productDesc = '';
  double estimation=0.0;

  Future getData(String snapId) async {

    await FirebaseFirestore.instance
        .collection('donation items')
        .doc(snapId)
        .get()
        .then((querySnapshot) {
      setState(() {
        itemCategory = querySnapshot.get('item_category');
        itemSubCategory = querySnapshot.get('item_sub_category');
        productName = querySnapshot.get('product_name');
        productDesc = querySnapshot.get('product_desc');
        estimation = querySnapshot.get('estimation').toDouble();
      });
    });
  }

  Future recDismissed() async {

    DocumentReference itemDocRef = FirebaseFirestore.instance.collection('donate history').doc(itemId);
    DocumentSnapshot documentSnapshot = await itemDocRef.get();
    if (documentSnapshot.exists) {
      await itemDocRef.set({'assigned_status': 0}, SetOptions(merge: true));
    }

     await FirebaseFirestore.instance
        .collection('donation items')
        .doc(itemId)
        .set(
      {
        'status': 5,
        'assigned_status':0,
      },
      SetOptions(merge: true),
    );
    {
       Get.to(() => const ViewDonatablesDismissed());
    }
  }

  @override
  void initState() {
    super.initState();
    itemId = Get.arguments[0].toString();
    getData(Get.arguments[0].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Item details'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepPurple.shade300,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Looking For
                Text(
                  'Item Name:',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                  ),
                ),
                // const SizedBox(height: 10),
                Text(
                  productName,
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade400,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Item Description:',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                  ),
                ),
                // const SizedBox(height: 20),
                Text(
                  productDesc,
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade400,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Item Category:',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                  ),
                ),
                // const SizedBox(height: 20),
                Text(
                  '$itemCategory - $itemSubCategory',
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade400,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Earnable loyalty points:',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                  ),
                ),
                // const SizedBox(height: 20),
                Text(
                  estimation.toString(),
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade400,
                    fontSize: 20,
                  ),
                ),
                
                const SizedBox(height: 20),
      
                const SizedBox(height: 40),
                InputButton1(
                  onTap: (){
                    Get.to(() => const HomeUI());
                  },
                  text: 'Back to Home',
                ),
                const SizedBox(height: 15),
                InputButton1(
                  onTap: (){
                    Get.to(() => const UniQr(),arguments: [itemId.toString()]);
                  },
                  text: 'SHow QR Code',
                ),
                const SizedBox(height: 15),
                InputButton1(
                  onTap: recDismissed,
                  text: 'Delete Item',
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
