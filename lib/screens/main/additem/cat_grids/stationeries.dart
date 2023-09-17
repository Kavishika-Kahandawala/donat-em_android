// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/circle_avatar_1.dart';
import '../item_photo_verify_notice.dart';

class Stationeries extends StatefulWidget {
  // Item Id
  final String itemDocId;
  const Stationeries({super.key, required this.itemDocId});

  @override
  State<Stationeries> createState() => _StationeriesState();
}

class _StationeriesState extends State<Stationeries> {

  String categoryName = "Stationeries";
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
                    onTap: () => initCat("Notebooks"),
                      heading: 'Notebooks',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fstationaries%2Fnotebooks.jpg?alt=media&token=59f781b1-9cfb-4308-a983-1c783614715a'),
                  CircleAvatar1(
                    onTap: () => initCat("Calculators"),
                      heading: 'Calculators',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fstationaries%2Fcalculators.jpg?alt=media&token=37160e6c-d724-457f-9e0e-9977181c9b26'),
                  CircleAvatar1(
                    onTap: () => initCat("Staplers"),
                      heading: 'Staplers',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fstationaries%2Fstaplers.jpg?alt=media&token=5c0160ba-b8b5-4fdb-9f9c-1d1f16120039'),
                  CircleAvatar1(
                    onTap: () => initCat("Art Supplies"),
                      heading: 'Art Supplies',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fstationaries%2Fart%20supplies.jpg?alt=media&token=982c76cd-7627-45f9-9a58-0d9ce6e40cc8'),
                  CircleAvatar1(
                    onTap: () => initCat("Novels"),
                      heading: 'Novels',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fstationaries%2Fnovels.jpg?alt=media&token=cb371e89-5688-4bba-b941-59f973bee37c'),
                  CircleAvatar1(
                    onTap: () => initCat("Magazines"),
                      heading: 'Magazines',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fstationaries%2Fmagazines.jpg?alt=media&token=7a98c056-721f-45df-95c2-6dd2d6349f38'),
                  CircleAvatar1(
                    onTap: () => initCat("Journals"),
                      heading: 'Journals',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fstationaries%2Fjournals.png?alt=media&token=c832ef7f-6d2e-4941-ae79-ae106fcce652'),
                  CircleAvatar1(
                    onTap: () => initCat("Other"),
                      heading: 'Other',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fother%2Fother.jpg?alt=media&token=1c121e8b-98dc-465b-8cd7-5a7f7cd1941b'),
                ],
              );
  }
}
