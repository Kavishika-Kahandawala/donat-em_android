import 'package:donatem/screens/main/history.dart';
import 'package:donatem/screens/main/loyalty.dart';
import 'package:donatem/screens/main/main_page.dart';
import 'package:donatem/screens/main/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({super.key});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  int _selectedIndex = 0;
  final user = FirebaseAuth.instance.currentUser!;
  //
  //sign User Out
  void signOutUser() {
    FirebaseAuth.instance.signOut();
  }

  static const List<Widget> _widgetOptions = <Widget>[
    MainPageUI(),
    LoyaltyUI(),
    HistoryUI(),
    UserProfileUI()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          color: Colors.deepPurple.shade400,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
            child: GNav(
                backgroundColor: Colors.deepPurple.shade400,
                color: Colors.white,
                activeColor: Colors.white,
                tabBackgroundColor: Colors.deepPurple.shade200,
                gap: 8,
                padding: const EdgeInsets.all(16),
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.loyalty,
                    text: 'Loyalty Points',
                  ),
                  GButton(
                    icon: Icons.history,
                    text: 'History',
                  ),
                  GButton(
                    icon: Icons.account_circle,
                    text: 'Account',
                  ),
                ],
                selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
                ),
          ),
        ));
  }
}
