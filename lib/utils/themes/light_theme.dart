import 'package:flutter/material.dart';
import 'package:noor_store/utils/colors.dart';

class LightTheme {
  static final light = ThemeData(
    useMaterial3: false,
    primaryColor: mainColor,
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
  );
}
