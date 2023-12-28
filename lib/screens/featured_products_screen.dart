// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:algeria_eats/components/product_card_view.dart';
import 'package:algeria_eats/models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:algeria_eats/controllers/productController.dart';
import 'dart:developer' as console show log;

class FeaturedProductsScreen extends StatefulWidget {
  @override
  _FeaturedProductsScreenState createState() => _FeaturedProductsScreenState();
}

class _FeaturedProductsScreenState extends State<FeaturedProductsScreen> {
  final ProductController productController = Get.put(ProductController());
  @override
  void initState() {
    productController.getAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Featured Products',
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500)),
      ),
      body: Obx(
        () {
          if (productController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return buildProductList(productController.products);
          }
        },
      ),
    );
  }

  Widget buildProductList(List<Product> products) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      children: products.map((product) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.4,
          margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
          child: ProductCardView(
            product: product,
            onTap: (productId) {
              console.log('Product id: $productId');
            },
          ),
        );
      }).toList(),
    );
  }
}
