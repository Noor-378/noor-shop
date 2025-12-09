import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noor_store/logic/controllers/main_controller.dart';
import 'package:noor_store/logic/controllers/product_controller.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/view/widgets/custom_text.dart';
import 'package:noor_store/view/widgets/list_item_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();
    final mainController = Get.find<MainController>();

    return Obx(() {
      final bool isEmpty = controller.favoritesList.isEmpty;

      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              CustomText(
                text: "Your Favorites",
                fontSize: 18,
                color: blackColor,
              ),
              const SizedBox(height: 5),
              CustomText(
                text:
                    isEmpty
                        ? "Start saving products you love"
                        : "All the products you've saved",
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: textBodyColor,
              ),
              const SizedBox(height: 40),

              // Empty State or Favorites List
              isEmpty
                  ? _buildEmptyState(context, mainController)
                  : _buildFavoritesList(controller),
            ],
          ),
        ),
      );
    });
  }

  // Empty State Widget
  Widget _buildEmptyState(BuildContext context, MainController mainController) {
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Empty Favorites Icon/Illustration
              FadeInDown(
                duration: const Duration(milliseconds: 800),
                child: Container(
                  height: 180,
                  width: 180,
                  decoration: BoxDecoration(
                    color: contentColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: mainColor.withOpacity(0.15),
                        offset: const Offset(0, 10),
                        blurRadius: 20,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.favorite_border_rounded,
                    size: 100,
                    color: mainColor.withOpacity(0.5),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Empty State Text
              FadeIn(
                delay: const Duration(milliseconds: 200),
                child: CustomText(
                  text: "No Favorites Yet",
                  fontSize: 22,
                  color: blackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              FadeIn(
                delay: const Duration(milliseconds: 300),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: CustomText(
                    text:
                        "Save your favorite products and find them here anytime",
                    fontSize: 15,
                    color: textBodyColor,
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              FadeIn(
                delay: const Duration(milliseconds: 400),
                child: ElevatedButton(
                  onPressed: () {
                    Future.delayed(const Duration(milliseconds: 100), () {
                      mainController.changeIndex(0);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    foregroundColor: whiteColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 2,
                    shadowColor: mainColor.withOpacity(0.3),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.explore_outlined, size: 20),
                      const SizedBox(width: 10),
                      CustomText(
                        text: "Explore Products",
                        fontSize: 16,
                        color: whiteColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Favorites List
  Widget _buildFavoritesList(ProductController controller) {
    return ListView.builder(
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
    );
  }
}
