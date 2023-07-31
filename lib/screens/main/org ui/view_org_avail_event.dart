import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewOrgAvailEvents extends StatefulWidget {
  const ViewOrgAvailEvents({super.key});

  @override
  State<ViewOrgAvailEvents> createState() => _ViewOrgAvailEventsState();
}

class _ViewOrgAvailEventsState extends State<ViewOrgAvailEvents> {
  int orgRegStatus = 0;
  int recRegStatus = 0;

  // Future loadUserInfo() async {
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(uid)
  //       .get()
  //       .then((querySnapshot) {
  //     setState(() {
  //       firstName = querySnapshot.get('first_name');
  //       recRegStatus = querySnapshot.get('receiver_reg_status');
  //       orgRegStatus = querySnapshot.get('org_reg_status');
  //     });
  //   });
  // }

  @override
  void initState() {
    // loadUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'My events',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                Expanded(
                  child: ListTileTheme(
                    selectedColor: Colors.black,
                    child: ListView(
                      children: [
                        ListTile(
                          title: const Text('Start an event'),
                          onTap: () {
                            Get.to(() => const ViewOrgAvailEvents());
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
