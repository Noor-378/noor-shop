import 'package:flutter/material.dart';

class SingleStarRating extends StatelessWidget {
  final double rate; // Current rating (e.g. 3.7)
  final double max; // Max rating (e.g. 5.0)
  final double size; // Size of the star icon
  final Color fillColor;
  final Color borderColor;

  const SingleStarRating({
    super.key,
    required this.rate,
    this.max = 5.0,
    this.size = 20,
    this.fillColor = const Color.fromARGB(255, 255, 230, 0),
    this.borderColor = const Color.fromARGB(255, 255, 230, 0),
  });

  @override
  Widget build(BuildContext context) {
    // Make sure rate doesn't exceed bounds
    double clampedRate = rate.clamp(0.0, max);
    double fillPercentage = clampedRate / max;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Icon(Icons.star_border, size: size, color: borderColor),
          ClipRect(
            clipper: _PartialClipper(fillPercentage),
            child: Icon(Icons.star, size: size, color: fillColor),
          ),
        ],
      ),
    );
  }
}

class _PartialClipper extends CustomClipper<Rect> {
  final double fillPercentage;

  _PartialClipper(this.fillPercentage);

  @override
  Rect getClip(Size size) {
    double width = size.width * fillPercentage.clamp(0.0, 1.0);
    return Rect.fromLTWH(0, 0, width, size.height);
  }

  @override
  bool shouldReclip(covariant _PartialClipper oldClipper) {
    return oldClipper.fillPercentage != fillPercentage;
  }
}
