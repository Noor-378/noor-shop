import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SettingsController extends GetxController {
  var themeMode = ThemeMode.light.obs;

  void toggleTheme(bool isDark) {
    themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;
    Get.changeThemeMode(themeMode.value); // this helps too
  }
}