import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hidable/hidable.dart';
import 'package:noor_store/logic/controllers/main_controller.dart';
import 'package:noor_store/utils/colors.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
    required this.controller,
    required this.scrollController,
  });

  final ScrollController scrollController;
  final MainController controller;

  @override
  Widget build(BuildContext context) {
    return Hidable(
      controller: scrollController,
      enableOpacityAnimation: false,
      child: CurvedNavigationBar(
        index: controller.currentIndex.value,
        height: 65,
        // color: lightGrey,
        animationDuration: const Duration(milliseconds: 500),
        backgroundColor: Get.isDarkMode ? secondColor : mainColor,
        items: [
          Image.asset("assets/images/home.png"),
          Image.asset("assets/images/category.png"),
          Image.asset("assets/images/heart.png"),
          Image.asset("assets/images/cart.png"),
        ],
        onTap: (index) {
          controller.changeIndex(index);
        },
      ),
    );
  }
}
