// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/circle_avatar_1.dart';
import '../item_photo_verify_notice.dart';

class HouseholdItems extends StatefulWidget {
  // Item Id
  final String itemDocId;
  const HouseholdItems({super.key, required this.itemDocId});

  @override
  State<HouseholdItems> createState() => _HouseholdItemsState();
}

class _HouseholdItemsState extends State<HouseholdItems> {

  String categoryName = "Household Items";
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
                    onTap: () => initCat("Knives"),
                      heading: 'Knives',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Bowls"),
                      heading: 'Bowls',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Cups"),
                      heading: 'Cups',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Pans"),
                      heading: 'Pans',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Plates"),
                      heading: 'Plates',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Toasters"),
                      heading: 'Toasters',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Blenders"),
                      heading: 'Blenders',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Tables"),
                      heading: 'Tables',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Chairs"),
                      heading: 'Chairs',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Furniture"),
                      heading: 'Furniture',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Lamps"),
                      heading: 'Lamps',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Clocks"),
                      heading: 'Clocks',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Fans"),
                      heading: 'Fans',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Vases"),
                      heading: 'Vases',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Artwork"),
                      heading: 'Artwork',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Ornaments"),
                      heading: 'Ornaments',
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
