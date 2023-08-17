import 'package:donatem/screens/main/home/events%20happening%20now/view_indi_event_det.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class Card6 extends StatelessWidget {
  // Org Name
  final String heading;
  // Event Heading
  final String subHeading;
  final String imageUrl;
  final String id;
  const Card6(
      {super.key,
      required this.heading,
      required this.subHeading,
      required this.imageUrl, required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(() => const ViewIndiEventDetails(),arguments: [id.toString()]);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Material(
          child: InkWell(
            child: Ink(
              // under a container
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //     image: NetworkImage(imageUrl),
              //     fit: BoxFit.cover,
              //   ),
              // ),
              width: MediaQuery.of(context).size.width * 0.80,
              color: Colors.deepPurple[100],
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Container(
                      //   decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //       image: NetworkImage(imageUrl),
                      //       fit: BoxFit.cover,
                      //     ),
                      //   ),
                      // ),
                      // Image.network(imageUrl, width: 40),
                      Icon(LineIcons.byName('book')),
                      const SizedBox(height: 10),
    
                      // Heading
                      Text(heading),
                      const SizedBox(height: 10),
    
                      // Sub Heading
                      Text(subHeading)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    // return Padding(
    //   padding: const EdgeInsets.only(left: 25.0),
    //   child: Container(
    //     padding: const EdgeInsets.all(20),
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(12),
    //       color: Colors.deepPurple[100],
    //     ),
    //     child: Column(
    //       children: [
    //         // Image.asset(imageUrl, width: 40),
    //         Icon(LineIcons.byName('book')),
    //         const SizedBox(height: 10),

    //         // Heading
    //         Text(heading),
    //         const SizedBox(height: 10),

    //         // Sub Heading
    //         Text(subHeading)
    //       ],
    //     ),
    //   ),
    // );
  }
}
