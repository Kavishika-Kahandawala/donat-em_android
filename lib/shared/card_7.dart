import 'dart:math';

import 'package:donatem/screens/main/home/events%20happening%20now/view_indi_rec.dart';
import 'package:donatem/screens/main/home/events%20happening%20now/view_indi_shop_offer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class Card7 extends StatelessWidget {
  // Org Name
  final String heading;
  // Event Heading
  final String subHeading;
  final String imageUrl;
  final String id;
  final Function()? onTap;

  Card7(
      {super.key,
      required this.heading,
      required this.subHeading,
      required this.imageUrl,
       this.onTap, required this.id});

 String truncateString(String input, int maxLength) {
    if (input.length <= maxLength) {
      return input;
    } else {
      return input.substring(0, maxLength) + '...';
    }
  }
  
  final List<IconData> iconList = [
    LineIcons.shoppingBasket,
    LineIcons.shoppingCart,
    LineIcons.store,
    LineIcons.shoppingBasket,
    LineIcons.alternateStore,
    LineIcons.tags,
  ];

  final Random random = Random();

  IconData getRandomIcon() {
    int randomIndex = random.nextInt(iconList.length);
    return iconList[randomIndex];
  }

  // late IconData randomIcon;
  @override
  Widget build(BuildContext context) {
    IconData randomIcon = getRandomIcon();

    return GestureDetector(
      onTap: (){
        Get.to(() => const ViewIndiShopOfferDetails(),arguments: [id.toString(),subHeading]);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Material(
          child: InkWell(
            child: Ink(
              width: MediaQuery.of(context).size.width * 0.80,
              color: Colors.deepPurple[100],
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(randomIcon, size: 30),
                      const SizedBox(height: 10),

                      // Heading
                      Row(
                        children: [
                          Text(heading),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Sub Heading
                      Row(
                        children: [
                          Text(truncateString(subHeading,40)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
