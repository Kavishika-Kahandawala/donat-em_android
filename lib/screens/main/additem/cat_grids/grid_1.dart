// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/main/additem/item_thanks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/circle_avatar_1.dart';
import '../item_photo_verify_notice.dart';
import '../item_tags.dart';

class CatGrid1 extends StatefulWidget {
  // Item Id
  final String itemDocId;
  const CatGrid1({super.key, required this.itemDocId});

  @override
  State<CatGrid1> createState() => _CatGrid1State();
}

class _CatGrid1State extends State<CatGrid1> {
  //init category
  Future initCat(String categoryName) async {
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
        'image_count':0,
      },
      SetOptions(merge: true),
    );
    //pop loading circle
    Navigator.pop(context);
    {
      // await Navigator.push(context, MaterialPageRoute(
      //   builder: (context) {
      //     return const ItemThanks();
      //   },
      // ));
      print("tem doc id grid 1 >>>>>>>>>>>>>>>>>"+widget.itemDocId);
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
                    onTap: () => initCat("Shirts"),
                      heading: 'Shirts',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("T-Shirts"),
                      heading: 'T-Shirts',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Shirts"),
                      heading: 'Sample heading ',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Shirts"),
                      heading: 'Sample heading ',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Shirts"),
                      heading: 'Sample heading ',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg')
                ],
              );
  }
}
