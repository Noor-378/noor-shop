import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    this.height = 1,
    this.color = Colors.grey,
    this.width = double.infinity,
  });
  final double height;
  final Color color;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(height: height, width: width, color: color);
  }
}
