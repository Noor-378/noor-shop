import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noor_store/utils/colors.dart';

class AnimatedCustomText extends StatelessWidget {
  const AnimatedCustomText({
    super.key,
    required this.text,
    this.fontSize = 25,
    this.fontWeight = FontWeight.bold,
    this.onTap ,
  });
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      repeatForever: true,

      animatedTexts: [
        ColorizeAnimatedText(
          text,
          colors: [LightAppColors.mainColor, LightAppColors.secondColor],
          speed: const Duration(milliseconds: 500),
          textStyle: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight, //
            ),
          ),
        ),
      ],
      isRepeatingAnimation: true,
      onTap: onTap,
    );
  }
}
