import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/main/loyalty/redeem_shop_loyalty_thanks.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:donatem/shared/inputTextArea_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RedeemLoyaltyAmount extends StatefulWidget {
  const RedeemLoyaltyAmount({super.key});

  @override
  State<RedeemLoyaltyAmount> createState() => _RedeemLoyaltyAmountState();
}

class _RedeemLoyaltyAmountState extends State<RedeemLoyaltyAmount> {
  // firebase uid
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  String qrReadText = '';
  String firstPart = ''; //type
  String secondPart = ''; //id
  double availLoyalty = 0.0;
  bool checkQRPoint = false;

  //controllers
  final loyaltyController = TextEditingController();

  void separateData(String qrText) {
    List<String> parts = qrText.split('/');
    if (parts.length == 2) {
      setState(() {
        firstPart = parts[0];
        secondPart = parts[1];
        checkQRPoint = true;
        checkRightPlace(true, firstPart);
      });
    } else {
      showErrorMsg('Error', 'Invalid QR code. Please scan again to continue');
      print('Invalid input format');
    }
  }

  void checkRightPlace(bool val, String fPart) {
    if (fPart == 'loyaltyRedeem') {}
  }

  Future redeemAlgo() async {
    double finalLoyaltyAmount = 0.0;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((querySnapshot) {
      availLoyalty = querySnapshot.get('loyalty_points').toDouble();
      double? parsedValue = double.tryParse(loyaltyController.text.trim());
      if (parsedValue != null) {
        // Conversion was successful, parsedValue contains the double value
        if (isSubtractionSafe(availLoyalty, parsedValue)) {
          finalLoyaltyAmount = availLoyalty - parsedValue;
          redeemLoyalty(finalLoyaltyAmount,parsedValue);
        } else {
          errorOther('Error', 'Please enter redeemable amount');
        }
      } else {
        // Conversion failed, handle the error
        errorOther('Error', 'Please enter value in numbers');
      }
    });
  }

  Future redeemLoyalty(double finalLoyaltyAmount, double parsedValue) async {
    // change user loyalty amount
    await FirebaseFirestore.instance.collection('users').doc(uid).set(
      {
        'loyalty_points': finalLoyaltyAmount,
      },
      SetOptions(merge: true),
    );
    // add to loyalty history
    await FirebaseFirestore.instance.collection('loyalty redeem history').doc().set(
      {
        'uid': uid,
        'date': DateTime.now().toString(),
        'shopId': secondPart,
        'loyalty_points': parsedValue,
      },
      SetOptions(merge: true),
    );
    {
      Get.to(() => const LoyaltyShopRedeemThanks());
    }
  }

  bool isSubtractionSafe(double a, double b) {
    // double maxDouble = 1.7976931348623157e+308; // Maximum double value
    // double minDouble = -1.7976931348623157e+308; // Minimum double value

    // double result = a - b;

    return a > b;
  }

  Future getLoyalty() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((querySnapshot) {
      setState(() {
        availLoyalty = querySnapshot.get('loyalty_points').toDouble();
      });
    });
    // double doubleValue = firestoreIntValue.toDouble();
  }

  // error in qr code
  void showErrorMsg(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(
              // 'It looks like ${emailController.text.trim()} isn\'t found in our database. Make sure correct E-mail has been entered'
              message),
          actions: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('Try again'))
          ],
        );
      },
    );
  }

  // error in other
  void errorOther(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(
              // 'It looks like ${emailController.text.trim()} isn\'t found in our database. Make sure correct E-mail has been entered'
              message),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Try again'))
          ],
        );
      },
    );
  }

  @override
  void initState() {
    qrReadText = Get.arguments[0].toString();
    separateData(Get.arguments[0].toString());
    getLoyalty();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Redeem Loyalty points'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.deepPurple.shade300,
          elevation: 0.0,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    'Available Points',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                  Text(
                    availLoyalty.toString(),
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Text(
                  //   'Enter desired amount to continue',
                  //   style: GoogleFonts.poppins(
                  //     fontSize: 15,
                  //   ),
                  // ),
                  const SizedBox(height: 20),
                  InputTextArea1(
                      controller: loyaltyController,
                      hintText: 'Enter desired amount to continue',
                      obscureText: false),
                  const SizedBox(height: 20),
                  InputButton1(onTap: redeemAlgo, text: 'Redeem')
                ],
              ),
            ),
          ),
        ));
  }
}
