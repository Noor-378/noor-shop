
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noor_store/routes/routes.dart';

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
            const ListTile(
              onTap: null,
              leading: Icon(Icons.favorite),
              title: Text('Favourites'),
            ),
            ListTile(
              onTap: () {
                Get.toNamed(Routes.settingsScreen);
              },
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