import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noor_store/logic/controllers/cart_controller.dart';
import 'package:noor_store/logic/controllers/product_controller.dart';
import 'package:noor_store/view/widgets/list_item_card.dart';

class CartListOfCard extends StatelessWidget {
  const CartListOfCard({super.key, required this.controller});
  final ProductController controller;
  @override
  Widget build(BuildContext context) {
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
