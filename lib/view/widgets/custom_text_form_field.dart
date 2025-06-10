import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noor_store/utils/colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.autofocus = false,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.textInputAction = TextInputAction.next,
    this.onChanged,
    this.fillColor = Colors.white,
    this.prefixIcon,
    this.labelText,
    this.suffixIcon,
    this.hintText,
    this.filled = false,
    this.onFieldSubmitted,
  });
  final TextEditingController controller;
  final bool filled;
  final bool autofocus;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final Color fillColor;
  final Widget? prefixIcon;
  final String? labelText;
  final Widget? suffixIcon;
  final String? hintText;
  final void Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      textInputAction: textInputAction,
      autofocus: autofocus,
      validator: validator,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Get.isDarkMode ? Colors.white60 : null),
        prefixIcon: prefixIcon,
        fillColor: fillColor,
        labelStyle: TextStyle(color: Get.isDarkMode ? Colors.white60 : null),
        floatingLabelStyle: TextStyle(
          color: Get.isDarkMode ? LightAppColors.secondColor : null,
        ),
        labelText: labelText,
        suffixIcon: suffixIcon,
        filled: filled,
        hintText: hintText,

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
