// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/circle_avatar_1.dart';
import '../item_photo_verify_notice.dart';

class ClothingAndAccessories extends StatefulWidget {
  // Item Id
  final String itemDocId;
  const ClothingAndAccessories({super.key, required this.itemDocId});

  @override
  State<ClothingAndAccessories> createState() => _ClothingAndAccessoriesState();
}

class _ClothingAndAccessoriesState extends State<ClothingAndAccessories> {

  String categoryName = "Clothing and Accessories";
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
                    onTap: () => initCat("Shirts"),
                      heading: 'Shirts',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fclothing%2Fshirts.jpg?alt=media&token=f87334c2-8a1d-4eef-8eaa-140874cea550'),
                  CircleAvatar1(
                    onTap: () => initCat("T-Shirts"),
                      heading: 'T-Shirts',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fclothing%2Ft%20shirts.jpg?alt=media&token=639932d1-f8b9-4c81-b078-90e5556d3615'),
                  CircleAvatar1(
                    onTap: () => initCat("Blouses"),
                      heading: 'Blouses',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fclothing%2Fblouses.jpg?alt=media&token=72e7f82f-6db1-4fb0-90c5-39f429e9022d'),
                  CircleAvatar1(
                    onTap: () => initCat("Skirts"),
                      heading: 'Skirts',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fclothing%2Fskirts.jpg?alt=media&token=4e468683-cc32-4d79-aac6-9203c2b2a5eb'),
                  CircleAvatar1(
                    onTap: () => initCat("Shorts"),
                      heading: 'Shorts',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fclothing%2Fshorts.webp?alt=media&token=81ea85a3-fc0c-4454-8e12-e382d9dfab2c'),
                  CircleAvatar1(
                    onTap: () => initCat("Jackets"),
                      heading: 'Jackets ',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fclothing%2Fjackets.jpg?alt=media&token=ce49aa72-f984-40db-88d6-4aa3cac9d461'),
                  CircleAvatar1(
                    onTap: () => initCat("Sweaters"),
                      heading: 'Sweaters ',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fclothing%2Fsweaters.jpg?alt=media&token=8cf4583a-3a1a-40bc-a55c-f918870dd81b'),
                  CircleAvatar1(
                    onTap: () => initCat("Footwear"),
                      heading: 'Footwear',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fclothing%2Ffootwear.jpg?alt=media&token=949d087d-aec0-46af-8098-6f06f1dea2c3'),
                  CircleAvatar1(
                    onTap: () => initCat("Hats"),
                      heading: 'Hats',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fclothing%2Fhats.jpg?alt=media&token=bbcf1985-fe24-47f3-b1ce-fbb18af4fa32'),
                  CircleAvatar1(
                    onTap: () => initCat("Sunglass"),
                      heading: 'Sunglass',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fclothing%2Fsunglasses.jpg?alt=media&token=b39db424-790f-43e9-9c72-544ecf8a1e6e'),
                  CircleAvatar1(
                    onTap: () => initCat("Watches"),
                      heading: 'Watches',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fclothing%2Fwatches.jpg?alt=media&token=afb425b6-17cf-49f6-8ffd-94fd63044f15'),
                  CircleAvatar1(
                    onTap: () => initCat("Necklaces"),
                      heading: 'Necklaces',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fclothing%2Fnecklace.jpg?alt=media&token=9c587675-6ded-4d50-ab5e-38cc4e3e68e9'),
                  CircleAvatar1(
                    onTap: () => initCat("Bags"),
                      heading: 'Bags',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fclothing%2Fbags.jpg?alt=media&token=0d442d41-f1ed-4a87-ac3e-365921e4185a'),
                  CircleAvatar1(
                    onTap: () => initCat("Other"),
                      heading: 'Other',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fother%2Fother.jpg?alt=media&token=1c121e8b-98dc-465b-8cd7-5a7f7cd1941b'),
                ],
              );
  }
}
