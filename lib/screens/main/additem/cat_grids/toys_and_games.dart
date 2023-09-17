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
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Ftoys%2Flego.jpg?alt=media&token=fe224675-4d77-483b-aab7-0d7b025e31cd'),
                  CircleAvatar1(
                    onTap: () => initCat("Board Games"),
                      heading: 'Board Games',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Ftoys%2Fboard%20games.jpg?alt=media&token=2a52b853-e441-49c5-bd6a-8672627923b5'),
                  CircleAvatar1(
                    onTap: () => initCat("Puzzles"),
                      heading: 'Puzzles',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Ftoys%2Fpuzzles.jpg?alt=media&token=d99cf44f-1346-4a33-9aec-ed4e740acfb9'),
                  CircleAvatar1(
                    onTap: () => initCat("Figures"),
                      heading: 'Figures',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Ftoys%2Ffigures.jpg?alt=media&token=a0fe6112-aca2-4618-8fcc-c983f4e27db6'),
                  CircleAvatar1(
                    onTap: () => initCat("Puppets"),
                      heading: 'Puppets',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Ftoys%2Fpuppets.jpeg?alt=media&token=f3b2c1fa-d585-472e-9e4e-25e712fa6f79'),
                  CircleAvatar1(
                    onTap: () => initCat("Balls"),
                      heading: 'Balls',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Ftoys%2Fballs.jpeg?alt=media&token=fff85ee2-f657-4fc7-83ad-55540f71d027'),
                  CircleAvatar1(
                    onTap: () => initCat("Stuffed Toys"),
                      heading: 'Stuffed Toys',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Ftoys%2Fstuffed%20toys.jpg?alt=media&token=19d6158b-af37-4c53-89ef-45ad42d0a518'),
                  CircleAvatar1(
                    onTap: () => initCat("Musical"),
                      heading: 'Musical',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Ftoys%2Fmusical.jpeg?alt=media&token=17162a40-4ff0-4cd2-9156-5a7788c6bae6'),
                  CircleAvatar1(
                    onTap: () => initCat("Cars"),
                      heading: 'Cars',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Ftoys%2Fcars.jpg?alt=media&token=423b60b6-d327-4419-b3ac-ad2bd9c4c72e'),
                  CircleAvatar1(
                    onTap: () => initCat("Drones"),
                      heading: 'Drones',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Ftoys%2Fdrones.jpg?alt=media&token=386cac03-ae31-453b-83a4-13e45e26e13f'),
                  CircleAvatar1(
                    onTap: () => initCat("Pretend Play"),
                      heading: 'Pretend Play',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Ftoys%2Fpretendplay.jpg?alt=media&token=f3bafc26-b0ab-42ce-889d-70320d24b70f'),
                  CircleAvatar1(
                    onTap: () => initCat("Other"),
                      heading: 'Other',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fother%2Fother.jpg?alt=media&token=1c121e8b-98dc-465b-8cd7-5a7f7cd1941b'),
                ],
              );
  }
}
