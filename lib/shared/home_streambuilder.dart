import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/shared/card_3.dart';
import 'package:flutter/material.dart';
import 'card_2.dart';

class HomeStreamBuilder extends StatefulWidget {
  final String collectionName;
  final int queryLimit;
  final String heading;
  final String subHeading;
  final String noDataErrorText;

  const HomeStreamBuilder(
      {super.key,
      required this.collectionName,
      required this.queryLimit,
      required this.heading,
      required this.subHeading,
      required this.noDataErrorText});

  @override
  State<HomeStreamBuilder> createState() => _HomeStreamBuilderState();
}

class _HomeStreamBuilderState extends State<HomeStreamBuilder> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(widget.collectionName)
          .limit(widget.queryLimit)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            width: 120,
            height: 120,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.deepPurple.shade300,
              ),
            ),
          );
        }
        final userSnapshot = snapshot.data?.docs;
        if (userSnapshot!.isEmpty) {
          //  TODO: Change what on no data
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: SizedBox(
                  height: 120,
                  child: Card3(heading: widget.noDataErrorText),
                ),
              ),
              const SizedBox(width: 10)
            ],
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: SizedBox(
            height: 120,
            child: ListView.separated(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: userSnapshot.length,
              itemBuilder: (context, index) {
                return Card2(
                  heading: userSnapshot[index][widget.heading].toString(),
                  subHeading: userSnapshot[index][widget.subHeading].toString(),
                  imageUrl: 'lib/assets/images/image1.jpg',
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 10);
              },
            ),
          ),
        );
      },
    );
  }
}
