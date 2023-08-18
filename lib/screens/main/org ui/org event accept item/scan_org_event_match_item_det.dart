import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/main/org%20ui/org%20event%20accept%20item/scan_qr_org_event_match_accepted.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';

class ScanQROrgEventViewItemDetails extends StatefulWidget {
  const ScanQROrgEventViewItemDetails({super.key});

  @override
  State<ScanQROrgEventViewItemDetails> createState() =>
      _ScanQROrgEventViewItemDetailsState();
}

class _ScanQROrgEventViewItemDetailsState
    extends State<ScanQROrgEventViewItemDetails> {
  // firebase uid
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();
  String itemCategory = '';
  String itemSubCategory = '';
  String productName = '';
  String productDesc = '';
  String donLoc = '';
  String refId='';
  String donorName='';
  String donorPhone='';
  double donorLoyalty=0.0;
  double estimation=0.0;
  String donId = '';

  double distance = 0.0;

  Future getData(String snapId) async {
    
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
        donId = querySnapshot.get('uid');
        // donFinalId = querySnapshot.get('uid');
        estimation = querySnapshot.get('estimation').toDouble();
      });
    });
    // donor get data?
    await FirebaseFirestore.instance
        .collection('users')
        .doc(donId)
        .get()
        .then((querySnapshot) {
      donlat = querySnapshot.get('user_lat');
      donlng = querySnapshot.get('user_lng');
      donLoc = querySnapshot.get('user_location_name');
        donorName = querySnapshot.get('first_name') + ' ' + querySnapshot.get('last_name');
        donorPhone = querySnapshot.get('mobile_number');
        donorLoyalty = querySnapshot.get('loyalty_points').toDouble();
    });
    // user get data
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
      });
    });
  }

  Future recAccepted() async {
     await FirebaseFirestore.instance
        .collection('donate history')
        .doc()
        .set(
      {
        'competed_date':DateTime.now().toString(),
        'date':DateTime.now().toString(),
        'item_owner':donId,
        'item_title':productName,
        'item':refId,
        'type':'event',
        'assigned_status':1,
        'status':'completed',
      },
      SetOptions(merge: true),
    );
    await FirebaseFirestore.instance
        .collection('donation items')
        .doc(refId)
        .set(
      {
        'assigned_to': uid,
        'status': 4,
        'assigned_status':1,
      },
      SetOptions(merge: true),
    );
    // loyalty
    await FirebaseFirestore.instance
        .collection('users')
        .doc(donId)
        .set(
      {
        'loyalty_points':donorLoyalty+estimation,
      },
      SetOptions(merge: true),
    );
    {
       Get.to(() => const ScanQROrgEventReceiveMatchAccepted());
    }
  }

  @override
  void initState() {
    super.initState();
    refId = Get.arguments[0].toString();
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
                  'Donor Name',
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
                  'Donor Phone Number',
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
                  onTap: recAccepted,
                  text: 'Accept Item',
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
