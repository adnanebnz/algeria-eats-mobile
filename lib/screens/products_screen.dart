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
  String searchText = '';
  String selectedCategory = '';
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
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                    child: SearchInput(
                      onChanged: (value) {
                        setState(() {
                          searchText = value;
                        });
                      },
                      textController: textController,
                      hintText: 'Search product',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: DropdownButton(
                        isExpanded: true,
                        hint: Text(
                            'Catégorie : ${selectedCategory.isEmpty ? 'Tous' : selectedCategory == 'sucree' ? 'Sucrée' : 'Salée'}'),
                        items: const [
                          DropdownMenuItem(
                            value: 'sucree',
                            child: Text('Sucrée'),
                          ),
                          DropdownMenuItem(
                            value: 'salee',
                            child: Text('Salée'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value.toString();
                          });
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
                          itemCount: searchText.isEmpty
                              ? (selectedCategory.isEmpty
                                  ? controller.products.length
                                  : controller.products
                                      .where((product) =>
                                          product.categorie == selectedCategory)
                                      .length)
                              : controller.products
                                  .where((product) =>
                                      product.nom
                                          .toLowerCase()
                                          .contains(searchText.toLowerCase()) &&
                                      (selectedCategory.isEmpty ||
                                          product.categorie ==
                                              selectedCategory))
                                  .length,
                          itemBuilder: (context, index) {
                            final product = searchText.isEmpty
                                ? (selectedCategory.isEmpty
                                    ? controller.products[index]
                                    : controller.products
                                        .where((product) =>
                                            product.categorie ==
                                            selectedCategory)
                                        .elementAt(index))
                                : controller.products
                                    .where((product) =>
                                        product.nom.toLowerCase().contains(
                                            searchText.toLowerCase()) &&
                                        (selectedCategory.isEmpty ||
                                            product.categorie ==
                                                selectedCategory))
                                    .elementAt(index);

                            return ProductCardView(
                              product: product,
                              onTap: (productId) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductScreen(
                                      product: product,
                                    ),
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
    });
  }
}
