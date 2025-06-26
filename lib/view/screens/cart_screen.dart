import 'package:flutter/material.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/view/widgets/custom_text.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          CustomText(text: "Just for You", fontSize: 18, color: blackColor),
          CustomText(
            text: "Exclusive Deals Handpicked for You",
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: blackColor,
          ),
          GridView.builder(
            physics:
                const NeverScrollableScrollPhysics(), // 🧠 disables inner scrolling
            shrinkWrap:
                true, // 🧠 allows GridView to take only as much height as needed
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  2, // 🟩 Number of items per row (2 items horizontally)
              crossAxisSpacing:
                  10, // 🟨 Horizontal space between columns (10 pixels)
              mainAxisSpacing: 20, // 🟦 Vertical space between rows (20 pixels)
              childAspectRatio:
                  2.9 /
                  4, // 🟥 Width / Height ratio of each item (makes items taller than wide)
            ),
            itemCount: 10,
            itemBuilder:
                (context, index) => Material(
                  elevation: 6,
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      // shape: BoxShape.circle,
                    ),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
