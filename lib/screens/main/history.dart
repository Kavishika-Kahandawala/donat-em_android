import 'package:flutter/material.dart';

class HistoryUI extends StatefulWidget {
  const HistoryUI({super.key});

  @override
  State<HistoryUI> createState() => _HistoryUIState();
}

class _HistoryUIState extends State<HistoryUI> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('History page')
                  //TODO: for accounts page
                  // Text('Logged in as : ' + user.email!),
                  // IconButton(onPressed: signOutUser, icon: Icon(Icons.logout)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
