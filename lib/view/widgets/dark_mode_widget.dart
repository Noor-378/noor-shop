import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noor_store/logic/controllers/settings_controller.dart';
import 'package:noor_store/logic/controllers/theme_controller.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/view/widgets/custom_text.dart';

class DarkModeWidget extends StatelessWidget {
  DarkModeWidget({super.key});

  final controller = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: darkSettings.withOpacity(0.15),
                ),
                child: Icon(
                  controller.swithchValue.value
                      ? Icons.dark_mode
                      : Icons.light_mode,
                  color: darkSettings,
                  size: 24,
                ),
              ),
              const SizedBox(width: 15),
              CustomText(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                text: "Dark Mode".tr,
                color: Colors.black87,
              ),
            ],
          ),
          Transform.scale(
            scale: 0.9,
            child: Switch(
              activeTrackColor: mainColor.withOpacity(0.5),
              activeColor: mainColor,
              inactiveThumbColor: Colors.grey.shade400,
              inactiveTrackColor: Colors.grey.shade300,
              value: controller.swithchValue.value,
              onChanged: (value) {
                ThemeController().changesTheme();
                controller.swithchValue.value = value;
              },
            ),
          ),
        ],
      ),
    );
  }
}
