import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noor_store/utils/colors.dart';

class CustomSocialAuthButton extends StatelessWidget {
  const CustomSocialAuthButton({
    super.key,
    required this.image,
    required this.onPressed,
    this.height = 40,
    this.width = 40,
    this.fit = BoxFit.cover,
  });
  final String image;
  final Function() onPressed;
  final double height;
  final double width;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        side: BorderSide(
          color:
              Get.isDarkMode
                  ? LightAppColors.secondColor
                  : Colors.grey.shade300,
        ),
        overlayColor: LightAppColors.mainColor,
        fixedSize: const Size(70, 40),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor:
            Get.isDarkMode
                ? LightAppColors.secondColor.withAlpha(100)
                : Colors.white,

        elevation: 15,
      ),
      onPressed: onPressed,
      child: Image.asset(image, height: height, width: width, fit: fit),
    );
  }
}
