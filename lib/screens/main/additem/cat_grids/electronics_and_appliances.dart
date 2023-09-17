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
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Felectronics%2Flaptops.jpg?alt=media&token=56193e89-2c24-4763-b7a7-6d1ffb17306c'),
                  CircleAvatar1(
                    onTap: () => initCat("Desktops"),
                      heading: 'Desktops',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Felectronics%2Fdesktops.jpg?alt=media&token=dc12476d-433b-49e7-837d-3eeb313cf68e'),
                  CircleAvatar1(
                    onTap: () => initCat("Tablets"),
                      heading: 'Tablets',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Felectronics%2Ftablets.jpg?alt=media&token=fb348a4b-5e18-47df-9e37-ccaf9fbf5466'),
                  CircleAvatar1(
                    onTap: () => initCat("Smartphone"),
                      heading: 'Smartphone',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Felectronics%2Fsmartphones.jpg?alt=media&token=20e266ca-558b-4868-8157-9899f3bf94c5'),
                  CircleAvatar1(
                    onTap: () => initCat("Printers"),
                      heading: 'Printers',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Felectronics%2Fprinters.jpg?alt=media&token=838e9182-9e08-4fe8-b5e0-e53fcc2e21aa'),
                  CircleAvatar1(
                    onTap: () => initCat("Speakers"),
                      heading: 'Speakers',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Felectronics%2Fspeakers.jpg?alt=media&token=0c0e414f-8bb8-4490-bdf1-72f15408a987'),
                  CircleAvatar1(
                    onTap: () => initCat("Headphone"),
                      heading: 'Headphone',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Felectronics%2Fheadphones.jpg?alt=media&token=0de25786-42a2-429f-bbaf-3ad91db5ad9e'),
                  CircleAvatar1(
                    onTap: () => initCat("Cameras"),
                      heading: 'Cameras',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Felectronics%2Fcamera.jpg?alt=media&token=e7e2110d-ba6b-4d24-aa7c-cfc7425b9725'),
                  CircleAvatar1(
                    onTap: () => initCat("Consoles"),
                      heading: 'Consoles',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Felectronics%2Fconsoles.jpg?alt=media&token=97857129-17f3-408e-a40a-ae99d0caf6ad'),
                  CircleAvatar1(
                    onTap: () => initCat("DVD Players"),
                      heading: 'DVD Players',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Felectronics%2Fdvd%20players.jpg?alt=media&token=58a5c98a-4b22-4c25-a62d-7b5519f5053c'),
                  CircleAvatar1(
                    onTap: () => initCat("TV"),
                      heading: 'TV',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Felectronics%2Ftv.jpg?alt=media&token=c43f13b1-bebc-4eb0-88ac-e9a3c99c9ea9'),
                  CircleAvatar1(
                    onTap: () => initCat("Heaters"),
                      heading: 'Heaters',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Felectronics%2Fheaters.jpg?alt=media&token=057114fa-2e63-477a-8a4c-560787ea811c'),
                  CircleAvatar1(
                    onTap: () => initCat("Radios"),
                      heading: 'Radios',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Felectronics%2Fradios.jpg?alt=media&token=3acc18f2-9332-4d07-91e2-150174020d0c'),
                  CircleAvatar1(
                    onTap: () => initCat("Chargers"),
                      heading: 'Chargers',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Felectronics%2Fchargers.jpg?alt=media&token=d05ecae5-52af-4cb3-8c64-479a6ebb2ae8'),
                  CircleAvatar1(
                    onTap: () => initCat("Projectors"),
                      heading: 'Projectors',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Felectronics%2Fprojectors.jpg?alt=media&token=f0f5ef91-162f-43ab-a1fb-c4c4817554c4'),
                  CircleAvatar1(
                    onTap: () => initCat("Scanners"),
                      heading: 'Scanners',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Felectronics%2Fscanners.jpg?alt=media&token=b52e1a25-804f-4a02-82e1-3e64d732ab7b'),
                  CircleAvatar1(
                    onTap: () => initCat("Other"),
                      heading: 'Other',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fother%2Fother.jpg?alt=media&token=1c121e8b-98dc-465b-8cd7-5a7f7cd1941b'),
                ],
              );
  }
}
