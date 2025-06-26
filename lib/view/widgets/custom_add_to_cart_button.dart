import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:noor_store/utils/colors.dart';

class CustomAddToCartButton extends StatelessWidget {
  const CustomAddToCartButton({super.key, required this.onTap});
  final Future<bool?> Function(bool)? onTap;

  @override
  Widget build(BuildContext context) {
    return LikeButton(
      size: 25,
      circleColor: const CircleColor(
        start: Colors.blue,
        end: Colors.blueAccent,
      ),
      bubblesColor: BubblesColor(
        dotPrimaryColor: mainColor,
        dotSecondaryColor: Colors.lightBlue,
      ),
      likeBuilder: (bool isLiked) {
        return AnimatedScale(
          scale: isLiked ? 1.2 : 1.0, // Grows a little when liked
          duration: const Duration(milliseconds: 150),
          curve: Curves.bounceIn,
          child: Image.asset(
            isLiked
                ? "assets/images/add to cart2.png"
                : "assets/images/add to cart.png",
            height: 25,
            width: 25,
            fit: BoxFit.contain,
          ),
        );
      },
      onTap: onTap,
    );
  }
}
