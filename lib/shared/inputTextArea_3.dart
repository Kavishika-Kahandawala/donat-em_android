import 'package:flutter/material.dart';

class InputTextArea3 extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final Function(String text)? onTap;

  const InputTextArea3({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText, 
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      onChanged: (text){
        onTap!(text);
      },
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple),
        ),
        fillColor: Colors.grey.shade200,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[500]),
      ),
    );
  }
}
