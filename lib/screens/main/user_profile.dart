import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfileUI extends StatefulWidget {
  const UserProfileUI({super.key});

  @override
  State<UserProfileUI> createState() => _UserProfileUIState();
}

class _UserProfileUIState extends State<UserProfileUI> {
  final user = FirebaseAuth.instance.currentUser!;
  //
  //sign User Out
  void signOutUser() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('User account page'),
                //TODO: for accounts page
                Text('Logged in as : ${user.uid}'),
                IconButton(onPressed: signOutUser, icon: const Icon(Icons.logout)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
