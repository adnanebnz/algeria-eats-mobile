// ignore_for_file: must_be_immutable

import 'package:algeria_eats/components/category_card_view.dart';
import 'package:algeria_eats/features/products/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesView extends StatelessWidget {
  CategoriesView({super.key});

  ProductController productController = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8.0, top: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CategoryCardView(
                    text: 'Sucrée',
                    subtitle:
                        '${productController.sweetProductsCount.value} produits',
                    imageUrl:
                        'https://static.vecteezy.com/system/resources/previews/023/522/885/non_2x/birthday-cake-cutout-free-png.png',
                  ),
                  CategoryCardView(
                    text: 'Salée',
                    subtitle:
                        '${productController.saltyProductsCount.value} produits',
                    imageUrl:
                        'https://static.vecteezy.com/system/resources/previews/021/217/138/non_2x/arabian-esfiha-of-chicken-esfirra-brazilian-snack-png.png',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
