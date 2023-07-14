import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/authenticate/reg_steppers/stepper_home.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:donatem/shared/inputTextArea_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegStepMobile extends StatefulWidget {
  const RegStepMobile({super.key});

  @override
  State<RegStepMobile> createState() => _RegStepMobileState();
}

class _RegStepMobileState extends State<RegStepMobile> {
  //controllers
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();

  // Get current logged user id
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  // Push fname,lname to firestore
  Future addUserRegData() async {
    // show loading icon
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    await FirebaseFirestore.instance.collection('users').doc(uid).set(
      {
        'mobile_number': fnameController.text.trim(),
        'reg_step': 3,
      },
      SetOptions(merge: true),
    );
    //pop loading circle
    Navigator.pop(context);
    {
      await Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return const StepperHome();
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        InputTextArea1(
            controller: fnameController,
            hintText: 'Phone Number',
            obscureText: false),
        const SizedBox(height: 30),
        InputButton1(onTap: addUserRegData, text: 'Submit'),
      ],
    );
  }
}
