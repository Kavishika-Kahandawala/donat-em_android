import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/main/additem/cat_grids/grid_1.dart';
import 'package:donatem/screens/main/additem/item_tags.dart';
import 'package:donatem/shared/app_colors.dart';
import 'package:donatem/shared/card_1.dart';
import 'package:donatem/shared/cat_Grid.dart';
import 'package:donatem/shared/circle_avatar_1.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/inputButton_1.dart';
import 'item_photo_verify_notice.dart';

class ItemCategory extends StatefulWidget {
  // Item Id
  // final String itemDocId;

  const ItemCategory({super.key});

  @override
  State<ItemCategory> createState() => _ItemCategoryState();
}

class _ItemCategoryState extends State<ItemCategory> {


  int _selectedIndex = 0;

  // Get current logged user id
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();
  

  // Next method
  Future nextStep(String categoryName) async {
    // show loading icon
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    // await FirebaseFirestore.instance
    //     .collection('donation items')
    //     .doc(uid)
    //     .set(
    //   {
    //     'item_category': categoryName,
    //   },
    //   SetOptions(merge: true),
    // );
    //pop loading circle
    Navigator.pop(context);
    // {
    //   // await Navigator.push(context, MaterialPageRoute(
    //   //   builder: (context) {
    //   //     return ItemTags(itemDocId: uid);
    //   //   },
    //   // ));
    //   Get.to(()=> const ItemPhotoVerifyNotice(), arguments: [Get.arguments[0].toString()]);
    // }
  }

  passDocId() {
    return (uid).toString();
  }

  // var data = Get.arguments;

  late final List<Widget> _widgetOptions = <Widget>[
    CatGrid1(itemDocId: Get.arguments[0]),
    Text(
      'Index 1: Business',
    ),
    Text(
      'Index 2: School',
    ),
    Text(
      'Index 2: School',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Drawer(
                elevation: 0,
                backgroundColor: Colors.deepPurple[100],
                child: ListTileTheme(
                  selectedColor: Colors.black,
                  selectedTileColor: Colors.white,
                  // tileColor: Colors.amber,
                  // color: Colors.deepPurple[100],
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      ListTile(
                        title: const Text('Clothes'),
                        selected: _selectedIndex == 0,
                        onTap: () {
                          _onItemTapped(0);
                        },
                      ),
                      ListTile(
                        // selectedTileColor: Colors.amber,
                        title: const Text('Stationary'),
                        selected: _selectedIndex == 1,
                        onTap: () {
                          _onItemTapped(1);
                        },
                      ),
                      ListTile(
                        // selectedTileColor: Colors.amber,
                        title: const Text('Stationary'),
                        selected: _selectedIndex == 2,
                        onTap: () {
                          _onItemTapped(2);
                        },
                      ),
                      ListTile(
                        // selectedTileColor: Colors.amber,
                        title: const Text('Stationary'),
                        selected: _selectedIndex == 3,
                        onTap: () {
                          _onItemTapped(3);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: _widgetOptions[_selectedIndex],
            ),
          ],
        ),
      ),
    );
  }
}
