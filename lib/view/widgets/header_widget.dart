import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noor_store/logic/controllers/product_controller.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/view/widgets/custom_add_to_cart_button.dart';
import 'package:noor_store/view/widgets/custom_favorite_button.dart';
import 'package:noor_store/view/widgets/custom_snackbar.dart';
import 'package:noor_store/view/widgets/custom_star.dart';
import 'package:noor_store/view/widgets/custom_text.dart';
import 'package:redacted/redacted.dart';

class HeaderWidget extends StatelessWidget {
  HeaderWidget({super.key});
  final controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          colors: [headerWidgetColor, SecondHeaderWidgetColor],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Keep padding for header text
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: CustomText(text: "Just for You", fontSize: 18),
            ),
            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: CustomText(
                text: "Exclusive Deals Handpicked for You",
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 20),
            GetBuilder<ProductController>(
              builder: (controller) {
                return controller.isLoading.value
                    ? const ShimmerForHidder()
                    : FadeInRightBig(
                      from: 200,
                      child: ListOfCards(controller: controller),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ListOfCards extends StatelessWidget {
  const ListOfCards({super.key, required this.controller});

  final ProductController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return JustForYouCard(
            title: controller.productModel[index].title ?? "Null Title",
            image:
                controller.productModel[index].image ??
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhCoPMSIngXopV7FgaNKeFGYZRPxh6edPcMw&s",
            price: controller.productModel[index].price ?? 0,
            rate: controller.productModel[index].rating!.rate ?? 0,
          );
        },
        itemCount: controller.productModel.length,
        separatorBuilder: (context, index) => const SizedBox(width: 20),
      ),
    );
  }
}

class JustForYouCard extends StatelessWidget {
  const JustForYouCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    this.rate,
  });

  final String image;
  final String title;
  final double price;
  final double? rate;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 175,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(5),
          topLeft: Radius.circular(5),
        ),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(.02),
            offset: const Offset(0, 10),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomFavoriteButton(
                  isLiked: false,
                  onTap: (bool isLiked) async {
                    isLiked
                        ? customGetSnackbar(
                          title: "false",
                          messageText: "false",
                        )
                        : customGetSnackbar(title: "true", messageText: "true");
                    return !isLiked;
                  },
                ),
                CustomAddToCartButton(
                  onTap: (bool isLiked) async {
                    isLiked
                        ? customGetSnackbar(
                          title: "false",
                          messageText: "false",
                        )
                        : customGetSnackbar(title: "true", messageText: "true");
                    // You can add your logic here (API call, GetX update, etc.)
                    return !isLiked;
                  },
                ),
              ],
            ),
            const SizedBox(height: 15),
            ClipRRect(
              borderRadius: BorderRadius.circular(19),
              child: Image.network(
                image,
                fit: BoxFit.contain,
                height: 112,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 112,
                    width: 112,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.amber,
                    ),
                  ).redacted(context: context, redact: true);
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 112,
                    color: Colors.grey.shade200,
                    alignment: Alignment.center,
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
            CustomText(
              text: title,
              fontSize: 14,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              color: blackColor,
              fontWeight: FontWeight.w800,
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
                      fontSize: 12,
                      color: blackColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ],
                ),

                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2.5),
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(2.5),
                      ),
                      child: CustomText(
                        // ideia* to make it like gample :)
                        // if the user press on the price, become lower
                        text: "$price \$",

                        decoration: TextDecoration.lineThrough,
                        fontSize: 12,
                        color: const Color.fromARGB(255, 255, 17, 0),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    CustomText(
                      // ideia* to make it like gample :)
                      // if the user press on the price, become lower
                      text: "${(price / 2)} \$",
                      fontSize: 14,
                      color: blackColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerForHidder extends StatelessWidget {
  const ShimmerForHidder({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder:
            (context, index) => Container(
              height: 100,
              width: 175,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(5),
                  topLeft: Radius.circular(5),
                ),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(.02),
                    offset: const Offset(0, 10),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ).redacted(context: context, redact: true),
                        Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ).redacted(context: context, redact: true),
                      ],
                    ),
                    const SizedBox(height: 18),

                    Container(
                      height: 125,
                      width: 115,

                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(19),
                      ),
                    ).redacted(context: context, redact: true),

                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ).redacted(context: context, redact: true),
                            const SizedBox(width: 5),
                            CustomText(
                              // ideia* to make it like gample :)
                              // if the user press on the price, become lower
                              text: "price \$",
                              fontSize: 14,
                              color: blackColor,
                              fontWeight: FontWeight.w800,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2.5),
                              decoration: BoxDecoration(
                                color: Colors.red.shade100,
                                borderRadius: BorderRadius.circular(2.5),
                              ),
                              child: const CustomText(
                                // ideia* to make it like gample :)
                                // if the user press on the price, become lower
                                text: "price \$",

                                decoration: TextDecoration.lineThrough,
                                fontSize: 12,
                                color: Color.fromARGB(255, 255, 17, 0),
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 5),
                            CustomText(
                              // ideia* to make it like gample :)
                              // if the user press on the price, become lower
                              text: "price \$",
                              fontSize: 14,
                              color: blackColor,
                              fontWeight: FontWeight.w800,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ).redacted(context: context, redact: true),
        itemCount: 5,
        separatorBuilder: (context, index) => const SizedBox(width: 20),
      ),
    );
  }
}
