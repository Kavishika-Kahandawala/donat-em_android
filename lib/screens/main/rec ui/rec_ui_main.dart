import 'package:donatem/screens/main/org%20ui/start%20event/start_org_event_intro.dart';
import 'package:donatem/screens/main/org%20ui/view_org_avail_event.dart';
import 'package:donatem/screens/main/rec%20ui/exit%20rec/exit_rec_notice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart  ';

class RecMainUI extends StatefulWidget {
  const RecMainUI({super.key});

  @override
  State<RecMainUI> createState() => _RecMainUIState();
}

class _RecMainUIState extends State<RecMainUI> {
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
                          Get.to(() => const StartOrgEventInto());
                        },
                      ),
                      ListTile(
                        title: const Text('View my receivable items status'),
                        onTap: () {
                          Get.to(() => const ViewOrgAvailEvents());
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
