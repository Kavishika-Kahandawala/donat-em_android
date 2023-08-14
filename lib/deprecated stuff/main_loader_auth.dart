// deprecated
import 'package:donatem/screens/main/navigation_bar.dart';
import 'package:donatem/services/reg_or_log.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeUI();
          }else{
            return const RegisterOrLogin();
          }
        },
      ),
    );
  }
}

//not