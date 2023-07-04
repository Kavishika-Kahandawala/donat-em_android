import 'package:donatem/shared/inputButton_1.dart';
import 'package:donatem/shared/inputTextArea_1.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginUI extends StatelessWidget {
  LoginUI({super.key});

  // text Controllers
  final emailController = TextEditingController();
  final passController = TextEditingController();

  //sign in user
  void signUser() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                      Text(
                        'forgot password ?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
        
                  // Sign in  button
                  InputButton1(onTap: signUser),
        
                  const SizedBox(height: 25),
                  //Not a member? Register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        ' Sign Up now',
                        style: GoogleFonts.poppins(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
                ]),
              )
            ],
          ),
        ),
      )),
    );
  }
}
