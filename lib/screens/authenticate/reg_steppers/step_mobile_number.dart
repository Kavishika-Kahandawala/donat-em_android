import 'package:donatem/screens/authenticate/reg_steppers/otp_phone.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class RegStepMobile extends StatefulWidget {
  const RegStepMobile({super.key});

  @override
  State<RegStepMobile> createState() => _RegStepMobileState();
}

class _RegStepMobileState extends State<RegStepMobile> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //controllers
  final phoneNumController = TextEditingController();
  dynamic phoneNumberString;

  // Get current logged user id
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  Future verifyNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumberString.toString(),
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          showErrorMsg('Error', 'The provided phone number is not valid.');
        } else {
          showErrorMsg('Error', e.message.toString());
        }
      },
      codeSent: (verificationId, resendToken) {
        Get.to(() => const OTPPhone(),arguments: [phoneNumberString.toString(),verificationId]);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
      },
    );
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
    phoneNumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        Form(
          key: formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  phoneNumberString=number.phoneNumber;
                  print(number.phoneNumber);
                },
                onInputValidated: (bool value) {
                  print(value);
                },
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                ),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                selectorTextStyle: const TextStyle(color: Colors.black),
                inputDecoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                ),
                initialValue: PhoneNumber(isoCode: 'LK'),
                textFieldController: phoneNumController,
                formatInput: false,
                keyboardType: const TextInputType.numberWithOptions(signed: true),
                inputBorder: const OutlineInputBorder(),
                onSaved: (PhoneNumber number) {
                  print('On Saved: $number');
                },
              ),
            ),
          ),
        ),
        // InputTextArea1(
        //     controller: fnameController,
        //     hintText: 'Phone Number',
        //     obscureText: false),
        const SizedBox(height: 80),
        InputButton1(onTap: verifyNumber, text: 'Submit'),
      ],
    );
  }
}
