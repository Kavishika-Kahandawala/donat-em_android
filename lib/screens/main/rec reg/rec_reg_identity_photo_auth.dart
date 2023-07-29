import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/main/additem/item_thanks.dart';
import 'package:donatem/screens/main/additem/photos%20upload/photo_upload_1.dart';
import 'package:donatem/screens/main/org%20reg/org_reg_thanks.dart';
import 'package:donatem/screens/main/rec%20reg/rec_reg_photo_upload.dart';
import 'package:donatem/screens/main/rec%20reg/rec_reg_thanks.dart';
import 'package:donatem/shared/circular_loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecRegIdentityPhotoAuth extends StatefulWidget {
  const RecRegIdentityPhotoAuth({super.key});

  @override
  State<RecRegIdentityPhotoAuth> createState() =>
      _RecRegIdentityPhotoAuthState();
}

class _RecRegIdentityPhotoAuthState extends State<RecRegIdentityPhotoAuth> {
  final String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  //Firebase get data
  Future regIncomplete() async {
    String keyword;
    await FirebaseFirestore.instance.collection('users').doc(uid).get().then(
      (querySnapshot) async {
        if (querySnapshot.get('rec_reg_identity_photo_step') < 2) {
          keyword = 'Upload the other side of your document';
          if (querySnapshot.get('rec_reg_identity_photo_step') == 0) {
            keyword = 'Upload an image of first side of your document';
            await updateFirestore();
            await addFirestoreData();
          }
          String newImgNum =
              (querySnapshot.get('rec_reg_identity_photo_step') + 1).toString();

          // arg 0 = next image number
          await Get.to(() => const RecRegPhotoUpload(), arguments: [
            newImgNum.toString(), keyword.toString()
          ]);
        } else {
          finalizeData();
          Get.to(() => const RecRegThanks());
        }
      },
      onError: (e) {
        // Dialog to show error TODO:
      },
    );
    // return status;
  }
  Future finalizeData()async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set(
      {
        'receiver_reg_status': 2,
      },
      SetOptions(merge: true),
    );
  }

  Future updateFirestore() async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set(
      {
        'rec_reg_identity_photo_type': Get.arguments[0].toString(),
      },
      SetOptions(merge: true),
    );
  }

  Future addFirestoreData() async {
    await FirebaseFirestore.instance
        .collection('rec reg identity')
        .doc(uid)
        .set({'document type': Get.arguments[0].toString()});
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
