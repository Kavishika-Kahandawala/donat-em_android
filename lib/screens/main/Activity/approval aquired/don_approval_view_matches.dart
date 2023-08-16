import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/main/Activity/matching/don_view_indi_match_item.dart';
import 'package:donatem/screens/main/navigation_bar.dart';
import 'package:donatem/shared/card_4.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DonApprovalMatchItemSelect extends StatefulWidget {
  const DonApprovalMatchItemSelect({super.key});

  @override
  State<DonApprovalMatchItemSelect> createState() => _DonApprovalMatchItemSelectState();
}

class _DonApprovalMatchItemSelectState extends State<DonApprovalMatchItemSelect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Matched Items'),
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
                'No items matched yet. But have hope!',
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

          final String itemTitle = json['item_title'];
          final String date = json['date'];
          final String item = json['item'];
          final String assignId = json['assigned_to'];

          return Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                height: 120,
                child: Card4(
                  heading: itemTitle,
                  subHeading: 'Matched on: '+DateFormat.yMEd().format(DateTime.parse(date)),
                  imageUrl: 'lib/assets/images/image1.jpg',
                  onTap: () {
                    String docId = documentSnapshots[index].reference.id;
                    // 0 - item id, 1 - item title, 2 - doc id 3 - assign ID
                    Get.to(() => const DonViewIndiMatchedItem(),arguments: [item.toString(),itemTitle.toString(),docId.toString(),assignId.toString()]);
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          );
        },
        query: FirebaseFirestore.instance
            .collection('donate history')
            .where('item_owner', isEqualTo: uid)
            .where('assigned_status', isEqualTo: 1)
            .where('status', isEqualTo: 'pending'),
        itemBuilderType: PaginateBuilderType.listView);
  }
}
