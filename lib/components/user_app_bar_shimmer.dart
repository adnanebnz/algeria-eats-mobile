import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UserProfilePicShimmer extends StatelessWidget {
  const UserProfilePicShimmer({super.key, this.radius = 25});
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.grey[300],
      ),
    );
  }
}
