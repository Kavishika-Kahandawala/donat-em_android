import 'package:donatem/screens/on_board_screen/intro_1.dart';
import 'package:donatem/screens/on_board_screen/intro_2.dart';
import 'package:donatem/screens/on_board_screen/intro_3.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../services/auth.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  // Track keeping controller
  final PageController _controller = PageController();

  // Track whether on last page
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: [
              Intro1(),
              Intro2(),
              Intro3(),
            ],
          ),

          //dot indicator
          Container(
              alignment: Alignment(0, 0.78),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //skip
                  onLastPage
                      ? GestureDetector(
                          onTap: () {
                            _controller.jumpToPage(2);
                          },
                          // TODO: Check with different resolutions
                          child: SizedBox(width: 30),
                        )
                      : GestureDetector(
                          onTap: () {
                            _controller.jumpToPage(2);
                          },
                          child: Text('skip'),
                        ),

                  //dot indicator
                  SmoothPageIndicator(controller: _controller, count: 3),

                  //done or next
                  onLastPage
                      ? GestureDetector(
                          onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return AuthService();
                          },));
                          },
                          child: Text('Done'),
                        )
                      : GestureDetector(
                          onTap: () {
                            _controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            );
                          },
                          child: Text('Next'),
                        ),
                ],
              ))
        ],
      ),
    );
  }
}
