import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  PageController pageController = PageController();
  bool isLast = false;
  bool showText = false;
  // bool showText = false;
  void makeSkipGoAway() {
    isLast = !isLast;
    update();
  }

  void makeSkipComeBack() {
    isLast = false;
    update();
  }

  void showTextFalse() {
    showText = false;
    update();
  }

  void showTextTrue() {
    showText = true;
    update();
  }
}
