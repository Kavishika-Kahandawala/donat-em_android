import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/main/additem/item_desc.dart';
import 'package:donatem/screens/main/edit%20user/edit_user_details.dart';
import 'package:donatem/screens/main/org%20reg/org_reg_notice.dart';
import 'package:donatem/screens/main/org%20ui/org_ui_main.dart';
import 'package:donatem/screens/main/rec%20reg/rec_reg_notice.dart';
import 'package:donatem/screens/main/rec%20ui/rec_ui_main.dart';
import 'package:donatem/screens/main/wait%20for%20verify/wait_for_verify_notice.dart';
import 'package:donatem/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class UserProfileUI extends StatefulWidget {
  const UserProfileUI({super.key});

  @override
  State<UserProfileUI> createState() => _UserProfileUIState();
}

class _UserProfileUIState extends State<UserProfileUI> {
  // firebase uid
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  // firestore strings
  String firstName = '';

  int orgRegStatus = 0;
  int recRegStatus = 0;

  Future loadUserInfo() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((querySnapshot) {
      setState(() {
        firstName = querySnapshot.get('first_name');
        recRegStatus = querySnapshot.get('receiver_reg_status');
        orgRegStatus = querySnapshot.get('org_reg_status');
      });
    });
  }

  void signOutUser() {
    FirebaseAuth.instance.signOut();
    Get.to(() => const AuthService());
  }

  @override
  void initState() {
    loadUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // User details banner
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'Hello,',
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
            // blank box to separate
            const SizedBox(height: 20),
            // List view starts from here
            Expanded(
              child: ListTileTheme(
                selectedColor: Colors.black,
                child: ListView(
                  children: [
                    ListTile(
                      title: const Text('Donate an item'),
                      onTap: () {
                        Get.to(() => const ItemDetails());
                      },
                    ),
                    ListTile(
                      title: const Text('Edit profile'),
                      onTap: () {
                        Get.to(() => const EditUserDetails());
                      },
                    ),
                    // If user is a receiver
                    if (recRegStatus == 1) ...[
                      ListTile(
                        title: const Text('View as recipient'),
                        onTap: () {
                          Get.to(() => const RecMainUI());
                        },
                      )
                    ] else if (recRegStatus == 2) ...[
                      ListTile(
                        title: const Text('Apply as a recipient'),
                        onTap: () {
                          Get.to(() => const WaitForVerifyNotice());
                        },
                      )
                    ] else ...[
                      ListTile(
                        title: const Text('Apply as a recipient'),
                        onTap: () {
                          Get.to(() => RecRegNotice());
                        },
                      ),
                    ],
                    // If user has an organization
                    if (orgRegStatus == 1) ...[
                      ListTile(
                        title: const Text('View as organization'),
                        onTap: () {
                          Get.to(() => const OrgMainUI());
                        },
                      )
                    ] else if (orgRegStatus == 2) ...[
                      ListTile(
                        title: const Text('Apply as an organization'),
                        onTap: () {
                          Get.to(() => const WaitForVerifyNotice());
                        },
                      )
                    ] else ...[
                      ListTile(
                        title: const Text('Apply as an organization'),
                        onTap: () {
                          Get.to(() => const OrgRegNotice());
                        },
                      ),
                    ],
                    ListTile(
                      title: const Text('Log Out'),
                      onTap: () {
                        signOutUser();
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
