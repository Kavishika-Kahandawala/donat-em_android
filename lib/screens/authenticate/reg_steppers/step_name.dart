import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/authenticate/reg_steppers/stepper_home.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:donatem/shared/inputTextArea_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegStepName extends StatefulWidget {
  const RegStepName({super.key});

  @override
  State<RegStepName> createState() => _RegStepNameState();
}

class _RegStepNameState extends State<RegStepName> {
  //controllers
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();

  String fnameError = '';
  String lnameError = '';

  // Get current logged user id
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  // Push fname,lname to firestore
  Future addUserRegData() async {
    // Check user has entered fname and lname
    if (verifyUserInput()) {
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
          'first_name': fnameController.text.trim(),
          'last_name': lnameController.text.trim(),
          'reg_step': 1,
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
  }

  bool verifyUserInput() {
    checkFname();
    checkLname();
    return fnameController.text.trim().isNotEmpty &&
        lnameController.text.trim().isNotEmpty;
  }

  void checkFname() {
    setState(() {
      if (fnameController.text.trim().isEmpty) {
        fnameError = 'Please enter your first name';
      } else {
        fnameError = '';
      }
    });
  }

  void checkLname() {
    setState(() {
      if (lnameController.text.trim().isEmpty) {
        lnameError = 'Please enter your last name';
      } else {
        lnameError = '';
      }
    });
  }

  @override
  void dispose() {
    fnameController.dispose();
    lnameController.dispose();
    super.dispose();
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
        const SizedBox(height: 5),
        Row(
          children: [
            Text(fnameError, style: const TextStyle(color: Colors.red)),
          ],
        ),
        const SizedBox(height: 5),
        InputTextArea1(
            controller: lnameController,
            hintText: 'Last Name',
            obscureText: false),
            const SizedBox(height: 5),
        Row(
          children: [
            Text(lnameError, style: const TextStyle(color: Colors.red)),
          ],
        ),
        const SizedBox(height: 30),
        InputButton1(onTap: addUserRegData, text: 'Submit')
      ],
    );
  }
}
