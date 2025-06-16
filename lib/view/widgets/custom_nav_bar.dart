import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noor_store/logic/controllers/main_controller.dart';
import 'package:noor_store/utils/colors.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
    required this.controller,
  });

  final MainController controller;

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: controller.currentIndex.value,
      color: lightGrey,
      animationDuration: const Duration(milliseconds: 500),
      backgroundColor: Get.isDarkMode ? secondColor : mainColor,
      items: [
        Icon(
          Icons.home_outlined,
          size: 30,
          color: Get.isDarkMode ? whiteColor : blackColor,
        ),
        Icon(
          Icons.apps,
          size: 30,
          color: Get.isDarkMode ? whiteColor : blackColor,
        ),
        Icon(
          Icons.favorite_border,
          size: 30,
          color: Get.isDarkMode ? whiteColor : blackColor,
        ),
      ],
      onTap: (index) {
        controller.change(index);
      },
    );
  }
}