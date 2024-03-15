import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CategoryCardView extends StatelessWidget {
  final String text;
  final String imageUrl;
  final String subtitle;

  const CategoryCardView(
      {required this.text,
      required this.imageUrl,
      required this.subtitle,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      padding: const EdgeInsets.symmetric(horizontal: 38.0, vertical: 18),
      decoration: BoxDecoration(
        border: Border.all(width: 0.5, color: Colors.grey.shade100),
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.5),
        boxShadow: [
          BoxShadow(
              offset: const Offset(5, 10),
              blurRadius: 10,
              spreadRadius: 0,
              color: Colors.grey.withOpacity(.05)),
        ],
      ),
      child: Column(
        children: [
          CachedNetworkImage(imageUrl: imageUrl, height: 50, fit: BoxFit.cover),
          Text(text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
          const SizedBox(
            height: 4,
          ),
          Text(
            subtitle,
            style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.normal,
                fontSize: 12),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
