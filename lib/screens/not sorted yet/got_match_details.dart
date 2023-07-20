import 'package:flutter/material.dart';

import '../../shared/got_match_det_text.dart';

class GotMatchDetailsUI extends StatelessWidget {
  const GotMatchDetailsUI({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                // Details
                //
                // Item Name
                GotMatchDet(
                    heading: 'Item Looking For : ',
                    subHeading: 'sample subtext'),
                // Item Category
                GotMatchDet(
                    heading: 'Category : ', subHeading: 'sample subtext'),
                // Item Keywords
                GotMatchDet(
                    heading: 'Keywords : ', subHeading: 'sample subtext'),

                // Buttons
                //
                // About Recipient
                // View Recipient History
                //Proceed Donation
              ],
            ),
          ),
        ),
      ),
    );
  }
}
