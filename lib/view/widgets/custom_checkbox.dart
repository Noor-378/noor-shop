import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noor_store/utils/colors.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({
    super.key,
    required this.onChanged,
    required this.value,
  });
  final void Function(bool?)? onChanged;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor:
          Get.isDarkMode
              ? LightAppColors.secondColor
              : LightAppColors.mainColor,
      onChanged: onChanged,
      value: value,
      side: BorderSide(color: LightAppColors.textBodyColor, width: 1.5),
    );
  }
}
