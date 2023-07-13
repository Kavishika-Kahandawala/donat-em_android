import 'package:donatem/screens/main/navigation_bar.dart';
import 'package:donatem/screens/on_board_screen/on_board.dart';
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
            return const OnBoardingScreen();
          }
        },
      ),
    );
  }
}
