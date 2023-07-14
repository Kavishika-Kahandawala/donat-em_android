import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../shared/inputButton_1.dart';
import '../../shared/inputTextArea_1.dart';
import '../../shared/inputTextArea_2.dart';


class StepSample extends StatefulWidget {
  const StepSample({super.key});

  @override
  State<StepSample> createState() => _StepSampleState();
}

class _StepSampleState extends State<StepSample> {
  // text Controllers
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();

  // Get current logged user id
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  int currentStep = 0;

  //Firebase get data
  Future getRegStep() async {
    await FirebaseFirestore.instance.collection('users').doc(uid).get().then(
        (querySnapshot) {
      setState(() {
        currentStep = querySnapshot.get('reg_step') + 1;
      });
    }, onError: (e) {
      showErrorMsg('Error', e.message.toString());
    });
  }

  // Push fname,lname to firestore
  Future addUserRegData() async {
    await getRegStep();
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'first_name': fnameController.text.trim(),
      'last_name': lnameController.text.trim(),
      'reg_step': currentStep,
    });
  }

  //error msg popup
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
                child: const Text('Try again'))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        InputTextArea1(
          controller: fnameController,
          hintText: 'First Name',
          obscureText: false,
        ),

        const SizedBox(height: 10),

        InputTextArea2(
          controller: fnameController,
          hintText: 'Last Name',
          obscureText: false,
        ),
        
        const SizedBox(height: 10),
        InputButton1(
          onTap: addUserRegData,
          text: 'Sign Up',
        ),
      ],
    );
  }
}
