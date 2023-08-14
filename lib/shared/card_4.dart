import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class Card4 extends StatelessWidget {
  // Org Name
  final String heading;
  // Event Heading
  final String subHeading;
  final String imageUrl;
  final Function()? onTap;
  
  const Card4(
      {super.key,
      required this.heading,
      required this.subHeading,
      required this.imageUrl, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Material(
          child: InkWell(
            onTap:onTap,
            child: Ink(
              // width: MediaQuery.of(context).size.width * 0.80,
              color: Colors.deepPurple[100],
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Heading
                          Text(
                            heading,
                            style: GoogleFonts.poppins(fontSize: 22),
                          ),
                          const SizedBox(height: 10),
    
                          // Sub Heading
                          Text(
                            subHeading,
                            style: GoogleFonts.poppins(fontSize: 12),
                          )
                        ],
                      ),
                      const Icon(LineIcons.angleRight)
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
