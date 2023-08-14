//deprecated
import 'package:donatem/deprecated%20stuff/authentication.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    //return either Home or Authentication widget
    return const Authentication();
  }
}

