// ignore_for_file: must_be_immutable

import 'package:algeria_eats/components/product_card_view.dart';
import 'package:algeria_eats/components/search_input_view.dart';
import 'package:algeria_eats/controllers/productController.dart';
import 'package:algeria_eats/views/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsScreen extends GetView<ProductController> {
  final TextEditingController textController = TextEditingController();
  String searchText = '';

  ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                  child: SearchInput(
                    onChanged: (value) {
                      searchText = value;
                      controller.update();
                    },
                    textController: textController,
                    hintText: 'Rechercher un produit',
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1 / 1.43,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          crossAxisCount: 2,
                        ),
                        itemCount: searchText.isEmpty
                            ? controller.products.length
                            : controller.products
                                .where((product) => product.nom
                                    .toLowerCase()
                                    .contains(searchText.toLowerCase()))
                                .length,
                        itemBuilder: (context, index) {
                          var product = searchText.isEmpty
                              ? controller.products[index]
                              : controller.products
                                  .where((product) => product.nom
                                      .toLowerCase()
                                      .contains(searchText.toLowerCase()))
                                  .toList()[index];
                          return ProductCardView(
                            product: product,
                            onTap: () {
                              Get.to(
                                () => ProductScreen(
                                  product: product,
                                ),
                              );
                            },
                          );
                        }),
                  ),
                ),
              ],
            ),
    );
  }
}
