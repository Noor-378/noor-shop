import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:noor_store/routes/routes.dart';
import 'package:noor_store/utils/colors.dart';

class DrawerContent extends StatelessWidget {
  const DrawerContent({super.key, required this.advancedDrawer});
  final AdvancedDrawerController advancedDrawer;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListTileTheme(
        textColor: Colors.white,
        iconColor: Colors.white,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 24.0, bottom: 50),
              child: const CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 50,
              ),
            ),
            ListTile(
              onTap: () => advancedDrawer.hideDrawer(),

              leading: Image.asset("assets/images/home.png", color: whiteColor),
              title: const Text('Home'),
            ),
            ListTile(
              onTap: () {},
              leading: Image.asset(
                "assets/images/profile.png",
                color: whiteColor,
              ),
              title: const Text('Profile'),
            ),
            ListTile(
              onTap: () {},
              leading: Image.asset(
                "assets/images/heart.png",
                color: whiteColor,
              ),
              title: const Text('Favourites'),
            ),
            ListTile(
              onTap: () {
                Get.toNamed(Routes.settingsScreen);
              },
              leading: Image.asset(
                "assets/images/settings.png",
                color: whiteColor,
              ),
              title: const Text('Settings'),
            ),
            const Spacer(),
            ListTile(
              onTap: () {
                Get.toNamed(Routes.termsScreen);
              },
              leading: Image.asset("assets/images/info.png", color: whiteColor),
              title: const DefaultTextStyle(
                style: TextStyle(fontSize: 12, color: Colors.white54),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text('Terms of Service | Privacy Policy'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
