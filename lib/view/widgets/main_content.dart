import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:animate_do/animate_do.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:noor_store/logic/controllers/main_controller.dart';
import 'package:noor_store/logic/controllers/product_controller.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/view/widgets/custom_nav_bar.dart';
import 'package:noor_store/view/widgets/header_widget.dart';
import 'package:noor_store/view/widgets/leading_icon.dart';

class MainContent extends StatelessWidget {
  MainContent({
    super.key,
    required this.advancedDrawer,
    required this.scrollController,
    required this.controller,
  });

  final AdvancedDrawerController advancedDrawer;
  final MainController controller;
  final ScrollController scrollController;
  final ProductController productController = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final hasFocus = FocusManager.instance.primaryFocus != null;

      if (hasFocus && productController.searchController.text.isNotEmpty) {
        productController.isSearching.value = true;
      }
    });
    return Scaffold(
      body: Obx(() {
        final isSearching = productController.isSearching.value;

        return DraggableHome(
          headerExpandedHeight: isSearching ? .01 : .55,
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
            controller.currentIndex.value == 0
                ? Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: AnimSearchBar(
                    color: whiteColor,
                    boxShadow: false,
                    textFieldIconColor: mainColor,
                    width: 370,
                    helpText: "Search by product name",
                    textController: productController.searchController,

                    onSuffixTap: () {
                      productController.searchController.clear();
                      productController.searchList.clear();
                      productController.isSearching.value = false; // ✅ رجوع
                    },

                    onSubmitted: (text) {
                      productController.isSearching.value =
                          true; // أو false حسب UX
                      productController.searchLogic(text);
                    },
                  ),
                )
                : const SizedBox(height: 1),
          ],

          leading: FadeInLeft(
            child: LeadingIcon(advancedDrawer: advancedDrawer),
          ),

          headerWidget: Obx(() {
            return productController.isSearching.value
                ? const SizedBox.shrink()
                : FadeIn(child: HeaderWidget());
          }),

          body: [
            Obx(() {
              final index = controller.currentIndex.value;

              if (index < 0 || index >= controller.tabs.length) {
                return const SizedBox.shrink();
              }

              return controller.tabs[index];
            }),
          ],
        );
      }),
    );
  }
}
