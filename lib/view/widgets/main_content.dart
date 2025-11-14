import 'package:animate_do/animate_do.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
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
        headerExpandedHeight: .55,
        scrollController: scrollController,
        bottomNavigationBar: CustomNavBar(
          scrollController: scrollController,
          controller: controller,
        ),

        alwaysShowLeadingAndAction: true,
        alwaysShowTitle: true,

        appBarColor: mainColor,
        backgroundColor: contentColor,
        title: FadeInDown(
          child: Text(controller.titles[controller.currentIndex.value]),
        ),
        centerTitle: true,
        actions: [
          // controller.currentIndex.value == 0
          //     ? Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: AnimSearchBar(
          //         color: whiteColor,
          //         textFieldIconColor: mainColor,
          //         width: 300,
          //         helpText: "Type something to start searching…",
          //         textController: TextEditingController(),
          //         onSuffixTap: () {
          //           TextEditingController().clear();
          //         },
          //         onSubmitted: (String) {},
          //       ),
          //     )
          //     : const SizedBox(height: 1),
          FadeInRight(
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
            ),
          ),
        ],
        leading: FadeInLeft(child: LeadingIcon(advancedDrawer: advancedDrawer)),
        headerWidget: FadeIn(child:  HeaderWidget()),
        body: [
          IndexedStack(
            index: controller.currentIndex.value,
            children: controller.tabs,
          ),
        ],
      ),
    );
  }
}
