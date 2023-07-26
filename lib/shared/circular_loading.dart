import 'package:flutter/material.dart';

class CircularLoadingUI extends StatelessWidget {
  const CircularLoadingUI({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(
            child: Center(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircularProgressIndicator(),
          ],
        ),
      ),
    )));
  }
}
