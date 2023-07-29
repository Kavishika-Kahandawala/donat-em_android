import 'package:donatem/screens/main/rec%20reg/rec_reg_identity_photo_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RecRegPhotoNotice extends StatelessWidget {
  const RecRegPhotoNotice({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Text(
                  'Verify your identity',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 20),
                Text(
                  'This process requires uploading photos. Upload both sides of the selected documents.',
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade400,
                    fontSize: 20,
                  ),
                  // textAlign: TextAlign.left,
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: ListTileTheme(
                      selectedColor: Colors.black,
                      child: ListView(
                        children: [
                          ListTile(
                            title: const Text('Nation Identity Card (NIC)'),
                            onTap: () {
                              Get.to(() => const RecRegIdentityPhotoAuth(),
                                  arguments: ['nic'.toString()]);
                            },
                          ),
                          ListTile(
                            title: const Text('Driving License Card'),
                            onTap: () {
                              Get.to(() => const RecRegIdentityPhotoAuth(),
                                  arguments: ['driving_license'.toString()]);
                            },
                          ),
                          ListTile(
                            title: const Text('Birth Certificate'),
                            onTap: () {
                              Get.to(() => const RecRegIdentityPhotoAuth(),
                                  arguments: ['birth_certificate'.toString()]);
                            },
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}
