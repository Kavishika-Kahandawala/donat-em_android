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
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fhouseholds%2Fknives.jpg?alt=media&token=07ff39fa-aa92-4e54-948f-ab25b3caa6bb'),
                  CircleAvatar1(
                    onTap: () => initCat("Bowls"),
                      heading: 'Bowls',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fhouseholds%2Fbowls.jpg?alt=media&token=bac4ed58-c1b5-42d7-be9f-e74ef77a09eb'),
                  CircleAvatar1(
                    onTap: () => initCat("Cups"),
                      heading: 'Cups',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fhouseholds%2Fcups.jpg?alt=media&token=6d1e9302-f100-4feb-9fb6-c6aad06dacb9'),
                  CircleAvatar1(
                    onTap: () => initCat("Pans"),
                      heading: 'Pans',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fhouseholds%2Fpans.jpg?alt=media&token=00c578d7-c31e-46d3-afac-e8dd24396c89'),
                  CircleAvatar1(
                    onTap: () => initCat("Plates"),
                      heading: 'Plates',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fhouseholds%2Fplates.jpg?alt=media&token=4f9aeb9a-ee69-4c44-9617-64ffb986edd1'),
                  CircleAvatar1(
                    onTap: () => initCat("Toasters"),
                      heading: 'Toasters',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fhouseholds%2Ftoasters.jpg?alt=media&token=bd738658-43ef-4376-9150-585ea094a09b'),
                  CircleAvatar1(
                    onTap: () => initCat("Blenders"),
                      heading: 'Blenders',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fhouseholds%2Fblenders.jpg?alt=media&token=0e1b7125-83f4-4cf3-823c-bc7be890dd6b'),
                  CircleAvatar1(
                    onTap: () => initCat("Tables"),
                      heading: 'Tables',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fhouseholds%2Ftables.jpg?alt=media&token=437178f3-a2f3-431b-b31a-ded9d24ce34f'),
                  CircleAvatar1(
                    onTap: () => initCat("Chairs"),
                      heading: 'Chairs',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fhouseholds%2Fchairs.jpg?alt=media&token=d7eb98e7-ebd8-426c-b252-5a31734ef786'),
                  CircleAvatar1(
                    onTap: () => initCat("Furniture"),
                      heading: 'Furniture',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fhouseholds%2Fchairs.jpg?alt=media&token=d7eb98e7-ebd8-426c-b252-5a31734ef786'),
                  CircleAvatar1(
                    onTap: () => initCat("Lamps"),
                      heading: 'Lamps',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fhouseholds%2Flamps.jpg?alt=media&token=49eab41a-bc4f-4d09-9bb9-68bec877e66a'),
                  CircleAvatar1(
                    onTap: () => initCat("Clocks"),
                      heading: 'Clocks',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fhouseholds%2Fclocks.jpg?alt=media&token=db5e306d-9ec7-47ed-8167-f32c0992145a'),
                  CircleAvatar1(
                    onTap: () => initCat("Fans"),
                      heading: 'Fans',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fhouseholds%2Ffans.jpg?alt=media&token=13439b42-36ea-4c9f-aa8b-05d643f81ffd'),
                  CircleAvatar1(
                    onTap: () => initCat("Vases"),
                      heading: 'Vases',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fhouseholds%2Fvasses.jpg?alt=media&token=8c0be1c0-c067-421a-9863-57cf83d11b9c'),
                  CircleAvatar1(
                    onTap: () => initCat("Artwork"),
                      heading: 'Artwork',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fhouseholds%2Fartworks.jpeg?alt=media&token=ac54e74f-0b5f-46e1-b15a-59090c17fe4d'),
                  CircleAvatar1(
                    onTap: () => initCat("Ornaments"),
                      heading: 'Ornaments',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fhouseholds%2Fornaments.jpg?alt=media&token=1333cc86-599f-4a2d-9af3-8c6e226795cc'),
                  CircleAvatar1(
                    onTap: () => initCat("Other"),
                      heading: 'Other',
                      imgUrl:
                          'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/donation%20items%20cats%20images%2Fother%2Fother.jpg?alt=media&token=1c121e8b-98dc-465b-8cd7-5a7f7cd1941b'),
                ],
              );
  }
}
