import 'package:algeria_eats/components/loader.dart';
import 'package:algeria_eats/components/product_card_view.dart';
import 'package:algeria_eats/components/search_input_view.dart';
import 'package:algeria_eats/features/products/controllers/product_controller.dart';
import 'package:algeria_eats/features/products/models/product.dart';
import 'package:algeria_eats/features/products/views/components/filter_bottom_sheet.dart';
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
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: SearchInput(
                    onChanged: (value) {
                      controller.setProductName = value;
                    },
                    textController: search,
                    hintText: 'Rechercher un produit',
                  ),
                ),
                const SizedBox(width: 8.0),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ]),
                  child: IconButton(
                      onPressed: () {
                        // hide keyboard
                        FocusManager.instance.primaryFocus?.unfocus();
                        Get.bottomSheet(
                          FilterBottomSheet(controller: controller),
                          enableDrag: true,
                          isDismissible: true,
                          isScrollControlled: true,
                        );
                      },
                      icon: const Icon(Icons.filter_list_outlined)),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
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
                  noItemsFoundIndicatorBuilder: (context) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Aucun produit trouvé',
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 18,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'La liste des produits est vide.',
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
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
