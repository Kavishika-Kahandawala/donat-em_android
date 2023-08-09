// Deprecated


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeLoadEventsDetails extends StatelessWidget {
  HomeLoadEventsDetails({super.key});

  // final String docId = Get.arguments[0].toString();
  final String docId = "LHrm6sjFnU3xVt0U7T6h";

  @override
  Widget build(BuildContext context) {
    CollectionReference events =
        FirebaseFirestore.instance.collection('org events');
    return FutureBuilder<DocumentSnapshot>(
      future: events.doc(docId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text("Event Name: ${data['event_name']}");
        }
        return const Text("loading");
      },
    );
  }
}
