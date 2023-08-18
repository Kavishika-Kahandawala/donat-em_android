import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/main/Activity/donate%20completed%20items/completed_donatables.dart';
import 'package:donatem/screens/main/Activity/donate%20items%20approval/view_donatables_Approval.dart';
import 'package:donatem/screens/main/Activity/donate%20items/view_donatables.dart';
import 'package:donatem/screens/main/Activity/matching/don_view_matches.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ActivityUI extends StatefulWidget {
  const ActivityUI({super.key});

  @override
  State<ActivityUI> createState() => _ActivityUIState();
}

class _ActivityUIState extends State<ActivityUI> {
  // firestore strings
  String firstName = '';
  String greeting = '';
  String profileImage = 'default';

  // firebase uid
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  Future loadUserInfo() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((querySnapshot) {
      setState(() {
        firstName = querySnapshot.get('first_name');
        profileImage = querySnapshot.get('profile_picture');
      });
    });
  }

  void greetings() {
    final hour = TimeOfDay.now().hour;
    String output = 'Good Evening,';
    if (hour < 12) {
      output = 'Good Morning,';
    } else if (hour <= 17) {
      output = 'Good Afternoon,';
    }

    setState(() {
      greeting = output;
    });
  }

  @override
  void initState() {
    greetings();
    loadUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        greeting,
                        style: GoogleFonts.poppins(
                          // fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        firstName,
                        style: GoogleFonts.poppins(
                          // fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  // Container(
                  //   padding: const EdgeInsets.all(12),
                  //   decoration: BoxDecoration(
                  //     color: Colors.deepPurple[100],
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  //   child: const Icon(Icons.person),
                  // ),
                  if (profileImage == 'default') ...[
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.person),
                    ),
                  ] else ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      // ),
                      child: Image.network(profileImage,
                          height: 50, width: 50, fit: BoxFit.cover),
                    ),
                  ],
                ],
              ),
              // Text(
              //   'View my activity',
              //   style: GoogleFonts.poppins(
              //     fontWeight: FontWeight.bold,
              //     fontSize: 32,
              //   ),
              // ),

              const SizedBox(height: 30),
              Expanded(
                child: ListTileTheme(
                  selectedColor: Colors.black,
                  child: ListView(
                    children: [
                      ListTile(
                        title: const Text('My donation items'),
                        onTap: () {
                          Get.to(() => const ViewDonatables());
                        },
                      ),
                      ListTile(
                        title:
                            const Text('View approval pending donation items'),
                        onTap: () {
                          Get.to(() => const ViewDonatablesAproval());
                        },
                      ),
                      ListTile(
                        title: const Text('Receiver approval pending items'),
                        onTap: () {
                          Get.to(() => const DonMatchItemSelect());
                        },
                      ),
                      ListTile(
                        title: const Text('Receiver approval acquired items'),
                        onTap: () {
                          Get.to(() => const DonMatchItemSelect());
                        },
                      ),
                      ListTile(
                        title: const Text('Donated items'),
                        onTap: () {
                          Get.to(() => const CompletedViewDonatables());
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
    );
  }
}
