import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/main/navigation_bar.dart';
import 'package:donatem/screens/main/org%20ui/org%20events%20handle/handle_event_det.dart';
import 'package:donatem/shared/card_4.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';
import 'package:get/get.dart';

class HandleOrgEventSelect extends StatefulWidget {
  const HandleOrgEventSelect({super.key});

  @override
  State<HandleOrgEventSelect> createState() => _HandleOrgEventSelectState();
}

class _HandleOrgEventSelectState extends State<HandleOrgEventSelect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Events'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.deepPurple.shade300,
          elevation: 0.5,
        ),
        backgroundColor: Colors.white,
        body: const SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: _PaginatedFirestoreList(),
            ),
          ),
        ));
  }
}

class _PaginatedFirestoreList extends StatefulWidget {
  const _PaginatedFirestoreList();

  @override
  State<_PaginatedFirestoreList> createState() =>
      _PaginatedFirestoreListState();
}

class _PaginatedFirestoreListState extends State<_PaginatedFirestoreList> {
  // firebase uid
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  String truncateString(String input, int maxLength) {
    if (input.length <= maxLength) {
      return input;
    } else {
      return input.substring(0, maxLength) + '...';
    }
  }
// String longText = 'This is a long piece of text that needs to be truncated.';
  // int maxLength = 20;

  // String truncatedText = '';

  // Future assign(String itemRefId, String recId) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('donation items')
  //         .doc(itemRefId)
  //         .set(
  //       {
  //         'assigned_status': 1,
  //         'assigned_to': recId,
  //       },
  //       SetOptions(merge: true),
  //     );
  //     await FirebaseFirestore.instance.collection('donate history').doc().set(
  //       {
  //         'assigned_status': 1,
  //         'assigned_to': recId,
  //         'item_owner': uid,
  //         'item': itemRefId,
  //         'date': DateTime.now().toString(),
  //         'status': 'pending'
  //       },
  //       SetOptions(merge: true),
  //     );

  //     //thanks last
  //     await Get.to(() => const DonatedThanks(), arguments: [recId.toString()]);
  //   } catch (e) {
  //     //catch error
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return PaginateFirestore(
        itemsPerPage: 10,
        isLive: true,
        initialLoader: Center(
          child: CircularProgressIndicator(
            color: Colors.deepPurple.shade300,
          ),
        ),
        onEmpty: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'No events started. Let\'s start one!',
                style:
                    TextStyle(color: Colors.deepPurple.shade300, fontSize: 20),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: InputButton1(
                    onTap: () {
                      Get.to(() => const HomeUI());
                    },
                    text: "Go to Home"),
              ),
            ],
          ),
        ),
        onError: (e) => Center(
              child: Text(
                'An error occurred',
                style:
                    TextStyle(color: Colors.deepPurple.shade300, fontSize: 20),
              ),
            ),
        bottomLoader: Center(
          child: CircularProgressIndicator(
            color: Colors.deepPurple.shade300,
          ),
        ),
        separator: const SizedBox(height: 10),
        itemBuilder: (context, documentSnapshots, index) {
          final Map<String, dynamic> json =
              documentSnapshots[index].data() as Map<String, dynamic>;

          final String eventDesc = json['event_desc'];
          final String eventName = json['event_name'];

          return Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                height: 120,
                child: Card4(
                  heading: eventName,
                  subHeading: eventDesc,
                  imageUrl: 'lib/assets/images/image1.jpg',
                  onTap: () {
                    String docId = documentSnapshots[index].reference.id;
                    // 0 - item id, 1 - item title, 2 - doc id
                    Get.to(() => const HandleOrgEventDetails(),arguments: [docId.toString()]);
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          );
        },
        query: FirebaseFirestore.instance
            .collection('org events')
            .where('uid', isEqualTo: uid)
            .where('status', isEqualTo: 1),
        itemBuilderType: PaginateBuilderType.listView);
  }
}
