import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/donate/select_donate_item.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:line_icons/line_icons.dart';

class ViewIndiRecDetails extends StatefulWidget {
  const ViewIndiRecDetails({super.key});

  @override
  State<ViewIndiRecDetails> createState() => _ViewIndiRecDetailsState();
}

class _ViewIndiRecDetailsState extends State<ViewIndiRecDetails> {
  // firebase uid
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  // firestore strings

  String orgfName = '';
  String orgfUname = '';
  double distance = 0.0;
  String recLoc = '';

  // Get 0 = event name, 1 = event desc, 2 = org id, 3 = uid 4 = doc id

  Future loadInfo() async {
    String orgName = '';
    String orgUname = '';
    double donlat = 0.0;
    double donlng = 0.0;
    double reclat = 0.0;
    double reclng = 0.0;
    // await FirebaseFirestore.instance
    //     .collection('organizations')
    //     .doc(Get.arguments[0].toString())
    //     .get()
    //     .then(
    //   (querySnapshot) {
    //     orgName = querySnapshot.get('org_name');
    //   },
    // );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(Get.arguments[0].toString())
        .get()
        .then(
      (querySnapshot) {
        orgUname = querySnapshot.get('first_name') +
            ' ' +
            querySnapshot.get('last_name');
        reclat = querySnapshot.get('user_lat');
        reclng = querySnapshot.get('user_lng');
        recLoc = querySnapshot.get('user_location_name');
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
    setState(() {
      orgfName = orgName;
      orgfUname = orgUname;
    });
  }

  final List<IconData> iconList = [
    LineIcons.user,
    LineIcons.userSecret,
    LineIcons.userAlt,
    LineIcons.userGraduate,
    LineIcons.userTie,
    LineIcons.userAstronaut,
  ];

  final Random random = Random();

  IconData getRandomIcon() {
    int randomIndex = random.nextInt(iconList.length);
    return iconList[randomIndex];
  }

  @override
  void initState() {
    loadInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    IconData randomIcon = getRandomIcon();
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
                Text(
                  'User details',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                    child: Icon(
                  randomIcon,
                  size: 100,
                  color: Colors.deepPurple.shade300,
                )),
                const SizedBox(height: 40),
                // Looking For
                Text(
                  'Interested in:',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  Get.arguments[1].join(', '),
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade400,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Recipient\'s Location:',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                  ),
                ),
                // const SizedBox(height: 20),
                Text(
                  recLoc,
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

                const SizedBox(height: 40),
                InputButton1(
                  onTap: () {
                    Get.to(() => const DonateItemSelect(), arguments: [
                      Get.arguments[0].toString(),
                    ]);
                  },
                  text: 'Donate',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
