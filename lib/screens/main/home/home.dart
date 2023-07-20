import 'package:flutter/material.dart';

import '../../../shared/card_2.dart';
import '../../../shared/heading_see_all.dart';

class MainPageUI extends StatefulWidget {
  const MainPageUI({super.key});

  @override
  State<MainPageUI> createState() => _MainPageUIState();
}

class _MainPageUIState extends State<MainPageUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Fund Raising events happening Now TODO:

                const HeadingSeeAll(
                  heading: 'Fund Raising events happening now',
                ),
                // check whether sized box or container TODO:
                SizedBox(
                  height: 100,
                  child: ListView(
                    children: const [
                      // Cards
                      Card2(
                        heading: 'Organization Name',
                        subHeading: 'Event Heading',
                        imageUrl: 'lib/assets/images/image1.jpg',
                      ),
                    ],
                  ),
                ),

                //Browse who can you help TODO:
                const HeadingSeeAll(
                  heading: 'Browse who can you help',
                ),

                // check whether sized box or container TODO:
                SizedBox(
                  height: 100,
                  child: ListView(
                    children: const [
                      // Cards
                      Card2(
                        heading: 'Looking for : Item Name',
                        subHeading: 'Item category',
                        imageUrl: 'lib/assets/images/image1.jpg',
                      ),
                    ],
                  ),
                ),

                // Offers right now TODO:
                const HeadingSeeAll(
                  heading: 'Offers right now',
                ),
                // check whether sized box or container TODO:
                SizedBox(
                  height: 100,
                  child: ListView(
                    children: const [
                      // Cards
                      Card2(
                        heading: 'Shop Name',
                        subHeading: 'Location (Address)',
                        imageUrl: 'lib/assets/images/image1.jpg',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
