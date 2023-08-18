import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/main/org%20ui/org%20event%20accept%20item/scan_qr_org_event_item.dart';
import 'package:donatem/screens/main/org%20ui/org%20events%20handle/handle_event_dismissed.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';

class HandleOrgEventDetails extends StatefulWidget {
  const HandleOrgEventDetails({super.key});

  @override
  State<HandleOrgEventDetails> createState() => _HandleOrgEventDetailsState();
}

class _HandleOrgEventDetailsState extends State<HandleOrgEventDetails> {
  // firebase uid
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  // firestore strings

  String orgfName = '';
  String orgfUname = '';
  String docId = '';
  List eventFCats = [];
  String eventFImg = '';
  double distance = 0.0;
  String recLoc = '';
  String eventFName = '';
  String eventFDesc = '';

  String _getDisplayText(List subHeading) {
      return subHeading.join(', '); // Display all items
  }

  // Get 0 = event name, 1 = event desc, 2 = org id, 3 = uid 4 = doc id

  Future loadInfo() async {
    String orgName = '';
    String orgUname = '';
    String orgId = '';
    String orguid = '';
    List eventCats = [];
    double donlat = 0.0;
    double donlng = 0.0;
    double reclat = 0.0;
    double reclng = 0.0;
    String eventTempImg = '';
    String eventImg = '';
     await FirebaseFirestore.instance
        .collection('org events')
        .doc(Get.arguments[0].toString())
        .get()
        .then(
      (querySnapshot) {
        // orgName = querySnapshot.get('org_name');
        eventCats = querySnapshot.get('event_cats');
        orgId = querySnapshot.get('org_id');
        orgId = querySnapshot.get('org_id');
        eventFName = querySnapshot.get('event_name');
        eventFDesc = querySnapshot.get('event_desc');
        reclat = querySnapshot.get('event_lat');
        reclng = querySnapshot.get('event_lng');
        recLoc = querySnapshot.get('event_location_name');

        // eventTempImg = querySnapshot.get('event_banner');
        // if (eventTempImg == 'default') {
        //   eventImg = AppImgUrls.defaultEvent;
        // } else {
        //   eventImg = eventTempImg;
        // }

      },
    );
    await FirebaseFirestore.instance
        .collection('organizations')
        .doc(orgId)
        .get()
        .then(
      (querySnapshot) {
        orgName = querySnapshot.get('org_name');
        orguid = querySnapshot.get('uid');
      },
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(orguid)
        .get()
        .then(
      (querySnapshot) {
        orgUname = querySnapshot.get('first_name') +
            ' ' +
            querySnapshot.get('last_name');
      },
    );
    await FirebaseFirestore.instance.collection('users').doc(uid).get().then(
      (querySnapshot) {
        // orgUname = querySnapshot.get('first_name') +
        //     ' ' +
        // querySnapshot.get('last_name');
        donlat = querySnapshot.get('user_lat');
        donlng = querySnapshot.get('user_lng');
      },
    );
    setState(() {
      LatLng point1 = LatLng(donlat, donlng);
      LatLng point2 = LatLng(reclat, reclng);
      distance = const Distance().as(
        LengthUnit.Kilometer,
        point1,
        point2,
      );
      eventFImg = eventImg;
      eventFCats = eventCats;
      orgfName = orgName;
      orgfUname = orgUname;
    });
  }

  Future recDismissed() async {
     await FirebaseFirestore.instance
        .collection('org events')
        .doc(docId)
        .set(
      {
        'status':0,
      },
      SetOptions(merge: true),
    );
    {
       Get.to(() => const HandleOrgEventDismissed());
    }
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
        title: const Text('All Events'),
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
                //image
                // Image.network(eventFImg,
                //     width: 200, height: 200, fit: BoxFit.cover),
                // Event Name
                Text(
                  eventFName,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 10),
                // Event desc
                Text(
                  eventFDesc,
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade400,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 40),
                // org Name
                Text(
                  'By:',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                  ),
                ),
                Text(
                  orgfName,
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade400,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                // org User's name
                Text(
                  'Founder:',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                  ),
                ),
                Text(
                  orgfUname,
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade400,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Event is for:',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                  ),
                ),
                Text(
                  _getDisplayText(eventFCats),
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade400,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Event Location:',
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
                    Get.to(() => const OrgEventAcceptItemQrRead());
                  },
                  text: 'Scan to accept item',
                ),
                const SizedBox(height: 15),
                InputButton1(
                  onTap: recDismissed,
                  text: 'End event',
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
