import 'package:donatem/screens/main/additem/photos%20upload/donation_photo_auth.dart';
import 'package:donatem/shared/app_agreement_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/inputButton_1.dart';


class ItemPhotoVerifyNotice extends StatelessWidget {
  const ItemPhotoVerifyNotice({super.key});

  void onTap() async {
    print('>>>>>>>>>>>>>> arg'+Get.arguments[0].toString());
    Get.to(() => const DonationPhotoAuth(),
        arguments: [Get.arguments[0].toString()]);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'User Agreement for the quality of the item',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    AppAgreementText.itemPhotoVerifyNoticeDonate,
                    style: GoogleFonts.poppins(
                      color: Colors.grey.shade400,
                      fontSize: 20,
                    ),
                    // textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 60),
                  InputButton1(onTap: onTap, text: "Done"),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ));
  }
}
