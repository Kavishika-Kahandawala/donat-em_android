import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:donatem/shared/inputTextArea_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EditUserDetails extends StatefulWidget {
  const EditUserDetails({super.key});

  @override
  State<EditUserDetails> createState() => _EditUserDetailsState();
}

class _EditUserDetailsState extends State<EditUserDetails> {
// Controllers
  dynamic fnameController = TextEditingController();
  dynamic lnameController = TextEditingController();

  String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  void updateUser() async {
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
      },
      SetOptions(merge: true),
    );
    //pop loading circle
    Navigator.pop(context);
    {
      Get.back();
    }
  }

  Future getDetails() async {
    await FirebaseFirestore.instance.collection('users').doc(uid).get().then(
      (querySnapshot) {
        String fname = (querySnapshot.get('first_name'));
        String lname = (querySnapshot.get('last_name'));
        setState(() {
          fnameController.text = fname;
          lnameController.text = lname;
        });
      },
      onError: (e) {
        // Dialog to show error TODO:
      },
    );
  }

 @override
  void initState() {
    getDetails();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Edit user details',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'First Name',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 10),
                InputTextArea1(
                    controller: fnameController,
                    hintText: 'First Name',
                    obscureText: false),
                const SizedBox(height: 20),
                Text(
                  'Last Name',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 10),
                InputTextArea1(
                    controller: lnameController,
                    hintText: 'Last Name',
                    obscureText: false),
                const SizedBox(height: 100),
                InputButton1(onTap: updateUser, text: 'Update')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
