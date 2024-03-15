import 'package:algeria_eats/components/rating_view.dart';
import 'package:flutter/material.dart';
import 'package:algeria_eats/features/reviews/models/review.dart';
import 'package:intl/intl.dart';

class CommentComponent extends StatelessWidget {
  final Review review;

  const CommentComponent({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Builder(builder: (context) {
          if (review.user?.image != null) {
            return CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                review.user!.image!,
              ),
            );
          } else {
            return const CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 25,
              backgroundImage: AssetImage(
                'assets/images/profile-pic.png',
              ),
            );
          }
        }),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${review.user?.nom ?? 'Unknown'} ${review.user?.prenom ?? ''}',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                    fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                DateFormat.yMMMMd().format(DateTime.parse(review.created_at)),
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
              ),
              const SizedBox(height: 4),
              RatingView(
                fontSize: 18,
                iconSize: 18,
                value: review.rating ?? 0,
              ),
              const SizedBox(height: 4),
              Text(review.title,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(review.comment),
            ],
          ),
        ),
      ],
    );
  }
}
