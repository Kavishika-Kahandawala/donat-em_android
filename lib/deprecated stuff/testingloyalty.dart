import 'package:donatem/screens/main/loyalty/redeem_loyalty_amount.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestLoyalty extends StatefulWidget {
  const TestLoyalty({super.key});

  @override
  State<TestLoyalty> createState() => _TestLoyaltyState();
}

void onTap(){
  Get.to(() => const RedeemLoyaltyAmount(),arguments: ['loyaltyRedeem/P9fGmppFEjo0DdXwtv8U'.toString()]);
}

class _TestLoyaltyState extends State<TestLoyalty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple[200],
        body: const SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputButton1(onTap: onTap, text: 'text')
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
