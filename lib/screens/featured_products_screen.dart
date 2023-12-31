// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:algeria_eats/components/product_card_view.dart';
import 'package:algeria_eats/models/artisan.dart';
import 'package:algeria_eats/models/product.dart';
import 'package:algeria_eats/models/user.dart';
import 'package:algeria_eats/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:algeria_eats/controllers/productController.dart';
import 'package:shimmer/shimmer.dart';
// import 'dart:developer' as console show log;

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
    return Obx(
      () {
        if (productController.isLoading.value) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Featured Products",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.27,
                child: Shimmer.fromColors(
                  baseColor:
                      Colors.grey[300]!, // You can customize these colors
                  highlightColor: Colors.grey[100]!,
                  child: buildShimmerProductList(),
                ),
              ),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Featured Products",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.33,
                  child: buildProductList(productController.products)),
            ],
          );
        }
      },
    );
  }

  Widget buildProductList(List<Product> products) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: products.map((product) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
          child: ProductCardView(
            product: product,
            onTap: (productId) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductScreen(product: product),
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }

  Widget buildShimmerProductList() {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      children: List.generate(4, (index) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width * 0.5,
          margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
          child: ProductCardView(
            onTap: (productId) {},
            product: Product(
              artisan: Artisan(
                  user_id: 0,
                  created_at: '',
                  desc_entreprise: '',
                  heure_fermeture: '',
                  heure_ouverture: '',
                  rating: 0,
                  type_service: '',
                  updated_at: '',
                  user: User(
                      adresse: '',
                      created_at: '',
                      email: '',
                      id: 0,
                      image: '',
                      nom: '',
                      num_telephone: '',
                      prenom: '',
                      updated_at: '',
                      wilaya: '')),
              id: 0,
              nom: '',
              description: '',
              prix: 0,
              categorie: '',
              images: [],
              rating: 0,
              created_at: '',
              updated_at: '',
            ),
          ),
        );
      }),
    );
  }
}
