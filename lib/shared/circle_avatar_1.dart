import 'package:flutter/material.dart';

class CircleAvatar1 extends StatelessWidget {
  final Function()? onTap;
  final String heading;
  final String imgUrl;
  const CircleAvatar1({super.key, required this.heading, required this.imgUrl, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(imgUrl),
          ),
          const SizedBox(height: 5),
          Text(heading,textAlign: TextAlign.center,),
        ],
      ),
    );
  }
}
