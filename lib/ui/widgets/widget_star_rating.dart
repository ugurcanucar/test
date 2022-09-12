import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final Color color;

  // ignore: use_key_in_widget_constructors
  const StarRating({
    this.starCount = 5,
    this.rating = .0,
    required this.color,
  });

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon =  const Icon(
        Icons.star_border,
      );
    } else if (index > rating - 1 && index < rating) {
      icon =  Icon(Icons.star_half, color: color);
    } else {
      icon =  Icon(Icons.star, color: color);
    }
    return  InkResponse(
      onTap: null,
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
             List.generate(starCount, (index) => buildStar(context, index)));
  }
}
