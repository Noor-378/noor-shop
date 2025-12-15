import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noor_store/logic/controllers/auth_controller.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/view/screens/settings_screen.dart';
import 'package:noor_store/view/widgets/custom_text.dart';

class LogOutWidget extends StatelessWidget {
  const LogOutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder:
          (controller) => Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                    Get.dialog(
                      AnimatedDialog(
                        title: "Confirm Logout",
                        content: const Text(
                          "Are you sure you want to logout?",
                          textAlign: TextAlign.center,
                        ),
                        onCancelText: "Cancel",
                        onConfirmText: "Logout",
                        onConfirm: () async {
                          controller.signOutFromApp();
                        },
                        onConfirmTextStyle: TextStyle(
                          color: mainColor,
                          fontWeight: FontWeight.bold,
                        ),
                        onCancelTextTextStyle: TextStyle(
                          color: scaffoldDarkColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      barrierDismissible: true,
                    );
                
              },
              splashColor: Get.isDarkMode ? Colors.pink : Colors.green[100],
              borderRadius: BorderRadius.circular(12),
              customBorder: const StadiumBorder(),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: logOutSettings,
                    ),
                    child: const Icon(Icons.logout, color: Colors.white),
                  ),
                  const SizedBox(width: 20),
                  CustomText(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    text: "Logout".tr,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
