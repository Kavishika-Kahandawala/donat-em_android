// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/circle_avatar_1.dart';
import '../item_photo_verify_notice.dart';

class Other extends StatefulWidget {
  // Item Id
  final String itemDocId;
  const Other({super.key, required this.itemDocId});

  @override
  State<Other> createState() => _OtherState();
}

class _OtherState extends State<Other> {

  String categoryName = "Other";
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
                    onTap: () => initCat("Other"),
                      heading: 'Other',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fother%2Fother.jpg?alt=media&token=1c121e8b-98dc-465b-8cd7-5a7f7cd1941b'),
                ],
              );
  }
}
