import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  const Loader({super.key, this.size = 35.0});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      color: Colors.orange.shade300,
      size: size,
    );
  }
}
