import 'package:flutter/material.dart';
import 'package:noor_store/view/widgets/category_widget.dart';
import 'package:noor_store/view/widgets/custom_text.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: "Categories",
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          const SizedBox(height: 6),
          Text(
            "Browse products by category",
            style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
          ),
          const SizedBox(height: 25),
          CategoryWidget(),
        ],
      ),
    );
  }
}
