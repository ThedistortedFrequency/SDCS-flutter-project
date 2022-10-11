import 'package:flutter/material.dart';
import 'package:sdcs/onboarding/IntroPage/intro.dart';
import 'package:sdcs/onboarding/IntroPage/intro2.dart';
import 'package:sdcs/onboarding/IntroPage/intro3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // for page controller
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // page view
          PageView(
            controller: _controller,
            children: const [IntroPage(), IntroPage2(), IntroPage3()],
          ),

          // dot indicator
          Container(
            alignment: const Alignment(0, 0.925),
            child: SmoothPageIndicator(
              effect: const WormEffect(dotHeight: 7),
              controller: _controller,
              count: 3,
            ),
          ),
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 25.0, horizontal: 8),
              child: Column(
                children: const [
                  Text("Skip"),
                  Text("Next"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
