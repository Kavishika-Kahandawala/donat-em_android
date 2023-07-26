import 'package:flutter/material.dart';

import 'circle_avatar_1.dart';

class CatDrid1 extends StatelessWidget {
  const CatDrid1({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                // primary: false,
                children: const [
                  CircleAvatar1(
                      heading: 'Sample heading ',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                      heading: 'Sample heading ',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                      heading: 'Sample heading ',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                      heading: 'Sample heading ',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg'),
                  CircleAvatar1(
                      heading: 'Sample heading ',
                      imgUrl:
                          'https://cdn.jpegmini.com/user/images/slider_puffin_jpegmini_mobile.jpg')
                ],
              );
  }
}