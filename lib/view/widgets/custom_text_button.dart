import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = Colors.blue,
    this.decoration = TextDecoration.none,
    this.fontSize,
  });
  final Function() onPressed;
  final String text;
  final Color color;
  final TextDecoration? decoration;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(color),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50), //
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(decoration: decoration, fontSize: fontSize),
      ),
    );
  }
}
