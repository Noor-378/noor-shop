import 'package:flutter/material.dart';
import 'package:noor_store/model/product_model.dart';
import 'package:noor_store/utils/colors.dart';
import 'package:noor_store/view/widgets/custom_add_to_cart_button.dart';
import 'package:noor_store/view/widgets/custom_favorite_button.dart';
import 'package:noor_store/view/widgets/custom_snackbar.dart';
import 'package:noor_store/view/widgets/custom_star.dart';
import 'package:noor_store/view/widgets/custom_text.dart';
import 'package:redacted/redacted.dart';

class ListItemCard extends StatelessWidget {
  final ProductModel product;
  const ListItemCard({
    super.key,
    required this.product,
    required this.isLiked,
    required this.addToCartOnTap,
    required this.addToFavOnTap,
  });
  final isLiked;
  final Future<bool?> Function(bool)? addToCartOnTap;
  final Future<bool?> Function(bool)? addToFavOnTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Container(
          height: 130,
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(.03),
                blurRadius: 8,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  10,
                ), // adjust if you want more/less rounding
                child: Image.network(
                  product.image ?? '',
                  height: 100,
                  width: 100,
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 100,
                      width: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.amber,
                      ),
                    ).redacted(context: context, redact: true);
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 100,
                      width: 100,
                      color: Colors.grey.shade200,
                      alignment: Alignment.center,
                      child: const Icon(Icons.broken_image, color: Colors.grey),
                    );
                  },
                ),
              ),

              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: CustomText(
                            text: product.title ?? '',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: blackColor,
                          ),
                        ),
                        const SizedBox(width: 50),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SingleStarRating(
                              rate: product.rating?.rate ?? 0,
                              size: 25,
                            ),
                            const SizedBox(width: 5),
                            CustomText(
                              text: product.rating?.rate.toString() ?? "0.0",
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: blackColor,
                            ),
                          ],
                        ),
                        CustomText(
                          text: "\$${product.price}",
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: blackColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        Positioned(
          top: 15,
          left: 5,
          child: CustomFavoriteButton(isLiked: isLiked, onTap: addToFavOnTap),
        ),

        Positioned(
          top: 5,
          right: 0,
          child: Container(
            height: 40,
            width: 50,
            decoration: BoxDecoration(
              color: contentColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
              ),
            ),
            child: CustomAddToCartButton(onTap: addToCartOnTap),
          ),
        ),
      ],
    );
  }
}
