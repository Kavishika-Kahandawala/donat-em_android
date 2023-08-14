import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewIndiEventDetails extends StatefulWidget {
  const ViewIndiEventDetails({super.key});

  @override
  State<ViewIndiEventDetails> createState() => _ViewIndiEventDetailsState();
}

class _ViewIndiEventDetailsState extends State<ViewIndiEventDetails> {
  // firebase uid
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  // firestore strings

  String orgfName = '';
  String orgfUname = '';

  // Get 0 = event name, 1 = event desc, 2 = org id, 3 = uid 4 = doc id

  Future loadInfo() async {
    String orgName = '';
    String orgUname = '';
    await FirebaseFirestore.instance
        .collection('organizations')
        .doc(Get.arguments[2].toString())
        .get()
        .then(
      (querySnapshot) {
        orgName = querySnapshot.get('org_name');
      },
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(Get.arguments[3].toString())
        .get()
        .then(
      (querySnapshot) {
        orgUname = querySnapshot.get('first_name') +
            ' ' +
            querySnapshot.get('last_name');
      },
    );
    setState(() {
      orgfName = orgName;
      orgfUname = orgUname;
    });
  }

  @override
  void initState() {
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
                // Event Name
                Text(
                  Get.arguments[0],
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 10),
                // Event desc
                Text(
                  Get.arguments[1],
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
                const SizedBox(height: 40),
                InputButton1(
                  onTap: () {
                    Get.to(() => const ViewIndiEventDetails(), arguments: [
                      Get.arguments[0],
                      // eventDesc.toString(),
                      // orgId.toString(),
                      uid.toString()
                    ]);
                  },
                  text: 'Participate in this event',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
