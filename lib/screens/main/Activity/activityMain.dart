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
                'View my activity',
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
                        title: const Text('My donation items'),
                        onTap: () {
                          Get.to(() => const EditRecPref());
                        },
                      ),
                      ListTile(
                        title: const Text('Receiver approval pending items'),
                        onTap: () {
                          Get.to(() => const MatchItemSelect());
                        },
                      ),
                      ListTile(
                        title: const Text('Receiver finalized items'),
                        onTap: () {
                          Get.to(() => const RecievableItemSelect());
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
