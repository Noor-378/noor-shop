import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:noor_store/logic/controllers/cart_controller.dart';
import 'package:noor_store/logic/controllers/product_controller.dart';
import 'package:noor_store/model/product_model.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/view/screens/product_details_screen.dart';
import 'package:noor_store/view/widgets/custom_text.dart';
import 'package:noor_store/view/widgets/item_card.dart';
import 'package:noor_store/view/widgets/list_item_card.dart';
import 'dart:math';
import 'package:redacted/redacted.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final controller = Get.find<ProductController>();
  Random randomNumber = Random();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const ShoeWidget().redacted(context: context, redact: true);
      } else {
        return FadeInUp(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        CustomText(
                          text: "Trending Now",
                          fontSize: 18,
                          color: blackColor,
                        ),
                        const SizedBox(height: 5),
                        CustomText(
                          text: "Top Products Everyone’s Loving",
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: blackColor,
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Obx(() {
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, animation) {
                            return ScaleTransition(
                              scale: animation,
                              child: FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                            );
                          },
                          child: Image.asset(
                            controller.isGridView.value
                                ? "assets/images/list.png"
                                : "assets/images/grid.png",
                            key: ValueKey(
                              controller.isGridView.value ? 'grid' : 'list',
                            ),
                          ),
                        );
                      }),
                      onPressed: () => controller.toggleGrid(),
                    ),
                  ],
                ),
                Obx(() {
                  final products =
                      controller.searchList.isNotEmpty
                          ? controller.searchList
                          : controller.productModel;

                  return controller.isGridView.value
                      ? CustomGrid(
                        controller: controller,
                        products: products,
                        randomNumber: randomNumber,
                      )
                      : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          final productId = product.id ?? 0;

                          return FadeInLeftBig(
                            from: index == 0 ? 25 : index * 50,
                            child: ListItemCard(
                              addToCartOnTap: (p0) async {
                                return false;
                              },
                              addToFavOnTap: (p0) async {
                                controller.manageFavorites(productId);
                                return !p0;
                              },
                              isLiked: controller.isFavorites(productId),
                              product: product,
                            ),
                          );
                        },
                      );
                }),
              ],
            ),
          ),
        );
      }
    });
  }
}

class CustomGrid extends StatelessWidget {
  const CustomGrid({
    super.key,
    required this.controller,
    required this.products,
    required this.randomNumber,
    this.padding,
    this.physics = const NeverScrollableScrollPhysics(),
  });

  final ProductController controller;
  final List<ProductModel> products;
  final Random randomNumber;
  final ScrollPhysics physics;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();
    final random = randomNumber;

    return MasonryGridView.builder(
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      itemCount: products.length,
      padding: padding,
      shrinkWrap: true,
      physics: physics,
      itemBuilder: (context, index) {
        final con = products[index];
        final height = 200 + random.nextInt(150);
        final productId = con.id ?? 0;

        return FadeInUpBig(
          from: height.toDouble(),
          child: GetBuilder<CartController>(
            builder: (cartcart) {
              return Obx(
                () => ItemCard(
                  heroTag: 'product_${con.id}',
                  onTap: () {
                    Get.to(() => ProductDetailsScreen(productModel: con));
                  },
                  isLikedForCart: cartcart.isInCart(con),
                  addToChartOnTap: (p0) async {
                    cartController.addProductToCart(con);
                    return !p0;
                  },
                  addToFavOnTap: (p0) async {
                    controller.manageFavorites(productId);
                    return !p0;
                  },
                  isLiked: controller.isFavorites(productId),
                  title: con.title ?? "Null Title",
                  height: height.toDouble(),
                  image: con.image!,
                  price: "${con.price} \$",
                  rate: con.rating?.rate ?? 0,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class ShoeWidget extends StatelessWidget {
  const ShoeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          CustomText(text: "Trending Now", fontSize: 18, color: blackColor),
          CustomText(
            text: "Top Products Everyone’s Loving",
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: blackColor,
          ),
          SizedBox(
            height: 600,
            child: GridView.builder(
              itemCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.7 / 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                // mainAxisExtent: 16,
              ),
              itemBuilder:
                  (context, index) => Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      Container(
                        height: 250,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              // ignore: deprecated_member_use
                              color: Colors.black.withOpacity(.02),
                              offset: const Offset(0, 10),
                              blurRadius: 8,
                              spreadRadius: 0,
                            ),
                          ],
                          // shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CustomText(
                                    text: "15 \$",
                                    fontSize: 15,
                                    color: blackColor,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 18),
                              Container(
                                height: 140,
                                color: Colors.blue,
                              ).redacted(context: context, redact: true),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  CustomText(
                                    text: "15 \$",
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
                            topLeft: Radius.circular(15),
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            CustomText(
                              text: "15 \$",
                              fontSize: 15,
                              color: blackColor,
                              fontWeight: FontWeight.w800,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ).redacted(context: context, redact: true),
            ),
          ),
        ],
      ),
    );
  }
}
