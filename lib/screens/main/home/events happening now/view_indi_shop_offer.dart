import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/shared/app_img_urls.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class ViewIndiShopOfferDetails extends StatefulWidget {
  const ViewIndiShopOfferDetails({super.key});

  @override
  State<ViewIndiShopOfferDetails> createState() =>
      _ViewIndiShopOfferDetailsState();
}

class _ViewIndiShopOfferDetailsState extends State<ViewIndiShopOfferDetails> {
  // firebase uid
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  // firestore strings

  String shopName = '';
  String shopDesc = '';
  double distance = 0.0;
  String offerDesc = '';
  String shopLocation = '';
  String validTill = '';
  String docId = '';
  String bannerImage = 'default';

  // Get 0 = event name, 1 = event desc, 2 = org id, 3 = uid 4 = doc id

  Future loadInfo() async {
    double donlat = 0.0;
    double donlng = 0.0;
    double reclat = 0.0;
    double reclng = 0.0;
    await FirebaseFirestore.instance
        .collection('shop offers')
        .doc(Get.arguments[0].toString())
        .get()
        .then(
      (querySnapshot) {
        reclat = querySnapshot.get('shop_lat');
        reclng = querySnapshot.get('shop_lng');
        shopLocation = querySnapshot.get('shop_location');
        shopName = querySnapshot.get('shop_name');
        shopDesc = querySnapshot.get('shop_desc');
        offerDesc = querySnapshot.get('offer_desc');
        validTill = DateFormat.yMEd()
            .format(DateTime.parse(querySnapshot.get('valid_till')));
      },
    );
    // user get data
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((querySnapshot) {
      donlat = querySnapshot.get('user_lat');
      donlng = querySnapshot.get('user_lng');
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

  @override
  void initState() {
    docId = Get.arguments[0].toString();
    loadInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Back'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepPurple.shade300,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                // User details
                // Text(
                //   'Offer details',
                //   style: GoogleFonts.poppins(
                //     fontWeight: FontWeight.bold,
                //     fontSize: 30,
                //   ),
                // ),
                // const SizedBox(height: 10),
                // Center(
                //   child: Icon(
                //     randomIcon,
                //     size: 100,
                //     color: Colors.deepPurple.shade300,
                //   ),
                // ),
                // const SizedBox(height: 40),
                // Looking For
                // Text(
                //   'About shop',
                //   style: GoogleFonts.poppins(
                //     fontSize: 20,
                //   ),
                // ),
                // const SizedBox(height: 20),
                Text(
                  shopName,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 30),
                if (bannerImage == 'default') ...[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                      // ),
                      child: Image.network(AppImgUrls.defaultShopOffer,height: 200,width: MediaQuery.of(context).size.width,fit:BoxFit.cover),
                    ),
                    ] else...[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                      // ),
                      child: Image.network(bannerImage,height: 50,width: 50,fit:BoxFit.cover),
                    ),
                    ],
                    const SizedBox(height: 20),

                Text(
                  shopDesc,
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade400,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'About offer',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                  ),
                ),
                Text(
                  offerDesc,
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade400,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Location:',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                  ),
                ),
                // const SizedBox(height: 20),
                Text(
                  shopLocation,
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
                const SizedBox(height: 20),
                Text(
                  'Valid till',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                  ),
                ),
                // const SizedBox(height: 20),
                Text(
                  validTill,
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade400,
                    fontSize: 20,
                  ),
                ),

                const SizedBox(height: 40),
                InputButton1(
                  onTap: () {
                    Get.back();
                  },
                  text: 'Go back',
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
