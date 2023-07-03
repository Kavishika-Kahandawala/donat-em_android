import 'package:donatem/screens/main/home_ui.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    //return either Home or Authentication widget
    return HomeUI();
  }
}