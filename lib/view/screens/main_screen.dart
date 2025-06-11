import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:hidable/hidable.dart';
import 'package:noor_store/logic/controllers/main_controller.dart';
import 'package:noor_store/utils/colors.dart';

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
            backdropColor: Colors.blue,
            childDecoration: const BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(color: Colors.black12, blurRadius: 0.0),
              ],
              borderRadius: BorderRadius.all(Radius.circular(16)),
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
            drawer: const DrawerContent(),
            child: MainContent(
              advancedDrawer: controller.advancedDrawer,
              scrollController: controller.scrollController,
              controller: controller,
            ),
          ),
    );
  }
}

class MainContent extends StatelessWidget {
  const MainContent({
    super.key,
    required this.advancedDrawer,
    required this.scrollController,
    required this.controller,
  });

  final AdvancedDrawerController advancedDrawer;
  final ScrollController scrollController;
  final MainController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("data"),
        centerTitle: true,
        leading: ValueListenableBuilder<AdvancedDrawerValue>(
          valueListenable: advancedDrawer,
          builder: (_, value, __) {
            return IconButton(
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder:
                    (child, animation) => RotationTransition(
                      turns:
                          // ignore: unrelated_type_equality_checks
                          child == const ValueKey('arrow')
                              ? animation
                              : Tween(begin: 0.5, end: 1.0).animate(animation),
                      child: child,
                    ),
                child: Icon(
                  value.visible ? Icons.arrow_back : Icons.menu,
                  key: ValueKey(value.visible ? 'arrow' : 'menu'),
                ),
              ),
              onPressed: () => advancedDrawer.showDrawer(),
            );
          },
        ),
      ),
      body: controller.tabs[controller.currentIndex.value],
      bottomNavigationBar: Hidable(
        controller: scrollController,
        enableOpacityAnimation: false,
        child: Obx(
          () => CurvedNavigationBar(
            index: controller.currentIndex.value,
            animationDuration: const Duration(milliseconds: 500),
            backgroundColor:
                Get.isDarkMode
                    ? LightAppColors.secondColor
                    : LightAppColors.mainColor,
            items: const [
              Icon(Icons.home_outlined, size: 30),
              Icon(Icons.apps, size: 30),
              Icon(Icons.favorite_border, size: 30),
            ],
            onTap: (index) {
              controller.change(index);
            },
          ),
        ),
      ),
    );
  }
}

class DrawerContent extends StatelessWidget {
  const DrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListTileTheme(
        textColor: Colors.white,
        iconColor: Colors.white,
        child: Column(
          children: [
            Container(
              width: 128.0,
              height: 128.0,
              margin: const EdgeInsets.only(top: 24.0, bottom: 64.0),
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                color: Colors.black26,
                shape: BoxShape.circle,
              ),
              child: const CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 30,
              ),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.home),
              title: const Text('Home'),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.account_circle_rounded),
              title: const Text('Profile'),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.favorite),
              title: const Text('Favourites'),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
            ),
            const Spacer(),
            const DefaultTextStyle(
              style: TextStyle(fontSize: 12, color: Colors.white54),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text('Terms of Service | Privacy Policy'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
