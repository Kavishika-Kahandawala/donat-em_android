// deprecated TODO:
import 'package:donatem/shared/inputButton_1.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AgreeToBeRecipient extends StatefulWidget {
  const AgreeToBeRecipient({super.key});

  @override
  State<AgreeToBeRecipient> createState() => _AgreeToBeRecipientState();
}

class _AgreeToBeRecipientState extends State<AgreeToBeRecipient> {
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
                    'Thank you for your interest on applying as a recipient',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, fontSize: 32),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.deepPurple[400],
                    ),
                    child: const Text(
                        'Agreement sentences and maybe include description about the manual verification'),
                  ),
                  const Text(
                      'Hereby I certify above details are true, and agree to the donat\'em policies. I know violating above policies are prohibited and ready to receive any consequences.'),
                  InputButton1(
                      onTap: onTap, text: 'I understand and wish to proceed')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
