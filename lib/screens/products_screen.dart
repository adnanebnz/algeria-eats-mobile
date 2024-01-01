import 'package:algeria_eats/components/product_card_view.dart';
import 'package:algeria_eats/controllers/productController.dart';
import 'package:algeria_eats/screens/product_screen.dart';
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

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: DropdownButton(
                        isExpanded: true,
                        hint: const Text('Sort by'),
                        items: const [
                          DropdownMenuItem(
                            value: 'category',
                            child: Text('Category'),
                          ),
                          DropdownMenuItem(
                            value: 'price',
                            child: Text('Price'),
                          ),
                        ],
                        onChanged: (value) {
                          print(value);
                        }),
                  ),

                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1 / 1.43,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          crossAxisCount: 2,
                        ),
                        itemCount: controller.products.length,
                        itemBuilder: (context, index) {
                          return ProductCardView(
                              product: controller.products[index],
                              onTap: (productId) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductScreen(
                                        product: controller.products[index]),
                                  ),
                                );
                              });
                        },
                      ),
                    ),
                  ),
                ],
              ),
      );
    });
  }
}
