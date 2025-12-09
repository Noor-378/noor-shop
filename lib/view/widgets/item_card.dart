import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noor_store/logic/controllers/cart_controller.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/view/widgets/custom_add_to_cart_button.dart';
import 'package:noor_store/view/widgets/custom_favorite_button.dart';
import 'package:noor_store/view/widgets/custom_snackbar.dart';
import 'package:noor_store/view/widgets/custom_star.dart';
import 'package:noor_store/view/widgets/custom_text.dart';
import 'package:redacted/redacted.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.height,
    required this.image,
    required this.title,
    required this.price,
    required this.isLiked,
    required this.addToChartOnTap,
    required this.addToFavOnTap,
    required this.isLikedForCart,
    this.rate,
  });

  final double height;
  final String image;
  final String title;
  final String price;
  final double? rate;
  final bool isLiked;
  final bool isLikedForCart;
  final Future<bool?> Function(bool)? addToChartOnTap;
  final Future<bool?> Function(bool)? addToFavOnTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Container(
          height: height,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.02),
                offset: const Offset(0, 10),
                blurRadius: 8,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top content: AddToCart + Image + Title
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GetBuilder<CartController>(
                            builder:
                                (controller) => CustomAddToCartButton(
                                  isLiked: isLikedForCart,
                                  onTap: addToChartOnTap,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Flexible(
                        flex: 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            image,
                            fit: BoxFit.contain,
                            width: double.infinity,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.amber,
                                ),
                              ).redacted(context: context, redact: true);
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey.shade200,
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.broken_image,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Flexible(
                        child: CustomText(
                          text: title,
                          fontSize: 14,
                          color: blackColor,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),

                // Bottom row: Rating + Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SingleStarRating(rate: rate ?? 0, size: 30, max: 5),
                        const SizedBox(width: 5),
                        CustomText(
                          text: rate?.toString() ?? "0",
                          fontSize: 12,
                          color: blackColor,
                          fontWeight: FontWeight.w800,
                        ),
                      ],
                    ),
                    CustomText(
                      text: price,
                      fontSize: 12,
                      color: blackColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Favorite button
        Container(
          height: 40,
          width: 50,
          decoration: BoxDecoration(
            color: contentColor,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(15),
            ),
          ),
          child: CustomFavoriteButton(isLiked: isLiked, onTap: addToFavOnTap),
        ),
      ],
    );
  }
}
