import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/main/additem/item_tags.dart';
import 'package:donatem/shared/app_colors.dart';
import 'package:donatem/shared/card_1.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/inputButton_1.dart';

class ItemCategory extends StatefulWidget {
  // Item Id
  final String itemDocId;

  const ItemCategory({super.key, required this.itemDocId});

  @override
  State<ItemCategory> createState() => _ItemCategoryState();
}

class _ItemCategoryState extends State<ItemCategory> {
  // start : Side menu
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  @override
  void initState() {
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }

  // end : Side menu

  // Color _colorContainer = Colors.blue;
  // Input controllers
  final itemNameController = TextEditingController();
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
    await FirebaseFirestore.instance
        .collection('donation items')
        .doc(widget.itemDocId)
        .set(
      {
        'item_category': categoryName,
      },
      SetOptions(merge: true),
    );
    //pop loading circle
    Navigator.pop(context);
    {
      await Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return ItemTags(itemDocId: widget.itemDocId);
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SideMenu(
                controller: sideMenu,
                items: [
                  SideMenuItem(
                    priority: 0,
                    title: '1st menu',
                    onTap: (index, _) {
                      sideMenu.changePage(index);
                    },
                  )
                ],
              )

              // const SizedBox(height: 20),
              // Text(
              //   'Pick category',
              //   style: GoogleFonts.poppins(
              //     fontWeight: FontWeight.bold,
              //     fontSize: 32,
              //   ),
              // ),
              // const SizedBox(height: 20),
              // Container(child: Text('sdsdsd'),)
              // Expanded(
              //   flex: 2, // 20%
              //   child: Column(
              //     children: [
              //       GestureDetector(
              //         child: Container(
              //           color: _colorContainer,
              //           child: Text('sdsdds'),
              //         ),
              //         onTap: () {
              //           setState(() {
              //             _colorContainer = _colorContainer == Colors.red
              //                 ? Colors.blue
              //                 : Colors.red;
              //           });
              //         },
              //       ),
              //       Text('sdsdsd'),
              //       Text('dsf4gfg')
              //     ],
              //   ),
              // ),
              // Expanded(
              //   flex: 6, // 60%
              //   child: Container(
              //     child: Text('datsdsda'),
              //   ),
              // ),
              // Expanded(
              //   flex: 2, // 20%
              //   child: Container(
              //     child: Text('datsdsda'),
              //   ),
              // )

              //A category Card
              // GestureDetector(
              //   onTap: () => nextStep('educational'),
              //   child: const Card1(
              //       backgroundColor: AppColors.deepPurple,
              //       heading: 'Educational',
              //       subHeading: '',
              //       iconName: 'book'),
              // ),
              // const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
