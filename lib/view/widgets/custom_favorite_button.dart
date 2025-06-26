import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class CustomFavoriteButton extends StatelessWidget {
  const CustomFavoriteButton({super.key, required this.onTap});
  final Future<bool?> Function(bool)? onTap;

  @override
  Widget build(BuildContext context) {
    return LikeButton(
      size: 25,
      circleColor: const CircleColor(start: Colors.pink, end: Colors.redAccent),
      bubblesColor: const BubblesColor(
        dotPrimaryColor: Colors.red,
        dotSecondaryColor: Colors.pink,
      ),
      likeBuilder: (bool isLiked) {
        return AnimatedScale(
          scale: isLiked ? 1.2 : 1.0, // Grows a little when liked
          duration: const Duration(milliseconds: 150),
          curve: Curves.bounceIn,
          child: Image.asset(
            isLiked ? "assets/images/red heart.png" : "assets/images/heart.png",
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
