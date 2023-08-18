import 'package:donatem/shared/inputButton_1.dart';
import 'package:donatem/shared/inputTextArea_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/auth.dart';
import 'forgotpass.dart';

class LoginUI extends StatefulWidget {
  final Function ()? onTap;
  const LoginUI({super.key, required this.onTap});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
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

  //User sign in
  void signUser() async {
    // show loading icon
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.deepPurple,),
          );
        });

    //try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passController.text.trim());

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
      if (e.code == 'user-not-found') {
        //show error
        showErrorMsg('Error','It looks like ${emailController.text.trim()} isn\'t found in our database. Make sure correct E-mail has been entered.');
      }
      //Wrong Password
      else if (e.code == 'wrong-password') {
        //show error
        showErrorMsg('Error', 'The password you entered is incorrect. Please try again.');
      }
      //Bad Format
      else if (e.code == 'invalid-email') {
        //show error
        showErrorMsg('Error', 'The E-mail you provided not looks like an E-mail. Please make sure you entered a correct E-mail');
      } else {
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
              message
              ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  'Welcome back. You\'ve been missed!',
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

                    // Forgot password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return const ForgotPassUI();
                          }));
                        },
                          child: Text(
                            'forgot password ?',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),

                    // Sign in  button
                    InputButton1(onTap: signUser, text: 'Sign in',),

                    const SizedBox(height: 25),
                    //Not a member? Register
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Not a member?',
                          style: GoogleFonts.poppins(
                            // color: Colors.white,       //TODO: clear this
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: Text(
                            ' Sign Up now',
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
