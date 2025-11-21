import 'package:animate_do/animate_do.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:noor_store/logic/controllers/product_controller.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/view/widgets/custom_text.dart';
import 'package:noor_store/view/widgets/list_item_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(text: "Your Favorites", fontSize: 18, color: blackColor),
            const SizedBox(height: 5),
            CustomText(
              text: "All the products you’ve saved",
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: blackColor,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.favoritesList.length,
              itemBuilder: (context, index) {
                int productId = controller.favoritesList[index].id ?? 0;
                return FadeInLeftBig(
                  from: index == 0 ? 25 : index * 50,
                  child: ListItemCard(
                    addToCartOnTap: (p0) async {
                      return !p0;
                    },
                    addToFavOnTap: (p0) async {
                      controller.manageFavorites(productId);
                      return !p0;
                    },
                    product: controller.favoritesList[index],
                    isLiked: controller.isFavorites(productId),
                  ),
                );
              },
            ),
          ],
        ),
      );
    });
  }
}
