import 'package:flutter/material.dart';

class RatingBar extends StatelessWidget {
  final int rating;
  final int count;

  const RatingBar({Key? key, required this.rating, required this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          rating.toString(),
          style:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[600]),
        ),
        const SizedBox(width: 5),
        const Icon(Icons.star, color: Colors.orangeAccent, size: 16),
        const SizedBox(width: 12),
        Stack(
          children: [
            Container(
              height: 5,
              width: 100, // the full width of the gray line
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            Container(
              height: 5,
              width:
                  count.toDouble() * 20, // the width of the rating color line
              decoration: BoxDecoration(
                color: rating >= 4
                    ? Colors.green.withOpacity(0.75)
                    : rating >= 3
                        ? Colors.orange.withOpacity(0.75)
                        : Colors.red.withOpacity(0.75),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
