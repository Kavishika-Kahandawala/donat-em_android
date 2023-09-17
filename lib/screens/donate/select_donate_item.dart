import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/screens/donate/donated_thanks.dart';
import 'package:donatem/screens/main/navigation_bar.dart';
import 'package:donatem/shared/card_4.dart';
import 'package:donatem/shared/inputButton_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';
import 'package:get/get.dart';

class DonateItemSelect extends StatefulWidget {
  const DonateItemSelect({super.key});

  @override
  State<DonateItemSelect> createState() => _DonateItemSelectState();
}

class _DonateItemSelectState extends State<DonateItemSelect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Donation Items'),
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
  String itemName='';

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

  Future assign(String itemRefId, String recId) async {
    try {
      await FirebaseFirestore.instance
        .collection('donation items')
        .doc(itemRefId)
        .get()
        .then((querySnapshot) {
      setState(() {
        itemName = querySnapshot.get('product_name');
      });
    });
      await FirebaseFirestore.instance.collection('donation items').doc(itemRefId).set({
        'assigned_status': 1,
        'assigned_to': recId,
      },
      SetOptions(merge: true),
    );
      await FirebaseFirestore.instance.collection('donate history').doc().set({
        'assigned_status': 1,
        'assigned_to': recId,
        'item_owner':uid,
        'item_title':itemName,
        'item':itemRefId,
        'date':DateTime.now().toString(),
        'status':'pending'
      },
      SetOptions(merge: true),
    );

      //thanks last
    await Get.to(() => const DonatedThanks(),arguments: [recId.toString()]);
    } catch (e) {
      //catch error
    }
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
            children: [
              Text(
                'No items found to donate',
                style: TextStyle(color: Colors.deepPurple.shade300, fontSize: 20),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: InputButton1(onTap: (){
                      Get.to(() => const HomeUI());
                    }, text: "Go to Home"),
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

          final String product_name = json['product_name'];
          final String product_desc = json['product_desc'];

          return Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                height: 120,
                child: Card4(
                  heading: product_name,
                  subHeading: truncateString(product_desc, 40),
                  imageUrl: 'lib/assets/images/image1.jpg',
                  onTap: () {
                    String docId = documentSnapshots[index].reference.id;
                    // 0 = event name, 1 = event desc, 2 = org id, 3 = uid 4 = doc id
                    assign(docId, Get.arguments[0].toString());
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          );
        },
        query: FirebaseFirestore.instance
            .collection('donation items')
            .where('uid', isEqualTo: uid)
            .where('assigned_status', isEqualTo: 0)
            .where('status', isEqualTo: 1),
        itemBuilderType: PaginateBuilderType.listView);
  }
}
