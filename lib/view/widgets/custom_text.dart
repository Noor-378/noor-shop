import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    required this.text,
    this.fontWeight = FontWeight.bold,
    this.fontSize = 35,
    this.color = Colors.white,
    this.textAlign = TextAlign.left,
    super.key,
  });
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.lato(
        textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color, //
        ),
      ),
    );
  }
}
