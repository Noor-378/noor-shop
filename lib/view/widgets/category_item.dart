import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:noor_store/logic/controllers/cart_controller.dart';
import 'package:noor_store/logic/controllers/category_controller.dart';
import 'package:noor_store/logic/controllers/product_controller.dart';
import 'package:noor_store/model/product_model.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/view/screens/product_details_screen.dart';
import 'package:noor_store/view/widgets/custom_text.dart';
import 'package:noor_store/view/widgets/item_card.dart';

class CategoryItems extends StatelessWidget {
  final String catehoryTitle;
  CategoryItems({required this.catehoryTitle, super.key});

  final controller = Get.find<ProductController>();

  final cartController = Get.find<CartController>();

  final categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: contentColor,
      appBar: AppBar(
        title: Text(catehoryTitle),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: Obx(() {
        if (categoryController.isAllCategory.value) {
          return Center(child: CircularProgressIndicator(color: mainColor));
        } else {
          return MasonryGridView.builder(
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,

            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: 20),
            itemCount: categoryController.categoryList.length,
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              Random random = Random();
              final height = 250 + random.nextInt(100);
              final product = categoryController.categoryList[index];

              return ItemCard(
                rate: product.rating?.rate,
                height: height.toDouble(),
                image: product.image ?? "",
                title: product.title ?? "",
                price: product.price?.toString() ?? "",
                isLiked: controller.isFavorites(product.id ?? 0),
                addToChartOnTap: (p0) async {
                  cartController.addProductToCart(product);
                  return !p0;
                },
                addToFavOnTap: (p0) async {
                  controller.manageFavorites(product.id ?? 0);
                  return !p0;
                },
                isLikedForCart: cartController.isInCart(product),
                onTap: () {
                  Get.to(() => ProductDetailsScreen(productModel: product));
                },
                heroTag: 'product_${product.id}',
              );
            },
          );
        }
      }),
    );
  }

  Widget buildCardItems({
    required String image,
    required double price,
    required double rate,
    required int productId,
    required ProductModel productModel,
    required Function() onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3.0,
                blurRadius: 5.0,
              ),
            ],
          ),
          child: Column(
            children: [
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        controller.manageFavorites(productId);
                      },
                      icon:
                          controller.isFavorites(productId)
                              ? const Icon(Icons.favorite, color: Colors.red)
                              : const Icon(
                                Icons.favorite_outline,
                                color: Colors.black,
                              ),
                    ),
                    IconButton(
                      onPressed: () {
                        cartController.addProductToCart(productModel);
                      },
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.network(image, fit: BoxFit.fitHeight),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$ $price",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: 20,
                      width: 45,
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 3, right: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              text: "$rate",
                              color: Colors.white,
                            ),
                            const Icon(
                              Icons.star,
                              size: 13,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
