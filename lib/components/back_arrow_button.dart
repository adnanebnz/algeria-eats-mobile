import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackArrowButton extends StatelessWidget {
  const BackArrowButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        height: 40.0,
        width: 40.0,
        margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 36.0),
        decoration: BoxDecoration(
          color: Colors.white70,
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(2, 10)),
          ],
        ),
        child: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: Colors.grey[800],
          iconSize: 22,
        ),
      ),
    );
  }
}
