import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserTest extends StatefulWidget {
  const UserTest({super.key});

  @override
  State<UserTest> createState() => _UserTestState();
}

class _UserTestState extends State<UserTest> {
  // Document ID
  List<String> docIDs = [];

  // Get DocIDs
  // Future getDocId() async {
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .get()
  //       .then((snapshot) => snapshot.docs.forEach((element) {
  //             print(element.reference);
  //           }));
  // }
  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where(
          'firstname',
          isEqualTo: 'fname',
        )
        .limit(1)
        .get()
        .then((querySnapshot) {
      print('Successfully completed');
      for (var docSnapshot in querySnapshot.docs) {
        // print('${docSnapshot.id} => ${docSnapshot.data()}');
        print(docSnapshot.get('email'));
      }
    }, onError: (e) {
      print(e);
    });
  }

  @override
  void initState() {
    getDocId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: SingleChildScrollView(
            child: Column(
              children: [],
            ),
          ),
        ),
      )),
    );
  }
}
