import 'package:flutter/material.dart';

class ColorPicker extends StatelessWidget {
  final bool outerBorder;
  final Color color;

  const ColorPicker({
    required this.color,
    required this.outerBorder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      width: outerBorder ? 30 : 26,
      height: outerBorder ? 30 : 26,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: outerBorder ? Colors.white : Colors.white.withOpacity(0.6),
          width: outerBorder ? 3 : 1.2,
        ),
      ),
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: outerBorder ? 22 : 20,
          height: outerBorder ? 22 : 20,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      ),
    );
  }
}
