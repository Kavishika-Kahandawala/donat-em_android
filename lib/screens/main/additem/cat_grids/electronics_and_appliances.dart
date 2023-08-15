// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/circle_avatar_1.dart';
import '../item_photo_verify_notice.dart';

class ElectronicsAndAppliances extends StatefulWidget {
  // Item Id
  final String itemDocId;
  const ElectronicsAndAppliances({super.key, required this.itemDocId});

  @override
  State<ElectronicsAndAppliances> createState() => _ElectronicsAndAppliancesState();
}

class _ElectronicsAndAppliancesState extends State<ElectronicsAndAppliances> {
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
                    onTap: () => initCat("Laptops"),
                      heading: 'Laptops',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Desktops"),
                      heading: 'Desktops',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Tablets"),
                      heading: 'Tablets',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Smartphone"),
                      heading: 'Smartphone',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Printers"),
                      heading: 'Printers',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Speakers"),
                      heading: 'Speakers',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Headphone"),
                      heading: 'Headphone',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Cameras"),
                      heading: 'Cameras',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Consoles"),
                      heading: 'Consoles',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("DVD Players"),
                      heading: 'DVD Players',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("TV"),
                      heading: 'TV',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Heaters"),
                      heading: 'Heaters',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Radios"),
                      heading: 'Radios',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Chargers"),
                      heading: 'Chargers',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Projectors"),
                      heading: 'Projectors',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                    onTap: () => initCat("Scanners"),
                      heading: 'Scanners',
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
