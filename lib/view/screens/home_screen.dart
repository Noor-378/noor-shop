import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/view/widgets/custom_favorite_button.dart';
import 'package:noor_store/view/widgets/custom_text.dart';
import 'package:noor_store/view/widgets/custom_text_button.dart';
import 'package:noor_store/view/widgets/item_card.dart';
import 'dart:math';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            CustomText(text: "Trending Now", fontSize: 18, color: blackColor),
            CustomText(
              text: "Top Products Everyone’s Loving",
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: blackColor,
            ),
            const CustomGrid(),
            SizedBox(height: 50),

            CustomFavoriteButton(
              onTap: (isLike) async {
                return !isLike;
              },
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class CustomGrid extends StatelessWidget {
  const CustomGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final random = Random();
    return MasonryGridView.builder(
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      itemCount: 10,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final height = 200 + random.nextInt(150);

        return FadeInUpBig(
          from: height.toDouble(),
          child: ItemCard(height: height.toDouble()),
        );
      },
    );
  }
}
// GridView.builder(
//       physics:
//           const NeverScrollableScrollPhysics(), // 🧠 disables inner scrolling
//       shrinkWrap:
//           true, // 🧠 allows GridView to take only as much height as needed
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        
//         crossAxisCount:
//             2, // 🟩 Number of items per row (2 items horizontally)
//         crossAxisSpacing:
//             10, // 🟨 Horizontal space between columns (10 pixels)
//         mainAxisSpacing: 20, // 🟦 Vertical space between rows (20 pixels)
//         childAspectRatio:
//             2.9 /
//             4, // 🟥 Width / Height ratio of each item (makes items taller than wide)
//       ),
//       itemCount: 10,
//       itemBuilder:
//           (context, index) => const ItemCard(),
//     );

// GridView.builder(
//       physics:
//           const NeverScrollableScrollPhysics(), // 🧠 disables inner scrolling
//       shrinkWrap:
//           true, // 🧠 allows GridView to take only as much height as needed

//       gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//         maxCrossAxisExtent: 200, // width of each tile
//         crossAxisSpacing: 10,
//         mainAxisSpacing: 20,
//       ),
//       itemCount: 10,
//       itemBuilder:
//           (context, index) => ItemCard(height: index.isEven ? 100 : 150),
//     );