import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/authenticate/reg_steppers/stepper_home.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class RegStepDob extends StatefulWidget {
  const RegStepDob({super.key});

  @override
  State<RegStepDob> createState() => _RegStepDobState();
}

class _RegStepDobState extends State<RegStepDob> {
  // dob stuff
  //date time variable

  DateTime _dateTime = DateTime.now();

  String dobError = '';

  // date time picker
  void _popDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then(
      (value) {
        setState(() {
          _dateTime = value!;
          checkDob();
        });
      },
    );
  }

  bool verifyUserInput() {
    checkDob();
    Duration diff = DateTime.now().difference(_dateTime);
    int diffYears = (diff.inDays ~/ 365).toInt();
    if (diffYears < 18) {
      return false;
    } else {
      return true;
    }
  }

  void checkDob() {
    setState(() {
      Duration diff = DateTime.now().difference(_dateTime);
      int diffYears = (diff.inDays ~/ 365).toInt();
      if (diffYears < 18) {
        dobError = 'You should be older than 18 to use this platform';
      } else {
        dobError = '';
      }
    });
  }

  // Get current logged user id
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();
  // Push fname,lname to firestore
  Future addUserRegData() async {
    if (verifyUserInput()) {
      await FirebaseFirestore.instance.collection('users').doc(uid).set(
        {
          'dob': DateFormat.yMMMEd().format(_dateTime),
          'reg_step': 2,
        },
        SetOptions(merge: true),
      );
      {
        await Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const StepperHome();
          },
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        Row(
          children: [
            Text(
              'Pick  Your  Birthday',
              style: GoogleFonts.poppins(
                // fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        GestureDetector(
          onTap: _popDatePicker,
          child: Container(
              // margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(3.5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepPurple.shade300)),
              child: Icon(
                Icons.date_range,
                color: Colors.deepPurple.shade300,
              )),
        ),
        const SizedBox(height: 10),
        Text(DateFormat.yMEd().format(_dateTime)),
        const SizedBox(height: 50),
        InputButton1(onTap: addUserRegData, text: 'Submit'),
        const SizedBox(height: 10),
        Text(dobError, style: const TextStyle(color: Colors.red)),
      ],
    );
  }
}
