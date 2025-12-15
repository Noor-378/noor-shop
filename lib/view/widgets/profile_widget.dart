import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noor_store/logic/controllers/auth_controller.dart';
import 'package:noor_store/logic/controllers/settings_controller.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/view/widgets/custom_text.dart';

class ProfileWidget extends StatelessWidget {
  ProfileWidget({Key? key}) : super(key: key);

  final controller = Get.find<SettingsController>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [mainColor.withOpacity(0.3), mainColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: mainColor.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(authController.displayUserImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                text: controller.capitalize(authController.displayUserName),
                color: Colors.black87,
              ),
              const SizedBox(height: 5),
              CustomText(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                text: authController.displayUserEmail,
                color: Colors.grey.shade600,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
