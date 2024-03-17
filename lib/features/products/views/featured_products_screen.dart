import 'package:algeria_eats/components/featured_product_card.dart';
import 'package:algeria_eats/features/products/controllers/product_controller.dart';
import 'package:algeria_eats/features/products/models/product.dart';
import 'package:algeria_eats/features/products/views/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class FeaturedProductsScreen extends GetView<ProductController> {
  const FeaturedProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Produits populaires",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        AspectRatio(
          aspectRatio: 1.6,
          child: Obx(
            () => controller.isLoading.value
                ? buildShimmerProductList()
                : buildProductList(controller.featuredProducts),
          ),
        ),
      ],
    );
  }

  Widget buildProductList(List<Product> products) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: products.map((product) {
        return FeaturedProductCard(
          product: product,
          onTap: () {
            Get.to(() => ProductScreen(
                  product: product,
                ));
          },
        );
      }).toList(),
    );
  }

  Widget buildShimmerProductList() {
    return GridView.builder(
      itemCount: 4,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.5,
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
