import 'package:flutter/material.dart';

class RatingAndVerifiedBuyers extends StatelessWidget {
  final double rating;
  final int verifiedBuyers;

  const RatingAndVerifiedBuyers(
      {super.key, required this.rating, required this.verifiedBuyers});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              rating.toString(),
              style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 36,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.star,
              color: Colors.orangeAccent,
              size: 26,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          "$verifiedBuyers verified buyers",
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        )
      ],
    );
  }
}
