import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noor_store/routes/routes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(),
      body: Column(
        children: [
          IconButton(
            onPressed: () {
              // Toggle to the opposite mode
            },
            icon: Icon(
              Get.isDarkMode
                  ? Icons
                      .wb_sunny_outlined // Show sun when in dark mode
                  : Icons.dark_mode_outlined, // Show moon when in light mode
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Get.toNamed(Routes.welcomeScreen);
            },
            label: const Text("data"),
          ),
        ],
      ),
    );
  }
}
