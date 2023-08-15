import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/authenticate/reg_steppers/stepper_home.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class OTPPhone extends StatefulWidget {
  const OTPPhone({super.key});

  @override
  State<OTPPhone> createState() => _OTPPhoneState();
}

class _OTPPhoneState extends State<OTPPhone> {
  //controllers
  final pinController = TextEditingController();
  String validateBit = '1';
  String errorText = '';

  // Get current logged user id
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  final formKey = GlobalKey<FormState>();
  final focusNode = FocusNode();

  final focusedBorderColor = Colors.deepPurple;
  final fillColor = Colors.deepPurple.withOpacity(0.1);
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 22,
      color: Color.fromRGBO(30, 60, 87, 1),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(19),
      border: Border.all(color: Colors.deepPurple),
    ),
  );

  Future verifyOTP(String otpSmsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: Get.arguments[1].toString(), smsCode: otpSmsCode);
      FirebaseAuth.instance.currentUser?.updatePhoneNumber(credential);
    } catch (e) {
      // print('Error in verify otp');
      showErrorMsg('Error', 'Something went wrong');
    }
  }

  Future checkPhoneLinked() async {
    try {
      if (FirebaseAuth.instance.currentUser!.phoneNumber != null) {
        // phone number is linked
        setState(() {
          errorText = '';
        });
        addUserRegData();
      } else {
        // phone number is not linked
        setState(() {
          errorText = 'OTP Code is incorrect';
        });
      }
    } catch (e) {
      showErrorMsg('Error', 'Something went wrong');
    }
  }

  Future addUserRegData() async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set(
      {
        'mobile_number': Get.arguments[0].toString(),
        'reg_step': 4,
      },
      SetOptions(merge: true),
    );
    {
      Get.to(() => const StepperHome());
    }
  }

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
                  Navigator.pop(context);
                },
                child: const Text('Close'))
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Verification',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Enter the code sent to',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    formatNumberSync(Get.arguments[0].toString()),
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 80),
                  Form(
                    key: formKey,
                    child: Pinput(
                      length: 6,
                      controller: pinController,
                      focusNode: focusNode,
                      androidSmsAutofillMethod:
                          AndroidSmsAutofillMethod.smsUserConsentApi,
                      listenForMultipleSmsOnAndroid: true,
                      defaultPinTheme: defaultPinTheme,
                      separatorBuilder: (index) => const SizedBox(width: 8),
                      validator: (value) {
                        return validateBit == '1' ? null : 'Pin is incorrect';
                      },
                      onClipboardFound: (value) {
                        debugPrint('onClipboardFound: $value');
                        pinController.setText(value);
                      },
                      hapticFeedbackType: HapticFeedbackType.lightImpact,
                      onCompleted: (pin) {
                        verifyOTP(pin.toString());
                        debugPrint('onCompleted: $pin');
                      },
                      onSubmitted: (value) {
                        debugPrint('onSubmitted: $value');
                      },
                      onChanged: (value) {
                        debugPrint('onChanged: $value');
                      },
                      cursor: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 9),
                            width: 22,
                            height: 1,
                            color: focusedBorderColor,
                          ),
                        ],
                      ),
                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: focusedBorderColor),
                        ),
                      ),
                      submittedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          color: fillColor,
                          borderRadius: BorderRadius.circular(19),
                          border: Border.all(color: focusedBorderColor),
                        ),
                      ),
                      errorPinTheme: defaultPinTheme.copyBorderWith(
                        border: Border.all(color: Colors.redAccent),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        errorText,
                        style: TextStyle(color: Colors.redAccent),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  InputButton1(onTap: checkPhoneLinked, text: 'Enter')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
