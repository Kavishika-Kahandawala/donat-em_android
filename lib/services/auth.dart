import 'package:donatem/screens/authenticate/login.dart';
import 'package:donatem/screens/main/home_ui.dart';
import 'package:donatem/services/reg_or_log.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends StatelessWidget {
  const AuthService({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          
          //user logged in
          if (snapshot.hasData){
            return const HomeUI();
          }

          //user hasn't logged in
          else{
            return const RegisterOrLogin();
          }
        },
      ),
    );
  }
}
