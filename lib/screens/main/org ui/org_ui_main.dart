import 'package:donatem/screens/main/org%20ui/exit%20org/exit_org_notice.dart';
import 'package:donatem/screens/main/org%20ui/org%20events%20handle/handle_view_all_events.dart';
import 'package:donatem/screens/main/org%20ui/start%20event/start_org_event_intro.dart';
import 'package:donatem/screens/main/org%20ui/view_org_avail_event.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart  ';

class OrgMainUI extends StatefulWidget {
  const OrgMainUI({super.key});

  @override
  State<OrgMainUI> createState() => _OrgMainUIState();
}

class _OrgMainUIState extends State<OrgMainUI> {
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
              const SizedBox(height: 20),
              Text(
                'Manage Your Organization',
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
                          Get.to(() => const StartOrgEventInto());
                        },
                      ),
                      ListTile(
                        title: const Text('View my events'),
                        onTap: () {
                          Get.to(() => const HandleOrgEventSelect());
                        },
                      ),
                      ListTile(
                        title: const Text('Exit from organization program'),
                        onTap: () {
                          Get.to(() => const ExitOrgNotice());
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
