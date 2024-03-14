// ignore_for_file: must_be_immutable

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
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final TextEditingController textController = TextEditingController();
  String searchText = '';
  final ProductController controller = Get.find();
  final PagingController<int, Product> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await controller.getAllProducts(pageKey);
      final isLastPage = newItems.length < 10;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

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
                    child: PagedGridView<int, Product>(
                      pagingController: _pagingController,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1 / 1.43,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        crossAxisCount: 2,
                      ),
                      builderDelegate: PagedChildBuilderDelegate<Product>(
                        itemBuilder: (context, item, index) => ProductCardView(
                          onTap: () =>
                              Get.to(() => ProductScreen(product: item)),
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
