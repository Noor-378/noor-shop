import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:noor_store/logic/controllers/main_controller.dart';
import 'package:noor_store/logic/controllers/settings_controller.dart';
import 'package:noor_store/routes/routes.dart';
import 'package:noor_store/utils/colors.dart';

class DrawerContent extends StatelessWidget {
  DrawerContent({super.key, required this.advancedDrawer});

  final AdvancedDrawerController advancedDrawer;
  final settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find<MainController>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),

            Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.3),
                            Colors.white.withOpacity(0.1),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.grey.shade300,
                          backgroundImage: NetworkImage(
                            settingsController.userImage,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Welcome !",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      settingsController.userName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                children: [
                  _DrawerItem(
                    title: 'Home',
                    icon: "assets/images/home.png",
                    onTap: () {
                      advancedDrawer.hideDrawer();
                      if (mainController.currentIndex != 0) {
                        mainController.changeIndex(0);
                      }
                    },
                  ),
                  _DrawerItem(
                    title: 'Favourites',
                    icon: "assets/images/heart.png",
                    onTap: () {
                      advancedDrawer.hideDrawer();
                      Future.delayed(const Duration(milliseconds: 300), () {
                        if (mainController.currentIndex != 2) {
                          mainController.changeIndex(2);
                        }
                      });
                    },
                  ),
                  _DrawerItem(
                    title: 'Settings',
                    icon: "assets/images/settings.png",
                    onTap: () {
                      advancedDrawer.hideDrawer();
                      Get.toNamed(Routes.settingsScreen);
                    },
                  ),
                ],
              ),
            ),

            Container(
              height: 1,
              margin: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.001),
                    Colors.white.withOpacity(0.3),
                    Colors.white.withOpacity(0.001),
                  ],
                ),
              ),
            ),

            // Terms & Privacy
            _DrawerItem(
              title: 'Terms of Service | Privacy Policy',
              icon: "assets/images/info.png",
              small: true,
              onTap: () {
                advancedDrawer.hideDrawer();
                Get.toNamed(Routes.termsScreen);
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;
  final bool small;

  const _DrawerItem({
    required this.title,
    required this.icon,
    required this.onTap,
    this.small = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          splashColor: Colors.white.withOpacity(0.1),
          highlightColor: Colors.white.withOpacity(0.05),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withOpacity(0.15),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(
                    icon,
                    width: 20,
                    height: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: small ? 13 : 16,
                      fontWeight: small ? FontWeight.w500 : FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Colors.white.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
