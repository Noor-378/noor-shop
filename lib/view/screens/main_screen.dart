import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:noor_store/logic/controllers/main_controller.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/view/widgets/drawer_content.dart';
import 'package:noor_store/view/widgets/main_content.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final controller = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder:
          (controller) => AdvancedDrawer(
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 500),
            animateChildDecoration: true,
            rtlOpening: false,
            disabledGestures: false,
            backdropColor: mainColor,
            childDecoration: const BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(color: Colors.black26, blurRadius: 10.0),
              ],
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            controller: controller.advancedDrawer,
            backdrop: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  // ignore: deprecated_member_use
                  colors: [Colors.blueGrey, Colors.blueGrey.withOpacity(0.2)],
                ),
              ),
            ),
            drawer: DrawerContent(advancedDrawer: controller.advancedDrawer),
            child: MainContent(
              advancedDrawer: controller.advancedDrawer,
              scrollController: controller.scrollController,
              controller: controller,
            ),
          ),
    );
  }
}
