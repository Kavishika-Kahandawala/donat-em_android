import 'package:donatem/shared/inputButton_1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

class UniQr extends StatefulWidget {
  const UniQr({super.key});

  @override
  State<UniQr> createState() => _UniQrState();
}

class _UniQrState extends State<UniQr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple[200],
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                      Text(
                        'Your QR Code',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                      const SizedBox(height: 30),
                      QrImageView(data: Get.arguments[0].toString(),size: 250),
                      const SizedBox(height: 30),
                      InputButton1(onTap: (){
                        Get.back();
                      }, text: 'Done')
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
