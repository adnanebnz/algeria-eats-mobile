import 'package:algeria_eats/components/product_grid_card.dart';
import 'package:algeria_eats/controllers/productController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:algeria_eats/components/search_input_view.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  ProductController productController = Get.put(ProductController());
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    productController.getAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetX<ProductController>(builder: (controller) {
      return Scaffold(
        body: controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  // filter by category and search and sort
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                    child: SearchInput(
                      textController: textController,
                      hintText: 'Search',
                    ),
                  ),

                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: controller.products.length,
                      itemBuilder: (context, index) {
                        return ProductGridCard(
                            product: controller.products[index], onTap: () {});
                      },
                    ),
                  ),
                ],
              ),
      );
    });
  }
}
