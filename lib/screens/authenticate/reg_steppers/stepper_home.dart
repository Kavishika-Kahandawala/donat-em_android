import 'package:donatem/screens/authenticate/reg_steppers/step_location.dart';
import 'package:donatem/screens/authenticate/reg_steppers/step_mobile_number.dart';
import 'package:donatem/screens/authenticate/reg_steppers/step_name.dart';
import 'package:donatem/screens/authenticate/reg_steppers/step_dob.dart';
import 'package:donatem/screens/authenticate/reg_steppers/step_photo_notice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:progress_bar_steppers/steppers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'stepper_reg_auth.dart';

class StepperHome extends StatefulWidget {
  const StepperHome({super.key});

  @override
  State<StepperHome> createState() => _StepperHomeState();
}

class _StepperHomeState extends State<StepperHome> {
  //progress bar stuff
  int currentStep = 0;
  int maxSteps = 5;
  // var totalSteps = 0;

  String uid = FirebaseAuth.instance.currentUser!.uid.toString();
  //Firebase get data
  Future getDocId() async {
    await FirebaseFirestore.instance.collection('users').doc(uid).get().then(
        (querySnapshot) {
      setState(() {
        currentStep = querySnapshot.get('reg_step') + 1;
        if (currentStep == 5) {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const RegStepLocation();
            },
          ));
        }
        if (currentStep == 6) {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const StepRegAuth();
            },
          ));
        }
      });
    }, onError: (e) {
      // debugPrint(e);
    });
  }

  final stepsData = [
    StepperData(
      label: 'Step 1',
    ),
    StepperData(
      label: 'Step 2',
    ),
    StepperData(
      label: 'Step 3',
    ),
    StepperData(
      label: 'Step 4',
    ),
    StepperData(
      label: 'Step 5',
    ),
  ];

  @override
  void initState() {
    getDocId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LinearProgressBar(
                maxSteps: maxSteps,
                progressType: LinearProgressBar.progressTypeLinear,
                currentStep: currentStep,
                progressColor: Colors.deepPurple,
                backgroundColor: Colors.white,
                valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.deepPurple.shade400),
                semanticsLabel: "Label",
                semanticsValue: "Value",
                // minHeight: 10,
              ),
              const SizedBox(
                height: 20,
              ),
              Steppers(
                direction: StepperDirection.horizontal,
                labels: stepsData,
                currentStep: currentStep,
                stepBarStyle: StepperStyle(
                  activeColor: Colors.deepPurple.shade400,
                  maxLineLabel: 2,
                  inactiveColor: Colors.deepPurple.shade100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                    if (currentStep == 1) ...[
                      const RegStepName(),
                    ] else if (currentStep == 2)
                      ...[
                        const RegStepPhotoNotice(),
                      ]
                    else if (currentStep == 3) ...[
                      const RegStepDob(),
                    ] else if (currentStep == 4) ...[
                      const RegStepMobile(),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
