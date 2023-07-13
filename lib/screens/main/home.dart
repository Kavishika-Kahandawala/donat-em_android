import 'package:flutter/material.dart';

class MainPageUI extends StatefulWidget {
  const MainPageUI({super.key});

  @override
  State<MainPageUI> createState() => _MainPageUIState();
}

class _MainPageUIState extends State<MainPageUI> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Main page'),
                //TODO: for accounts page
                // Text('Logged in as : ' + user.email!),
                // IconButton(onPressed: signOutUser, icon: Icon(Icons.logout)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
