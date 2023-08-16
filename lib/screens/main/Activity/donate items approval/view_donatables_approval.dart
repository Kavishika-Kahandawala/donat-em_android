import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/main/Activity/donate%20items%20approval/view_donatables_approval_item.dart';
import 'package:donatem/shared/card_4.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';
import 'package:get/get.dart';

class ViewDonatablesAproval extends StatefulWidget {
  const ViewDonatablesAproval({super.key});

  @override
  State<ViewDonatablesAproval> createState() => _ViewDonatablesAprovalState();
}

class _ViewDonatablesAprovalState extends State<ViewDonatablesAproval> {
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
  
  @override
  void initState() {
    super.initState();
  }


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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'No pending approvals yet. Start adding today!',
                  style:
                      TextStyle(color: Colors.deepPurple.shade300, fontSize: 20),textAlign: TextAlign.center,
                ),
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

          final String productName = json['product_name'];
          final String productDesc = json['product_desc'];

          return Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                height: 120,
                child: Card4(
                  heading: productName,
                  subHeading: productDesc,
                  imageUrl: 'lib/assets/images/image1.jpg',
                  onTap: () {
                    String docId = documentSnapshots[index].reference.id;
                    // 0 - item id, 1 - item title
                    Get.to(() => const ViewDonatablesApprovalItem(),arguments: [docId.toString(),productName.toString()]);
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          );
        },
        query: FirebaseFirestore.instance
            .collection('donation items')
            .where('assigned_status', isEqualTo: 0)
            .where('uid', isEqualTo: uid.toString())
            .where('status', isEqualTo: 2),
        itemBuilderType: PaginateBuilderType.listView);
  }
}
