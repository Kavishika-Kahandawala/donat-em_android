import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/main/additem/item_thanks.dart';
import 'package:donatem/screens/main/additem/photos%20upload/photo_upload_1.dart';
import 'package:donatem/shared/circular_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DonationPhotoAuth extends StatefulWidget {
  const DonationPhotoAuth({super.key});

  @override
  State<DonationPhotoAuth> createState() => _DonationPhotoAuthState();
}

class _DonationPhotoAuthState extends State<DonationPhotoAuth> {

  //Firebase get data
  Future regIncomplete() async {
    await FirebaseFirestore.instance.collection('donation items').doc(Get.arguments[0]).get().then(
      (querySnapshot) {
        if (querySnapshot.get('image_count') < 3) {
          String newImgNum=(querySnapshot.get('image_count')+1).toString();
          // arg 0= user id, arg 1= next image number
          Get.to(()=> const PhotoUploadUI1(), arguments: [Get.arguments[0].toString(),newImgNum.toString()]);
        } else {
          Get.to(()=> const ItemThanks(), arguments: [Get.arguments[0].toString()]);
        }
      },
      onError: (e) {
        // Dialog to show error TODO:
      },
    );
    // return status;
  }

  @override
  void initState() {
    regIncomplete();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: CircularLoadingUI());
  }
}
