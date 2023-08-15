// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/circle_avatar_1.dart';
import '../item_photo_verify_notice.dart';

class ToysAndGames extends StatefulWidget {
  // Item Id
  final String itemDocId;
  const ToysAndGames({super.key, required this.itemDocId});

  @override
  State<ToysAndGames> createState() => _ToysAndGamesState();
}

class _ToysAndGamesState extends State<ToysAndGames> {
  String categoryName = "Electronics and Appliances";
  //init category
  Future initCat(String subCategoryName) async {
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
        'item_sub_category': subCategoryName,
        'image_count':0,
      },
      SetOptions(merge: true),
    );
    //pop loading circle
    Navigator.pop(context);
    {
      Get.to(()=> const ItemPhotoVerifyNotice(), arguments: [Get.arguments[0].toString()]);
    }

  }

  

  @override
  Widget build(BuildContext context) {
    return GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                // primary: false,
                children:  [
                  CircleAvatar1(
                    onTap: () => initCat("Lego"),
                      heading: 'Lego',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Board Games"),
                      heading: 'Board Games',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Puzzles"),
                      heading: 'Puzzles',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Figures"),
                      heading: 'Figures',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Puppets"),
                      heading: 'Puppets',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Balls"),
                      heading: 'Balls',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Stuffed Toys"),
                      heading: 'Stuffed Toys',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Musical"),
                      heading: 'Musical',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Cars"),
                      heading: 'Cars',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Drones"),
                      heading: 'Drones',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Pretend Play"),
                      heading: 'Pretend Play',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Other"),
                      heading: 'Other',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                ],
              );
  }
}
