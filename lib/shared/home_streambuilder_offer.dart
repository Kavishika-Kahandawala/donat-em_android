import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donatem/shared/card_3.dart';
import 'package:donatem/shared/card_7.dart';
import 'package:flutter/material.dart';
import 'card_2.dart';
import 'card_6.dart';

class HomeStreamBuilderOffer extends StatefulWidget {
  final String collectionName;
  final int queryLimit;
  final String heading;
  final String subHeading;
  final String noDataErrorText;

  const HomeStreamBuilderOffer(
      {super.key,
      required this.collectionName,
      required this.queryLimit,
      required this.heading,
      required this.subHeading,
      required this.noDataErrorText});

  @override
  State<HomeStreamBuilderOffer> createState() => _HomeStreamBuilderOfferState();
}

class _HomeStreamBuilderOfferState extends State<HomeStreamBuilderOffer> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(widget.collectionName)
          .limit(widget.queryLimit).where('status', isEqualTo: 1)
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
                return Card7(
                  id: userSnapshot[index].reference.id.toString(),
                  heading: userSnapshot[index][widget.heading].toString(),
                  subHeading: userSnapshot[index][widget.subHeading].toString(),
                  imageUrl:
                      'https://firebasestorage.googleapis.com/v0/b/donat-em-a9d65.appspot.com/o/Donation%20Items%2FItem%20Images%2F1690776484847d3IvSGciApYT32m35IKsoJp6JqF2?alt=media&token=030224a3-ee24-4ab5-b97c-8df9f5096a20',
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
