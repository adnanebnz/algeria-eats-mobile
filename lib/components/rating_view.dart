import 'package:flutter/material.dart';

class RatingView extends StatelessWidget {
  const RatingView({
    Key? key,
    this.value = 0,
    this.fontSize = 8,
    this.iconSize = 8,
    this.isExtended = false,
  }) : super(key: key);

  final int value;
  final double fontSize;
  final double iconSize;
  final bool isExtended;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StarView(
          value: value,
          size: iconSize,
        ),
      ],
    );
  }
}

class StarView extends StatelessWidget {
  const StarView({Key? key, this.value = 0, this.size = 8}) : super(key: key);

  final int value;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < value ? Icons.star : Icons.star_border,
          size: size,
        );
      }),
    );
  }
}
