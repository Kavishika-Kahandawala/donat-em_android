import 'package:donatem/screens/authenticate/login.dart';
import 'package:donatem/screens/authenticate/registration.dart';
import 'package:flutter/material.dart';

class RegisterOrLogin extends StatefulWidget {
  const RegisterOrLogin({super.key});

  @override
  State<RegisterOrLogin> createState() => _RegisterOrLoginState();
}

class _RegisterOrLoginState extends State<RegisterOrLogin> {

  // Initially show login page
  bool showLoginPage = true;

  // Toggle between login and registration
  void toggleUIs(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginUI(onTap: toggleUIs);
    }else{
      return RegisterUI(onTap: toggleUIs);
    }
  }
}