// ignore_for_file: must_be_immutable

import 'package:algeria_eats/components/loader.dart';
import 'package:algeria_eats/components/product_card_view.dart';
import 'package:algeria_eats/components/search_input_view.dart';
import 'package:algeria_eats/features/products/controllers/product_controller.dart';
import 'package:algeria_eats/features/products/models/product.dart';
import 'package:algeria_eats/features/products/views/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final TextEditingController search = TextEditingController();

  final ProductController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.only(bottom: 8.0, top: 8.0),
            child: SearchInput(
              onChanged: (value) {},
              textController: search,
              hintText: 'Rechercher un produit',
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 12.0),
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: PagedGridView<int, Product>(
                showNewPageProgressIndicatorAsGridChild: false,
                showNoMoreItemsIndicatorAsGridChild: true,
                pagingController: controller.pagingController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1 / 1.43,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  crossAxisCount: 2,
                ),
                builderDelegate: PagedChildBuilderDelegate<Product>(
                  animateTransitions: true,
                  firstPageProgressIndicatorBuilder: (context) {
                    return const Center(
                      child: Loader(),
                    );
                  },
                  newPageProgressIndicatorBuilder: (context) {
                    return const Center(
                      child: Loader(),
                    );
                  },
                  itemBuilder: (context, item, index) => ProductCardView(
                    onTap: () => Get.to(() => ProductScreen(product: item)),
                    product: item,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
