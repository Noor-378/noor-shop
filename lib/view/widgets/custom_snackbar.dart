import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noor_store/view/widgets/custom_text.dart';

// class CustomSnackbar extends StatelessWidget {
//   const CustomSnackbar({
//     super.key,
//     required this.title,
//     required this.messageText,
//   });
//   final String title;
//   final String messageText;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.black.withOpacity(0.5),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           CustomText(
//             text: title,
//             color: Colors.white,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//           SizedBox(height: 4),
//           CustomText(
//             text: messageText,
//             color: Colors.white70,
//             fontSize: 16,
//             fontWeight: FontWeight.normal,
//           ),
//         ],
//       ),
//     );
//   }
// }
void customGetSnackbar({
  required String title,
  required String messageText,
}) {
  Get.showSnackbar(
    GetSnackBar(
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.transparent,
      borderRadius: 12,
      margin: const EdgeInsets.all(10),
      padding: EdgeInsets.zero,
      messageText: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 4),
                CustomText(
                  text: messageText,
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
