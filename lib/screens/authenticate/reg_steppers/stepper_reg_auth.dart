import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/authenticate/reg_steppers/stepper_home.dart';
import 'package:donatem/screens/authenticate/verifyEmail.dart';
import 'package:donatem/shared/circular_loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StepRegAuth extends StatefulWidget {
  const StepRegAuth({super.key});

  @override
  State<StepRegAuth> createState() => _StepRegAuthState();
}

class _StepRegAuthState extends State<StepRegAuth> {
  // status 1 == go to reg steppers
  int status = 0;

  final String uid = FirebaseAuth.instance.currentUser!.uid.toString();
  

  //Firebase get data
  Future regIncomplete() async {
    await FirebaseFirestore.instance.collection('users').doc(uid).get().then(
      (querySnapshot) {
        if (querySnapshot.get('reg_step') < 5) {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const StepperHome();
            },
          ));
        } else {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const VerifyEmail();
            },
          ));
        }
      },
      onError: (e) {
        // Dialog to show error TODO:
      },
    );
    // return status;
  }

  @override
  void initState() {
    regIncomplete();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: CircularLoadingUI());
  }
}
