import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingWidget extends StatelessWidget {
  double rate;
  double size;
  RatingWidget({Key? key, required this.rate, this.size = 20.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rate,
      itemBuilder: (context, index) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      unratedColor: Colors.grey.shade400,
      itemCount: 5,
      itemSize: size,
      // direction: Axis.vertical,
    );
  }
}
