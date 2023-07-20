import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/authenticate/reg_steppers/stepper_home.dart';
import 'package:donatem/screens/main/navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StepRegAuth extends StatelessWidget {
  StepRegAuth({super.key});

  final String uid = FirebaseAuth.instance.currentUser!.uid.toString();
  //Firebase get data
  Future getDocId() async {
    // status 1 == go to reg steppers
    int status = 0;
    await FirebaseFirestore.instance.collection('users').doc(uid).get().then(
      (querySnapshot) {
        if (querySnapshot.get('reg_step') < 4) {
          status = 1;
        }
      },
      onError: (e) {
        // Dialog to show error TODO:
      },
    );
    return status;
  }

  @override
  Widget build(BuildContext context) {
    if (getDocId() == 1) {
      return const StepperHome();
    } else {
      return const HomeUI();
    }
  }
}
