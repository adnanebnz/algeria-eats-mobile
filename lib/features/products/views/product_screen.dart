// ignore_for_file: library_private_types_in_public_api

import 'package:algeria_eats/components/back_arrow_button.dart';
import 'package:algeria_eats/features/cart/controllers/cart_controller.dart';
import 'package:algeria_eats/features/products/models/product.dart';
import 'package:algeria_eats/features/products/views/components/carousel_component.dart';
import 'package:algeria_eats/features/products/views/components/comment_component.dart';
import 'package:algeria_eats/features/products/views/components/product_detail.dart';
import 'package:algeria_eats/features/products/views/components/product_theme.dart';
import 'package:algeria_eats/features/products/views/components/rating_and_verified_buyers_component.dart';
import 'package:algeria_eats/features/products/views/components/rating_bar.dart';
import 'package:algeria_eats/features/products/views/components/selectable_chip.dart';
import 'package:algeria_eats/features/reviews/models/review.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductScreen extends StatefulWidget {
  final Product product;

  const ProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  CartController cartController = Get.find<CartController>();
  int _quantity = 1;

  int? _selectedRating;

  void incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: CarouselWithIndicator(images: widget.product.images),
                  ),
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 12.0, bottom: 4.0),
                        height: 5,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                      TabBar(
                        indicatorColor: Colors.orange.shade300,
                        dividerColor: Colors.grey[200],
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey[700],
                        tabs: const [
                          Tab(text: 'Details du produit'),
                          Tab(text: 'Avis des clients'),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    height: Get.height * 0.5,
                    child: TabBarView(
                      children: [
                        ProductDetails(
                          product: widget.product,
                          decrementQuantity: decrementQuantity,
                          incrementQuantity: incrementQuantity,
                          quantity: _quantity,
                          cartController: cartController,
                        ),
                        SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12),
                            margin: const EdgeInsets.only(bottom: 12),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    RatingAndVerifiedBuyers(
                                        rating: widget.product.rating == null
                                            ? 0
                                            : widget.product.rating!.toDouble(),
                                        verifiedBuyers:
                                            widget.product.reviews?.length ??
                                                0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RatingBar(
                                            rating: 5,
                                            count: widget.product.reviews!
                                                .where((comment) =>
                                                    comment.rating == 5)
                                                .length),
                                        RatingBar(
                                            rating: 4,
                                            count: widget.product.reviews!
                                                .where((comment) =>
                                                    comment.rating == 4)
                                                .length),
                                        RatingBar(
                                            rating: 3,
                                            count: widget.product.reviews!
                                                .where((comment) =>
                                                    comment.rating == 3)
                                                .length),
                                        RatingBar(
                                            rating: 2,
                                            count: widget.product.reviews!
                                                .where((comment) =>
                                                    comment.rating == 2)
                                                .length),
                                        RatingBar(
                                            rating: 1,
                                            count: widget.product.reviews!
                                                .where((comment) =>
                                                    comment.rating == 1)
                                                .length),
                                      ],
                                    )
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey[200],
                                  height: 32,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SelectableChip(
                                        label: "All",
                                        onSelected: (value) {},
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      SelectableChip(
                                        label: "5",
                                        onSelected: (value) {
                                          setState(() {
                                            _selectedRating = value ? 5 : null;
                                          });
                                        },
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      SelectableChip(
                                        label: "4",
                                        onSelected: (value) {
                                          setState(() {
                                            _selectedRating = value ? 4 : null;
                                          });
                                        },
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      SelectableChip(
                                        label: "3",
                                        onSelected: (value) {
                                          setState(() {
                                            _selectedRating = value ? 3 : null;
                                          });
                                        },
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      SelectableChip(
                                        label: "2",
                                        onSelected: (value) {
                                          setState(() {
                                            _selectedRating = value ? 2 : null;
                                          });
                                        },
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      SelectableChip(
                                        label: "1",
                                        onSelected: (value) {
                                          setState(() {
                                            _selectedRating = value ? 1 : null;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                MyTheme.mediumVerticalPadding,
                                Column(
                                    children: widget.product.reviews!
                                        .where((review) =>
                                            _selectedRating == null ||
                                            review.rating == _selectedRating)
                                        .toList()
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                  int index = entry.key;
                                  Review review = entry.value;
                                  return Column(
                                    children: [
                                      if (index != 0)
                                        Divider(
                                            color: Colors.grey[300],
                                            height: 32),
                                      CommentComponent(review: review),
                                    ],
                                  );
                                }).toList())
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const BackArrowButton(),
          ],
        ),
      ),
    );
  }
}
