import 'package:donatem/shared/inputButton_1.dart';
import 'package:flutter/material.dart';

class LoyaltyUI extends StatefulWidget {
  const LoyaltyUI({super.key});

  @override
  State<LoyaltyUI> createState() => _LoyaltyUIState();
}

class _LoyaltyUIState extends State<LoyaltyUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Loyalty Points'),
                  const Text('100'),
                  //Redeem info
                  const Text('How to redeem sentences here'),
                  InputButton1(onTap: onTap, text: 'Scan QR')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
