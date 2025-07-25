import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    required this.text,
    this.fontWeight = FontWeight.bold,
    this.fontSize = 35,
    this.color = Colors.white,
    this.textAlign = TextAlign.left,
    this.maxLines,
    this.overflow,
    super.key,
  });
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
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
