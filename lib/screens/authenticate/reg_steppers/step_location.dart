import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/authenticate/reg_steppers/stepper_home.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:donatem/shared/inputTextArea_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegStepLocation extends StatefulWidget {
  const RegStepLocation({super.key});

  @override
  State<RegStepLocation> createState() => _RegStepLocationState();
}

class _RegStepLocationState extends State<RegStepLocation> {
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
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'first_name': fnameController.text.trim(),
      'last_name': lnameController.text.trim(),
      'reg_step': 4,
    },SetOptions(merge: true),);
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
            hintText: 'First Name',
            obscureText: false),
        const SizedBox(height: 15),
        InputTextArea1(
            controller: lnameController,
            hintText: 'Last Name',
            obscureText: false),
        const SizedBox(height: 30),
        InputButton1(onTap: addUserRegData, text: 'Submit')
      ],
    );
  }
}
