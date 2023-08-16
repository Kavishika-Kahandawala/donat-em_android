import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/main/Activity/matching/don_match_dismissed.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';

class DonApprovalViewIndiMatchedItemDetails extends StatefulWidget {
  const DonApprovalViewIndiMatchedItemDetails({super.key});

  @override
  State<DonApprovalViewIndiMatchedItemDetails> createState() =>
      _DonApprovalViewIndiMatchedItemDetailsState();
}

class _DonApprovalViewIndiMatchedItemDetailsState
    extends State<DonApprovalViewIndiMatchedItemDetails> {
  // firebase uid
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();
  String itemCategory = '';
  String itemSubCategory = '';
  String productName = '';
  String productDesc = '';
  String donLoc = '';
  String refId='';
  String historyRefId='';
  String assignId = '';
  String recName='';
  String donorName='';
  String donorPhone='';

  double distance = 0.0;

  Future getData(String snapId, String recId) async {
    
    double donlat = 0.0;
    double donlng = 0.0;
    double reclat = 0.0;
    double reclng = 0.0;

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
        donorName = querySnapshot.get('first_name') + ' ' + querySnapshot.get('last_name');
        donorPhone = querySnapshot.get('mobile_number');
      });
    });
    // rec get data?
    await FirebaseFirestore.instance
        .collection('users')
        .doc(recId)
        .get()
        .then((querySnapshot) {
      donlat = querySnapshot.get('user_lat');
      donlng = querySnapshot.get('user_lng');
      donLoc = querySnapshot.get('user_location_name');
    });
    // donor get data
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((querySnapshot) {
      reclat = querySnapshot.get('user_lat');
      reclng = querySnapshot.get('user_lng');
      LatLng point1 = LatLng(donlat, donlng);
      LatLng point2 = LatLng(reclat, reclng);
      setState(() {

        distance = const Distance().as(
          LengthUnit.Kilometer,
          point1,
          point2,
        );
        print(distance);
      });
    });
  }

  Future recDismissed() async {
     await FirebaseFirestore.instance
        .collection('donate history')
        .doc(historyRefId)
        .set(
      {
        'assigned_status':0,
      },
      SetOptions(merge: true),
    );
     await FirebaseFirestore.instance
        .collection('donation items')
        .doc(refId)
        .set(
      {
        'assigned_status':0,
      },
      SetOptions(merge: true),
    );
    {
       Get.to(() => const DonRecMatchDismissed());
    }
  }

  @override
  void initState() {
    super.initState();
    refId = Get.arguments[0].toString();
    historyRefId = Get.arguments[1].toString();
    assignId = Get.arguments[2].toString();
    getData(Get.arguments[0].toString(), Get.arguments[2].toString());
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
                  'Donor\'s Location:',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                  ),
                ),
                // const SizedBox(height: 20),
                Text(
                  donLoc,
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade400,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Distance',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                  ),
                ),
                // const SizedBox(height: 20),
                Text(
                  distance.toString() + ' km',
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade400,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Recipient Name',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                  ),
                ),
                // const SizedBox(height: 20),
                Text(
                 donorName,
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade400,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Recipient Phone Number',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                  ),
                ),
                // const SizedBox(height: 20),
                Text(
                  donorPhone,
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade400,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
      
                const SizedBox(height: 40),
                InputButton1(
                  onTap: recDismissed,
                  text: 'Reject',
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
