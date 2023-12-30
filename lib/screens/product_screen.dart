// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:algeria_eats/controllers/cartController.dart';
import 'package:algeria_eats/components/rating_view.dart';
import 'package:algeria_eats/models/cart.dart';
import 'package:algeria_eats/models/product.dart';

class ProductScreen extends StatefulWidget {
  final Product product;

  const ProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  CartController cartController = Get.put(CartController());
  int _quantity = 1;

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
  void initState() {
    cartController.calculateTotal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.courseCardColor,
      appBar: AppBar(
        elevation: 0,
        leading: BackButton(color: MyTheme.catalogueButtonColor),
      ),
      body: Stack(
        children: [
          Column(children: [
            Expanded(
              flex: 35,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: double.infinity,
                  enableInfiniteScroll: false,
                  viewportFraction: 1.0,
                ),
                items: widget.product.images.map((image) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Center(
                        child: Image.network(
                          image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            const Spacer(
              flex: 65,
            )
          ]),
          DraggableScrollableSheet(
            initialChildSize: 0.65,
            minChildSize: 0.65,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(32.0))),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    controller: scrollController,
                    children: [
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color: MyTheme.grey.withOpacity(0.5),
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(1.0))),
                          height: 4,
                          width: 48,
                        ),
                      ),
                      MyTheme.mediumVerticalPadding,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.product.nom,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
                              RatingView(
                                iconSize: 22,
                                fontSize: 22,
                                value: widget.product.rating?.toInt() ?? 0,
                              ),
                            ],
                          ),
                          Text("${widget.product.prix} DA",
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      MyTheme.mediumVerticalPadding,
                      Text(widget.product.description,
                          style: TextStyle(fontSize: 16, color: MyTheme.grey)),
                      MyTheme.mediumVerticalPadding,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: decrementQuantity,
                            icon: const Icon(Icons.remove),
                            color: MyTheme.catalogueButtonColor,
                          ),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              _quantity.toString(),
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ),
                          IconButton(
                            onPressed: incrementQuantity,
                            icon: const Icon(Icons.add),
                            color: MyTheme.catalogueButtonColor,
                          ),
                        ],
                      ),
                      MyTheme.smallVerticalPadding,
                      Row(
                        children: [
                          const Spacer(
                            flex: 2,
                          ),
                          Expanded(
                              flex: 5,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  backgroundColor: Colors.orangeAccent,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0, horizontal: 20.0),
                                ),
                                onPressed: () {
                                  CartItems cartItem = CartItems(
                                    id: widget.product.id,
                                    nom: widget.product.nom,
                                    quantity: 1,
                                    prix: widget.product.prix,
                                  );

                                  cartController.addToCart(cartItem);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Item added to cart'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.shopping_cart,
                                      color: Colors.white,
                                      size: 22.0,
                                    ),
                                    SizedBox(width: 4.0),
                                    Text(
                                      "Ajouter au panier",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          const Spacer(
                            flex: 2,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MyTheme {
  static Color get backgroundColor => const Color(0xFFF7F7F7);
  static Color get grey => const Color(0xFF999999);
  static Color get catalogueCardColor =>
      const Color(0xFFBAE5D4).withOpacity(0.5);
  static Color get catalogueButtonColor => const Color(0xFF29335C);
  static Color get courseCardColor => const Color(0xFFEDF1F1);
  static Color get progressColor => const Color(0xFF36F1CD);

  static Padding get largeVerticalPadding =>
      const Padding(padding: EdgeInsets.only(top: 32.0));

  static Padding get mediumVerticalPadding =>
      const Padding(padding: EdgeInsets.only(top: 16.0));

  static Padding get smallVerticalPadding =>
      const Padding(padding: EdgeInsets.only(top: 8.0));

  static ThemeData get theme => ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blueGrey,
      ).copyWith(
        cardTheme: const CardTheme(
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0)))),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0.0),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
                catalogueButtonColor), // Button color
            foregroundColor: MaterialStateProperty.all<Color>(
                Colors.white), // Text and icon color
          ),
        ),
      );
}
