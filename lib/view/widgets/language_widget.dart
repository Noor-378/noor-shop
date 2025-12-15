import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noor_store/logic/controllers/settings_controller.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/utils/my_string.dart';
import 'package:noor_store/view/widgets/custom_text.dart';

class LanguageWidget extends StatelessWidget {
  LanguageWidget({super.key});

  final controller = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      builder:
          (_) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: languageSettings.withOpacity(0.15),
                    ),
                    child: const Icon(
                      Icons.language,
                      color: languageSettings,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 15),
                  CustomText(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    text: "Language".tr,
                    color: Colors.black87,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade100,
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    iconSize: 24,
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.grey.shade700,
                    ),
                    items: [
                      DropdownMenuItem(
                        value: ene,
                        child: Text(
                          english,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: ara,
                        child: Text(
                          arabic,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: frf,
                        child: Text(
                          france,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                    value: controller.langLocal,
                    onChanged: (value) {
                      controller.changeLanguage(value!);
                      Get.updateLocale(Locale(value));
                    },
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
