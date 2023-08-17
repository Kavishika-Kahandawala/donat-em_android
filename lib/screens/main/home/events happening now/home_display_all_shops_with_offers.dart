import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/main/home/events%20happening%20now/view_indi_rec.dart';
import 'package:donatem/screens/main/home/events%20happening%20now/view_indi_shop_offer.dart';
import 'package:donatem/shared/card_4.dart';
import 'package:donatem/shared/card_5.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';
import 'package:get/get.dart';

class HomeDisplayAllShopOffers extends StatelessWidget {
  const HomeDisplayAllShopOffers({super.key});

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

          // final List recCats = json['rec_cats'];
          final String shopName = json['shop_name'];
          final String offerDesc = json['offer_desc'];

          return Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                height: 120,
                child: Card4(
                  heading: shopName,
                  subHeading: offerDesc,
                  imageUrl: 'lib/assets/images/image1.jpg',
                  onTap: () {
                    String docId = documentSnapshots[index].reference.id;
                    // 0 = event name, 1 = event desc, 2 = org id, 3 = uid 4 = doc id
                    Get.to(() => const ViewIndiShopOfferDetails(),
                        arguments: [docId.toString()]);
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          );
        },
        query: FirebaseFirestore.instance
            .collection('shop offers')
            .where('status', isEqualTo: 1),
        itemBuilderType: PaginateBuilderType.listView);
  }
}
