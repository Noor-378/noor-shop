import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreenAnimations extends StatelessWidget {
  const WelcomeScreenAnimations({
    super.key,

    required this.index, //
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        index == 0
            ? Container()
            : Lottie.asset("assets/animations/Noor_Shop2.json"),
        LottieBuilder.asset(
          repeat: index == 2 ? false : true,
          welcomeContent[index].animation, //
        ),
      ],
    );
  }
}

List<WelcomeModel> welcomeContent = [
  WelcomeModel(
    animation: "assets/animations/Noor_Shop7.json",
    title: "Find the things you want!",
    body: "Explore more than millions of products in",
  ),
  WelcomeModel(
    animation: "assets/animations/Noor_Shop6.json",
    title: "Catch the falsh sales",
    body: "Don't miss any of our daily flash sales!",
  ),
  WelcomeModel(
    animation: "assets/animations/Noor_Shop4.json",
    title: "Fast delivery",
    body: "If your product is delayed, you’ll get it for",
  ),
];

class WelcomeModel {
  final String animation;
  final String title;
  final String body;
  WelcomeModel({
    required this.animation,
    required this.title,
    required this.body,
  });
}
