import 'package:donatem/screens/main/Activity/donate%20items%20approval/view_donatables_Approval.dart';
import 'package:donatem/screens/main/Activity/donate%20items/view_donatables.dart';
import 'package:donatem/screens/main/Activity/matching/don_view_matches.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ActivityUI extends StatefulWidget {
  const ActivityUI({super.key});

  @override
  State<ActivityUI> createState() => _ActivityUIState();
}

class _ActivityUIState extends State<ActivityUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Home'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepPurple.shade300,
        elevation:0.0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'View my activity',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
              
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
                        title: const Text('View approval pending donation items'),
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
                          // Get.to(() => const RecievableItemSelect());
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
