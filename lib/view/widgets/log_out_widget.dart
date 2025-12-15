import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noor_store/logic/controllers/auth_controller.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/view/widgets/animated_dialog.dart';
import 'package:noor_store/view/widgets/custom_text.dart';

class LogOutWidget extends StatelessWidget {
  const LogOutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder:
          (controller) => Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Get.dialog(
                    AnimatedDialog(
                      title: "Confirm Logout",
                      content: const Text(
                        "Are you sure you want to logout?",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      onCancelText: "Cancel",
                      onConfirmText: "Logout",
                      onConfirm: () async {
                        controller.signOutFromApp();
                      },
                      onConfirmTextStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      onCancelTextTextStyle: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    barrierDismissible: true,
                  );
                },
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: logOutSettings.withOpacity(0.15),
                        ),
                        child: const Icon(
                          Icons.logout,
                          color: logOutSettings,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 15),
                      CustomText(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        text: "Logout".tr,
                        color: Colors.black87,
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey.shade400,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
    );
  }
}
