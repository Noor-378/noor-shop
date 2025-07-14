import 'package:flutter/material.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/view/widgets/custom_add_to_cart_button.dart';
import 'package:noor_store/view/widgets/custom_favorite_button.dart';
import 'package:noor_store/view/widgets/custom_snackbar.dart';
import 'package:noor_store/view/widgets/custom_star.dart';
import 'package:noor_store/view/widgets/custom_text.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.height,
    required this.image,
    required this.price,
    this.rate,
  });
  final double height;
  final String image;
  final String price;
  final double? rate;

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
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(.02),
                offset: const Offset(0, 10), // Pushes it straight down
                blurRadius: 8, // Smooth shadow
                spreadRadius: 0, // No sideways growth
              ),
            ],
            // shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomAddToCartButton(
                      onTap: (bool isLiked) async {
                        isLiked
                            ? customGetSnackbar(
                              title: "false",
                              messageText: "false",
                            )
                            : customGetSnackbar(
                              title: "true",
                              messageText: "true",
                            );
                        // You can add your logic here (API call, GetX update, etc.)
                        return !isLiked;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                ClipRRect(
                  borderRadius: BorderRadius.circular(19),
                  child: Image.network(
                    fit: BoxFit.contain,
                    height: height - 100,
                    image,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SingleStarRating(
                          rate: rate ?? 0,
                          size: 30,
                          max: 5,
                        ), // fill is 50%
                        const SizedBox(width: 8),
                        CustomText(
                          text: rate.toString(),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: blackColor,
                        ),
                      ],
                    ),

                    CustomText(
                      // ideia* to make it like gample :)
                      // if the user press on the price, become lower
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
        Container(
          height: 40,
          width: 50,
          decoration: BoxDecoration(
            color: contentColor,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(15),
            ),
          ),
          child: CustomFavoriteButton(
            onTap: (bool isLiked) async {
              isLiked
                  ? customGetSnackbar(title: "false", messageText: "false")
                  : customGetSnackbar(title: "true", messageText: "true");
              return !isLiked;
            },
          ),
        ),
      ],
    );
  }
}
