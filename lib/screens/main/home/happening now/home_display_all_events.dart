import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/shared/card_4.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:flutter/material.dart';

class HomeDisplayAllEvents extends StatefulWidget {
  const HomeDisplayAllEvents({super.key});

  @override
  State<HomeDisplayAllEvents> createState() => _HomeDisplayAllEventsState();
}

class _HomeDisplayAllEventsState extends State<HomeDisplayAllEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Events'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepPurple.shade300,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: FirestorePagination(
            
            viewType: ViewType.wrap,
            onEmpty: const Center(
              child: Text('Cart is empty'),
            ),
            query: FirebaseFirestore.instance.collection('org events'),
            isLive: true,
            limit: 3,
            itemBuilder: (context, documentSnapshot, index) {
              final data = documentSnapshot.data() as Map<String, dynamic>?;
              if (data == null) {
                // TODO: Firebase data is null
                return Container();
              }
              return Card4(
                heading: data['event_name'],
                subHeading: data['event_desc'],
                imageUrl: 'lib/assets/images/image1.jpg',
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
          ),
        ),
      ),
    );
  }
}
