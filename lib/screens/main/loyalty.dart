import 'package:flutter/material.dart';

class LoyaltyUI extends StatefulWidget {
  const LoyaltyUI({super.key});

  @override
  State<LoyaltyUI> createState() => _LoyaltyUIState();
}

class _LoyaltyUIState extends State<LoyaltyUI> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Loaylty page')
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
