import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeaturedProductCardShimmer extends StatelessWidget {
  const FeaturedProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: Get.width * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.5),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey[300],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 10.0,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 10.0,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 8),
          Container(
            width: 60.0,
            height: 10.0,
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }
}
