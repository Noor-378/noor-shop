import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  final Rx<ThemeMode> themeMode = ThemeMode.light.obs;

  void toggleTheme() {
    themeMode.value =
        themeMode.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;

    Get.changeThemeMode(
      themeMode.value,
    ); 
  }

}
