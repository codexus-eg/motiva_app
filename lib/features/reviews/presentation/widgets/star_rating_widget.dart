import 'package:flutter/material.dart';

class StarRatingWidget extends StatelessWidget {
  final int rating;
  final int maxRating;
  final Function(int) onRatingChanged;
  final bool readOnly;
  final double starSize;
  final Color activeColor;
  final Color inactiveColor;

  const StarRatingWidget({
    super.key,
    required this.rating,
    this.maxRating = 5,
    required this.onRatingChanged,
    this.readOnly = false,
    this.starSize = 32,
    this.activeColor = Colors.amber,
    this.inactiveColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxRating, (index) {
        return GestureDetector(
          onTap: readOnly ? null : () => onRatingChanged(index + 1),
          child: Icon(
            index < rating ? Icons.star : Icons.star_border,
            size: starSize,
            color: index < rating ? activeColor : inactiveColor,
          ),
        );
      }),
    );
  }
}
