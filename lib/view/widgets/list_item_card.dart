import 'package:flutter/material.dart';
import 'package:noor_store/model/product_model.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/view/widgets/custom_add_to_cart_button.dart';
import 'package:noor_store/view/widgets/custom_favorite_button.dart';
import 'package:noor_store/view/widgets/custom_snackbar.dart';
import 'package:noor_store/view/widgets/custom_star.dart';
import 'package:noor_store/view/widgets/custom_text.dart';

class ListItemCard extends StatelessWidget {
  final ProductModel product;
  const ListItemCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Container(
          height: 130,
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(.03),
                blurRadius: 8,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Image.network(
                product.image ?? '',
                height: 100,
                width: 100,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: CustomText(
                            text: product.title ?? '',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: blackColor,
                          ),
                        ),
                        const SizedBox(width: 50),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SingleStarRating(
                              rate: product.rating?.rate ?? 0,
                              size: 25,
                            ),
                            const SizedBox(width: 5),
                            CustomText(
                              text: product.rating?.rate.toString() ?? "0.0",
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: blackColor,
                            ),
                          ],
                        ),
                        CustomText(
                          text: "\$${product.price}",
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: blackColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Favorite button top-left
        Positioned(
          top: 15,
          left: 5,
          child: CustomFavoriteButton(
            onTap: (bool isLiked) async {
              isLiked
                  ? customGetSnackbar(
                    title: "Removed",
                    messageText: "Removed from favorites",
                  )
                  : customGetSnackbar(
                    title: "Added",
                    messageText: "Added to favorites",
                  );
              return !isLiked;
            },
          ),
        ),

        Positioned(
          top: 5,
          right: 0,
          child: Container(
            height: 40,
            width: 50,
            decoration: BoxDecoration(
              color: contentColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
              ),
            ),
            child: CustomAddToCartButton(
              onTap: (bool isLiked) async {
                isLiked
                    ? customGetSnackbar(
                      title: "Removed",
                      messageText: "Removed from cart",
                    )
                    : customGetSnackbar(
                      title: "Added",
                      messageText: "Added to cart",
                    );
                return !isLiked;
              },
            ),
          ),
        ),
      ],
    );
  }
}
