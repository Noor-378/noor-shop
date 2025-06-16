import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:hidable/hidable.dart';
import 'package:noor_store/logic/controllers/main_controller.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/view/widgets/custom_nav_bar.dart';
import 'package:noor_store/view/widgets/header_widget.dart';
import 'package:noor_store/view/widgets/leading_icon.dart';

class MainContent extends StatelessWidget {
  const MainContent({
    super.key,
    required this.advancedDrawer,
    required this.scrollController,
    required this.controller,
  });

  final AdvancedDrawerController advancedDrawer;
  final MainController controller;
  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: controller.tabs[controller.currentIndex.value],
      body: DraggableHome(
        scrollController: scrollController,
        bottomNavigationBar: CustomNavBar(
          scrollController: scrollController,
          controller: controller,
        ),

        alwaysShowLeadingAndAction: true,
        alwaysShowTitle: true,
        appBarColor: scaffoldDarkColor,
        backgroundColor: Get.isDarkMode ? lightGrey : mainColor,
        title: Text(controller.titles[controller.currentIndex.value]),
        centerTitle: true,
        leading: LeadingIcon(advancedDrawer: advancedDrawer),
        headerWidget: const HeaderWidget(),
        body: [
          Container(
            color: Get.isDarkMode ? lightGrey : mainColor,
            child: IndexedStack(
              index: controller.currentIndex.value,
              children: controller.tabs,
            ),
          ),
        ],
      ),
    );
  }
}
