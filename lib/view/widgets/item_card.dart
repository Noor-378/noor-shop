import 'package:flutter/material.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/view/widgets/custom_add_to_cart_button.dart';
import 'package:noor_store/view/widgets/custom_favorite_button.dart';
import 'package:noor_store/view/widgets/custom_snackbar.dart';
import 'package:noor_store/view/widgets/custom_text.dart';

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
                const SizedBox(height: 18),
                ClipRRect(
                  borderRadius: BorderRadius.circular(19),
                  child: Image.network(
                    fit: BoxFit.cover,
                    height: height - 100,
                    "https://images.unsplash.com/photo-1654649451086-dd75d8170a27?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDF8Q0R3dXdYSkFiRXd8fGVufDB8fHx8fA%3D%3D",
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    CustomText(
                      // ideia* to make it like gample :)
                      // if the user press on the price, become lower
                      text: "\$ 15",
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
