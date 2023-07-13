import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';
import '../../shared/inputButton_1.dart';
import '../../shared/inputTextArea_1.dart';

class ForgotPassUI extends StatefulWidget {
  const ForgotPassUI({super.key});

  @override
  State<ForgotPassUI> createState() => _ForgotPassUIState();
}

class _ForgotPassUIState extends State<ForgotPassUI> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future resetPass() async {
    // show loading icon
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      //pop loading circle
      Navigator.pop(context);
      showMsg(
          'Successful',
          'A password confirmation link has been sent to the designated e-mail address. Check your e-mail for further instructions. ',
          'OK',
          1);
    } on FirebaseAuthException catch (e) {
      //pop loading circle
      Navigator.pop(context);
      showMsg('Error', e.message.toString(), 'Try Again', 0);
    }
  }

  void showMsg(String title, String message, String buttonText, int status) {
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
                  {
                    if (status == 0) {
                      Navigator.pop(context);
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const AuthService();
                      }));
                    }
                  }
                },
                child: Text(buttonText))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 139, 87, 228),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Text(
                  'Enter Your Email here. An email with a password reset link will be sent if e-mail is available on our servers.',
                  // style:
                  // GoogleFonts.poppins(
                  // fontWeight: FontWeight.bold,
                  // fontSize: 15,
                  // ),
                ),
                const SizedBox(height: 20),
                InputTextArea1(
                  controller: _emailController,
                  hintText: 'E-mail',
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                InputButton1(
                  onTap: resetPass,
                  text: 'Reset Password',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
