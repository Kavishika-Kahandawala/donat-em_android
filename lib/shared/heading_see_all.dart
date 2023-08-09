import 'package:flutter/material.dart';

class HeadingSeeAll extends StatelessWidget {
  final String heading;
  final Function()? onTap;

  const HeadingSeeAll({super.key, required this.heading, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(heading),
          GestureDetector(
              onTap: onTap, child: const SizedBox(child: Text('See all')))
        ],
      ),
    );
  }
}
