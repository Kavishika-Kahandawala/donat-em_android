import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/main/home/events%20happening%20now/view_indi_rec.dart';
import 'package:donatem/shared/card_4.dart';
import 'package:donatem/shared/card_5.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';
import 'package:get/get.dart';

class HomeDisplayAllRecs extends StatelessWidget {
  const HomeDisplayAllRecs({super.key});

  // firebase uid
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
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
      ),
    );
  }
}

class _PaginatedFirestoreList extends StatefulWidget {
  const _PaginatedFirestoreList();

  @override
  State<_PaginatedFirestoreList> createState() => _PaginatedFirestoreListState();
}

class _PaginatedFirestoreListState extends State<_PaginatedFirestoreList> {

  String uid = FirebaseAuth.instance.currentUser!.uid.toString();

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
          child: Text(
            'No recipients found',
            style: TextStyle(color: Colors.deepPurple.shade300, fontSize: 20),
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

          // final String eventDesc = json['event_desc'];
          final List recCats = json['rec_cats'];
          // final String orgId = json['org_id'];
          // final String uid = json['uid'];

          return Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                height: 120,
                child: Card5(
                  id: documentSnapshots[index].reference.id.toString(),
                  heading: 'Interested in :',
                  subHeading: recCats,
                  imageUrl: 'lib/assets/images/image1.jpg',
                  onTap: () {
                    String docId = documentSnapshots[index].reference.id;
                    // 0 = event name, 1 = event desc, 2 = org id, 3 = uid 4 = doc id
                    Get.to(() => const ViewIndiRecDetails(),
                        arguments: [docId.toString(), recCats.toString()]);
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          );
        },
        query: FirebaseFirestore.instance
            .collection('users')
            .where('receiver_reg_status', isEqualTo: 1)
            //Exclude current user from the list
            .where(FieldPath.documentId, isNotEqualTo: uid),
        itemBuilderType: PaginateBuilderType.listView);
  }
}
