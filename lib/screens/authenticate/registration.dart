import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:donatem/shared/inputTextArea_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/auth.dart';

class RegisterUI extends StatefulWidget {
  final Function()? onTap;
  const RegisterUI({super.key, required this.onTap});

  @override
  State<RegisterUI> createState() => _RegisterUIState();
}

class _RegisterUIState extends State<RegisterUI> {
  // text Controllers
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  //User sign up
  void signUserUp() async {
    // show loading icon
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    //try user create on fb auth
    try {
      //create suer on auth
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passController.text.trim());

      String id = FirebaseAuth.instance.currentUser!.uid.toString();

      addUserDetails(id, 'fname', 'lname', emailController.text.trim(), '25');

      //pop loading circle
      Navigator.pop(context);

      {
       await Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const AuthService();
          },
        ));
      }
    } on FirebaseAuthException catch (e) {
      //pop loading circle
      Navigator.pop(context);
      //Wrong Email
      if (e.code == 'invalid-email') {
        //show error
        showErrorMsg('Error',
            'The E-mail you provided not looks like an E-mail. Please make sure you entered a correct E-mail');
      }

      //Wrong Password
      else if (e.code == 'weak-password') {
        //show error
        showErrorMsg('Error',
            'The password you entered is weak. Please enter a password with at at least 6 characters .');
      }
      //Bad Format
      else {
        //show error
        showErrorMsg('Error', e.message.toString());
      }
    }
  }

  //wrong email popup
  void showErrorMsg(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(
              // 'It looks like ${emailController.text.trim()} isn\'t found in our database. Make sure correct E-mail has been entered'
              message),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Try again'))
          ],
        );
      },
    );
  }

  Future addUserDetails(
      String uid, String fname, String lname, String email, String age) async {
    await FirebaseFirestore.instance.collection('users').add({
      'uid': uid,
      'firstname': fname,
      'lastname': lname,
      'email': email,
      'age': age
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                //logo image

                const SizedBox(height: 10),

                // Main Text (Hello Again)
                Text(
                  'Hello User',
                  style: GoogleFonts.poppins(
                    // fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
                const SizedBox(height: 10),

                Text(
                  'Let\'s create an account. It\'s free',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontSize: 20),
                ),

                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  child: Column(children: [
                    // E-mail field
                    InputTextArea1(
                      controller: emailController,
                      hintText: 'E-mail',
                      obscureText: false,
                    ),
                    const SizedBox(height: 10),

                    // Password Field
                    InputTextArea1(
                      controller: passController,
                      hintText: 'Password',
                      obscureText: true,
                    ),

                    const SizedBox(height: 10),

                    // Sign in  button
                    InputButton1(
                      onTap: signUserUp,
                      text: 'Sign Up',
                    ),

                    const SizedBox(height: 25),
                    //Not a member? Register
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: Text(
                            ' Sign in now',
                            style: GoogleFonts.poppins(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    )
                  ]),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
