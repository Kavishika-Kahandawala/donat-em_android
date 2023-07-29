import 'package:flutter/material.dart';

class OrgMainUI extends StatefulWidget {
  const OrgMainUI({super.key});

  @override
  State<OrgMainUI> createState() => _OrgMainUIState();
}

class _OrgMainUIState extends State<OrgMainUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
