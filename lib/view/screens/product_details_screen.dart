import 'package:flutter/material.dart';
import 'package:noor_store/model/product_model.dart';
import 'package:noor_store/view/widgets/add_cart.dart';
import 'package:noor_store/view/widgets/clothes_info.dart';
import 'package:noor_store/view/widgets/image_slider.dart';
import 'package:noor_store/view/widgets/size_list.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel productModel;
  const ProductDetailsScreen({required this.productModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Stack(
          children: [
            // MAIN SCROLL CONTENT
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 180),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageSliders(imageUrl: productModel.image ?? ""),
                  ClothesInfo(
                    title: productModel.title ?? "",
                    productId: productModel.id ?? 0,
                    rate: productModel.rating?.rate ?? 1,
                    description: productModel.description ?? "",
                  ),
                  const SizeList(),
                ],
              ),
            ),

            // FIXED ADD TO CART BUTTON
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: AddCart(
                price: productModel.price ?? 0,
                productModel: productModel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
