// ignore_for_file: deprecated_member_use

import 'package:algeria_eats/features/products/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key, required this.controller});
  final ProductController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      height: Get.height * 0.5,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Container(
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Filtrer par note',
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 18,
              color: Colors.grey[800],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => RatingBar.builder(
                    initialRating: controller.productRating.value.toDouble(),
                    minRating: 0,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => SvgPicture.asset(
                      'assets/images/star.svg',
                      width: 15,
                      height: 15,
                      color: Colors.orange.shade600,
                    ),
                    onRatingUpdate: (rating) {
                      controller.productRating.value = rating.toInt();
                      // Add your filtering logic here
                    },
                  )),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Filtrer par type de produit',
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 18,
              color: Colors.grey[800],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      controller.productType.value = '';
                      // Add your filtering logic here
                    },
                    child: Text(
                      'Sucrée et Salée',
                      style: TextStyle(
                        color: controller.productType.value == ''
                            ? Colors.orange
                            : Colors.black,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.productType.value = 'sucree';
                    },
                    child: Text(
                      'Sucrée',
                      style: TextStyle(
                        color: controller.productType.value == 'sucree'
                            ? Colors.orange
                            : Colors.black,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.productType.value = 'salee';
                      // Add your filtering logic here
                    },
                    child: Text(
                      'Salée',
                      style: TextStyle(
                        color: controller.productType.value == 'salee'
                            ? Colors.orange
                            : Colors.black,
                      ),
                    ),
                  ),
                ],
              )),
          const SizedBox(height: 16),
          Text(
            'Filtrer par ordre',
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 18,
              color: Colors.grey[800],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      controller.orderDirection.value = 'asc';
                    },
                    child: Text(
                      'Ordre croissant',
                      style: TextStyle(
                        color: controller.orderDirection.value == 'asc'
                            ? Colors.orange
                            : Colors.black,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.orderDirection.value = 'desc';
                      // Add your filtering logic here
                    },
                    child: Text(
                      'Ordre décroissant',
                      style: TextStyle(
                        color: controller.orderDirection.value == 'desc'
                            ? Colors.orange
                            : Colors.black,
                      ),
                    ),
                  ),
                ],
              )),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.orange.shade600),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return Colors.orange.shade600.withOpacity(0.04);
                          }
                          if (states.contains(MaterialState.focused) ||
                              states.contains(MaterialState.pressed)) {
                            return Colors.orange.shade600.withOpacity(0.12);
                          }
                          return null;
                        },
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.all(14.0),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      controller.pagingController.refresh();
                      Get.back();
                    },
                    child: const Text(
                      'Filtrer',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    )),
              ),
              const SizedBox(width: 8),
              FilledButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey.shade900),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.all(14.0),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                onPressed: () {
                  controller.orderDirection.value = 'asc';
                  controller.productRating.value = 0;
                  controller.productType.value = '';
                  controller.search.value = "";
                  controller.pagingController.refresh();
                  Get.back();
                },
                child: const Text(
                  "Réinitialiser",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
