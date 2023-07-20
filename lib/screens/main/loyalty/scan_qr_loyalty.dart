import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScanQrLoyalty extends StatefulWidget {
  const ScanQrLoyalty({super.key});

  @override
  State<ScanQrLoyalty> createState() => _ScanQrLoyaltyState();
}

class _ScanQrLoyaltyState extends State<ScanQrLoyalty> {
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
                  const SizedBox(height: 50),
                  Text(
                    'Align the QR code within below box',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, fontSize: 32),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
