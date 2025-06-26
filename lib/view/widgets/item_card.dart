import 'package:flutter/material.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/view/widgets/custom_add_to_cart_button.dart';
import 'package:noor_store/view/widgets/custom_favorite_button.dart';
import 'package:noor_store/view/widgets/custom_snackbar.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.height});
  final double height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Container(
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
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
              ],
            ),
          ),
        ),
        Container(
          height: 50,
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
