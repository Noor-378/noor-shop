import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/view/widgets/custom_text.dart';
import 'package:noor_store/view/widgets/dark_mode_widget.dart';
import 'package:noor_store/view/widgets/language_widget.dart';
import 'package:noor_store/view/widgets/log_out_widget.dart';
import 'package:noor_store/view/widgets/profile_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: contentColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: FadeInDown(
              duration: const Duration(milliseconds: 500),
              child: CustomText(
                text: "SETTINGS".tr,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: mainColor,
              ),
            ),
            leading: FadeInLeft(
              duration: const Duration(milliseconds: 500),
              child: Container(
                margin: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
                decoration: BoxDecoration(
                  color: mainColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                  color: mainColor,
                  onPressed: () => Get.back(),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              child: Container(
                padding: const EdgeInsets.all(20),
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
                child: ProfileWidget(),
              ),
            ),

            const SizedBox(height: 30),

            FadeInUp(
              duration: const Duration(milliseconds: 700),
              child: Padding(
                padding: const EdgeInsets.only(left: 5, bottom: 15),
                child: CustomText(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  text: "GENERAL".tr,
                  color: Colors.grey.shade600,
                ),
              ),
            ),

            FadeInUp(
              duration: const Duration(milliseconds: 800),
              child: Container(
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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      child: DarkModeWidget(),
                    ),
                    Divider(
                      color: Colors.grey.shade200,
                      thickness: 1,
                      height: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      child: LanguageWidget(),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            FadeInUp(
              duration: const Duration(milliseconds: 900),
              child: Padding(
                padding: const EdgeInsets.only(left: 5, bottom: 15),
                child: CustomText(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  text: "ACCOUNT".tr,
                  color: Colors.grey.shade600,
                ),
              ),
            ),

            FadeInUp(
              duration: const Duration(milliseconds: 1000),
              child: const LogOutWidget(),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
