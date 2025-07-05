import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:noor_store/logic/controllers/product_controller.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/view/widgets/custom_favorite_button.dart';
import 'package:noor_store/view/widgets/custom_text.dart';
import 'package:noor_store/view/widgets/item_card.dart';
import 'dart:math';

import 'package:redacted/redacted.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLeading.value) {
        return const ShoeWidget().redacted(context: context, redact: true);
      } else {
        return FadeInUp(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                CustomText(
                  text: "Trending Now",
                  fontSize: 18,
                  color: blackColor,
                ),
                CustomText(
                  text: "Top Products Everyone’s Loving",
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: blackColor,
                ),

                CustomGrid(controller: controller),
                const SizedBox(height: 50),

                CustomFavoriteButton(
                  onTap: (isLike) async {
                    return !isLike;
                  },
                ),
                const SizedBox(height: 50),
                // MyHomePage(tabController: controller.tap!, itemsMode: controller.productModel)
              ],
            ),
          ),
        );
      }
    });
  }
}

class CustomGrid extends StatelessWidget {
  const CustomGrid({super.key, required this.controller});
  final ProductController controller;

  @override
  Widget build(BuildContext context) {
    final random = Random();
    return MasonryGridView.builder(
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      itemCount: controller.productModel.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final height = 200 + random.nextInt(150);
        final con = controller.productModel[index];

        return FadeInUpBig(
          from: height.toDouble(),
          child: ItemCard(
            height: height.toDouble(),
            image: con.image!,
            price: "${con.price.toString()} \$",
          ),
        );
      },
    );
  }
}

////////////////////////////////////////////////////////////////////////
// GridView.builder(
//       physics:
//           const NeverScrollableScrollPhysics(), // 🧠 disables inner scrolling
//       shrinkWrap:
//           true, // 🧠 allows GridView to take only as much height as needed
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(

//         crossAxisCount:
//             2, // 🟩 Number of items per row (2 items horizontally)
//         crossAxisSpacing:
//             10, // 🟨 Horizontal space between columns (10 pixels)
//         mainAxisSpacing: 20, // 🟦 Vertical space between rows (20 pixels)
//         childAspectRatio:
//             2.9 /
//             4, // 🟥 Width / Height ratio of each item (makes items taller than wide)
//       ),
//       itemCount: 10,
//       itemBuilder:
//           (context, index) => const ItemCard(),
//     );

// GridView.builder(
//       physics:
//           const NeverScrollableScrollPhysics(), // 🧠 disables inner scrolling
//       shrinkWrap:
//           true, // 🧠 allows GridView to take only as much height as needed

//       gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//         maxCrossAxisExtent: 200, // width of each tile
//         crossAxisSpacing: 10,
//         mainAxisSpacing: 20,
//       ),
//       itemCount: 10,
//       itemBuilder:
//           (context, index) => ItemCard(height: index.isEven ? 100 : 150),
//     );
////////////////////////////////////////////////////////////////////////
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
                              offset: const Offset(
                                0,
                                10,
                              ), // Pushes it straight down
                              blurRadius: 8, // Smooth shadow
                              spreadRadius: 0, // No sideways growth
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
                              // ClipRRect(
                              //   borderRadius: BorderRadius.circular(19),
                              //   child: Image.network(
                              //     fit: BoxFit.cover,
                              //     height: 150,
                              //     "https://images.unsplash.com/photo-1750975200813-8018392a588e?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwxNHx8fGVufDB8fHx8fA%3D%3D",
                              //   ).redacted(context: context, redact: true),
                              // ),
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

// ItemCard(
//   height: 500,
//   image:
//       "https://images.unsplash.com/photo-1750975200813-8018392a588e?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwxNHx8fGVufDB8fHx8fA%3D%3D",
//   price: "5",
// ),

// class HorizontalProductCarousel extends StatelessWidget {
//   final TabController tabController;
//   final List<ProductModel> products;

//   const HorizontalProductCarousel({
//     super.key,
//     required this.tabController,
//     required this.products,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return LocalHeroViews(
//       tabController: tabController,
//       textDirection: TextDirection.ltr,
//       itemCount: products.length,
//       onPressedCard: (index) {
//         // What happens when user taps card at position `index`
//         print('Card $index pressed');
//         // For example, navigate to detail screen:
//         // Navigator.of(context).push(...);
//       },
//       itemsModel: (index) {
//         final product = products[index];
//         return ItemsModel(
//           name: Text(
//             product.title ?? "s",
//             style: const TextStyle(fontWeight: FontWeight.bold),
//           ),
//           title: Text(
//             product.price.toString() ?? "s",
//             style: const TextStyle(color: Colors.green),
//           ),
//           subTitle: const SizedBox.shrink(), // add subtitle if you want
//           favoriteIconButton: IconButton(
//             icon: const Icon(Icons.favorite_border),
//             onPressed: () {
//               // your favorite logic here
//             },
//           ),
//           subTitleIcon: const Icon(Icons.shopping_cart, size: 14),
//           image: DecorationImage(
//             image: NetworkImage(product.image!),
//             fit: BoxFit.cover,
//           ),
//         );
//       },
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   final TabController tabController;
//   final List<ProductModel> itemsMode; // Your model

//   MyHomePage({required this.tabController, required this.itemsMode});

//   @override
//   Widget build(BuildContext context) {
//     return LocalHeroViews(
//       tabController: tabController,
//       textDirection: TextDirection.ltr,
//       itemCount: itemsMode.length,
//       itemsModel:
//           (index) => ItemsModel(
//             name: Text(itemsMode[index].rating.toString()),
//             title: Text(itemsMode[index].title!),
//             subTitle: Text(itemsMode[index].price.toString()),
//             favoriteIconButton: IconButton(
//               onPressed: () {},
//               icon: Icon(Icons.add),
//             ),
//             subTitleIcon: const Icon(
//               Icons.location_on_outlined,
//               color: Color(0xFF95979A),
//               size: 10,
//             ),
//             image: DecorationImage(
//               image: NetworkImage(itemsMode[index].image!),
//             ),
//           ),
//       onPressedCard: (int index) {},
//     );
//   }
// }
