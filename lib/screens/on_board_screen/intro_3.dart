import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Intro3 extends StatelessWidget {
  const Intro3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      body: Center(
        // child: Lottie.asset('llib/images/lottie/price_tag.json'),
        child: Image.asset('lib/images/lottie/123.jpg'),
      ),
    );
  }
}
