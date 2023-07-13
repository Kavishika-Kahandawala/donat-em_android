import 'package:donatem/screens/authenticate/reg_steppers/step_1.dart';
import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

class StepperHome extends StatefulWidget {
  const StepperHome({super.key});

  @override
  State<StepperHome> createState() => _StepperHomeState();
}

class _StepperHomeState extends State<StepperHome> {
  //progress bar stuff
  int currentStep = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LinearProgressBar(
                maxSteps: 6,
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Column(
                      children: [Step1(), Step1(), Step1(), Step1()],
                    ),
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
