import 'package:algeria_eats/components/product_card.dart';
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
          aspectRatio: 1.5,
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
        return ProductCard(
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
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: 4,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.6,
            margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
            color: Colors.white,
          ),
        );
      },
    );
  }
}
