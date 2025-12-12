import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noor_store/logic/controllers/product_controller.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/view/widgets/custom_favorite_button.dart';
import 'package:noor_store/view/widgets/custom_star.dart';
import 'package:noor_store/view/widgets/custom_text.dart';
import 'package:readmore/readmore.dart';

class ClothesInfo extends StatelessWidget {
  final String title;
  final int productId;
  final double rate;
  final String description;

  ClothesInfo({
    required this.title,
    required this.productId,
    required this.rate,
    required this.description,
    super.key,
  });

  final controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TITLE + FAVORITE BUTTON
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),

              Obx(() {
                final isFav = controller.isFavorites(productId);

                return InkWell(
                  onTap: () => controller.manageFavorites(productId),
                  child: CustomFavoriteButton(
                    onTap: (p0) async {
                      controller.manageFavorites(productId);
                      return !p0;
                    },
                    isLiked: isFav,
                  ),
                );
              }),
            ],
          ),

          const SizedBox(height: 10),

          /// RATING SECTION
          Row(
            children: [
              CustomText(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                text: rate.toString(),
                color: Colors.black,
              ),
              const SizedBox(width: 8),
              SingleStarRating(rate: rate, size: 30, max: 5),
            ],
          ),

          const SizedBox(height: 20),

          /// DESCRIPTION WITH READ MORE
          ReadMoreText(
            description,
            trimLines: 3,
            textAlign: TextAlign.justify,
            trimMode: TrimMode.Line,
            trimCollapsedText: " Show More ",
            trimExpandedText: " Show Less ",
            lessStyle: TextStyle(fontWeight: FontWeight.bold, color: mainColor),
            moreStyle: TextStyle(fontWeight: FontWeight.bold, color: mainColor),
            style: TextStyle(
              fontSize: 16,
              height: 2,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
