import 'package:flutter/material.dart';

// Get Name
class Step1 extends StatefulWidget {
  const Step1({super.key});

  @override
  State<Step1> createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text("steps to write",textAlign: TextAlign.left,)
        ],
      ),
    );
  }
}
