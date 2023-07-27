import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/shared/circular_loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'edit_user_details.dart';

class GetUSerDetailsToEdit extends StatefulWidget {
  const GetUSerDetailsToEdit({super.key});

  @override
  State<GetUSerDetailsToEdit> createState() => _GetUSerDetailsToEditState();
}

class _GetUSerDetailsToEditState extends State<GetUSerDetailsToEdit> {

  String uid = FirebaseAuth.instance.currentUser!.uid.toString();
  //Firebase get data
  Future getDetails() async {
    await FirebaseFirestore.instance.collection('users').doc(uid).get().then(
      (querySnapshot) {
          String fname=(querySnapshot.get('first_name'));
          String lname=(querySnapshot.get('last_name'));
          Get.to(()=> const EditUserDetails(), arguments: [fname.toString(),lname.toString()]);

      },
      onError: (e) {
        // Dialog to show error TODO:
      },
    );
  }

  @override
  void initState() {
    getDetails();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: CircularLoadingUI());
  }
}

// Deprecated code