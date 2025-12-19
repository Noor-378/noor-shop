import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noor_store/logic/controllers/cart_controller.dart';
import 'package:noor_store/logic/controllers/main_controller.dart';
import 'package:noor_store/model/product_model.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/view/screens/check_out_screen.dart';
import 'package:noor_store/view/screens/product_details_screen.dart';
import 'package:noor_store/view/widgets/custom_text.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  final controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find<MainController>();

    return GetBuilder<CartController>(
      builder: (productController) {
        final int cartItemCount = controller.productMap.length;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Your Cart",
                          fontSize: 18,
                          color: blackColor,
                        ),
                        CustomText(
                          text:
                              cartItemCount == 0
                                  ? "Your cart is waiting to be filled"
                                  : "Review Your Selected Items",
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: textBodyColor,
                        ),
                      ],
                    ),
                    CustomText(
                      text: "\$ ${controller.productsSubTotal}",
                      fontSize: 18,
                      color: blackColor,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                cartItemCount == 0
                    ? _buildEmptyState(context, mainController)
                    : Column(
                      children: [
                        CartListOfCard(controller: controller),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: mainColor,
                              foregroundColor: whiteColor,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () {
                              Get.to(CheckOutScreen());
                            },
                            icon: const Icon(Icons.shopping_cart_checkout),
                            label: CustomText(
                              text: "Check Out",
                              fontSize: 16,
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context, MainController mainController) {
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                        color: mainColor.withOpacity(0.1),
                        offset: const Offset(0, 10),
                        blurRadius: 20,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    size: 100,
                    color: mainColor.withOpacity(0.5),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              FadeInUp(
                delay: const Duration(milliseconds: 200),
                child: CustomText(
                  text: "Your Cart is Empty",
                  fontSize: 22,
                  color: blackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: CustomText(
                    text:
                        "Looks like you haven't added anything to your cart yet",
                    fontSize: 15,
                    color: textBodyColor,
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              FadeInUp(
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
                      const Icon(Icons.shopping_bag_outlined, size: 20),
                      const SizedBox(width: 10),
                      CustomText(
                        text: "Start Shopping",
                        fontSize: 16,
                        color: whiteColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              FadeInUp(
                delay: const Duration(milliseconds: 500),
                child: TextButton(
                  onPressed: () {
                    Future.delayed(const Duration(milliseconds: 100), () {
                      mainController.changeIndex(2);
                    });
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: secondColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.favorite_border, size: 18, color: secondColor),
                      const SizedBox(width: 8),
                      CustomText(
                        text: "View Favorites",
                        fontSize: 14,
                        color: secondColor,
                        fontWeight: FontWeight.w500,
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
}

class CartListOfCard extends StatelessWidget {
  const CartListOfCard({super.key, required this.controller});
  final CartController controller;

  @override
  Widget build(BuildContext context) {
    final entries = controller.productMap.entries.toList();

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final product = entries[index].key;
        final quantity = entries[index].value;

        return FadeInLeftBig(
          from: index == 0 ? 25 : index * 50,
          child: CartCartCart(
            heroTag: "product_$index",
            onTap:
                () => Get.to(
                  ProductDetailsScreen(
                    productModel: product,
                    heroTag: "product_$index",
                  ),
                ),
            product: product,
            quantity: quantity,
            onAdd: () => controller.addProductToCart(product),
            onRemove: () => controller.removeProductsFromCart(product),
            onDelete: () => controller.removeOneProductFromCart(product),
          ),
        );
      },
    );
  }
}

class CartCartCart extends StatelessWidget {
  const CartCartCart({
    super.key,
    required this.product,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
    required this.onDelete,
    required this.heroTag,
    required this.onTap,
  });

  final ProductModel product;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final VoidCallback onDelete;
  final String heroTag;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 130,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 8,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Hero(
              tag: heroTag,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product.image ?? '',
                  height: 110,
                  width: 110,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 110,
                      width: 110,
                      color: Colors.grey.shade200,
                      alignment: Alignment.center,
                      child: const Icon(Icons.broken_image, color: Colors.grey),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: product.title ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: blackColor,
                  ),
                  const SizedBox(height: 6),

                  CustomText(
                    text: "\$${product.price?.toStringAsFixed(2)}",
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: blackColor,
                  ),

                  const Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Quantity Controls
                      Row(
                        children: [
                          IconButton(
                            onPressed: onRemove,
                            icon: const Icon(
                              Icons.remove_circle_outline,
                              size: 20,
                            ),
                          ),
                          Text(
                            quantity.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          IconButton(
                            onPressed: onAdd,
                            icon: const Icon(
                              Icons.add_circle_outline,
                              size: 20,
                            ),
                          ),
                        ],
                      ),

                      IconButton(
                        onPressed: onDelete,
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
