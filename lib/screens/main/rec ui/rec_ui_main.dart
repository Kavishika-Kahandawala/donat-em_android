import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/main/org%20ui/view_org_avail_event.dart';
import 'package:donatem/screens/main/rec%20ui/edit%20preferences/edit_rec_pref.dart';
import 'package:donatem/screens/main/rec%20ui/exit%20rec/exit_rec_notice.dart';
import 'package:donatem/screens/main/rec%20ui/matching/view_matches.dart';
import 'package:donatem/screens/main/rec%20ui/recievable%20items/view_recievables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart  ';

class RecMainUI extends StatefulWidget {
  const RecMainUI({super.key});

  @override
  State<RecMainUI> createState() => _RecMainUIState();
}

class _RecMainUIState extends State<RecMainUI> {
    // firestore strings
  String firstName = '';
  String greeting = '';

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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
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
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.person),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'View my recipient account',
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
                        title: const Text('Edit my preferences'),
                        onTap: () {
                          Get.to(() => const EditRecPref());
                        },
                      ),
                      ListTile(
                        title: const Text('View matched items'),
                        onTap: () {
                          Get.to(() => const MatchItemSelect());
                        },
                      ),
                      ListTile(
                        title: const Text('View my receivable items'),
                        onTap: () {
                          Get.to(() => const RecievableItemSelect());
                        },
                      ),
                      ListTile(
                        title: const Text('Exit from recipient program'),
                        onTap: () {
                          Get.to(() => const ExitRecNotice());
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
