// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:donatem/screens/samples/step_1.dart';
// import 'package:donatem/screens/authenticate/reg_steppers/step_1.dart';
// import 'package:donatem/screens/main/loyalty.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class RegStepAuth extends StatelessWidget {
//   RegStepAuth({super.key});

//   // Get current logged user id
//   final String uid = FirebaseAuth.instance.currentUser!.uid.toString();

//   //Firebase get data
//   Future <int> getRegStep() async {
//     int currentStep = 1;
//     await FirebaseFirestore.instance.collection('users').doc(uid).get().then(
//       (querySnapshot) {
//         currentStep = querySnapshot.get('reg_step') + 1;
//       },
//       onError: (e) {
//         currentStep = 1;
//       },
//     );
//     return currentStep;
//   }

//   @override
//   Widget build(BuildContext context) {

    
//     if (getRegStep == 1) {
//       return const Step1();
//     }else if(getRegStep == 2){
//       return const Step1();
//     } else if (getRegStep == 3) {
//       return const Step1();
//     } else if (getRegStep == 4) {
//       return const Step1();
//     } else  {
//       return const TestStep();
//     }
//   }
// }
