// ignore_for_file: library_private_types_in_public_api

import 'package:algeria_eats/components/rating_view.dart';
import 'package:algeria_eats/controllers/cartController.dart';
import 'package:algeria_eats/models/product.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 1,
        leading: BackButton(color: MyTheme.catalogueButtonColor),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: Column(children: [
                Expanded(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: double.infinity,
                      enableInfiniteScroll: true,
                    ),
                    items: widget.product.images.map((image) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 6.0),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16.0)),
                              child: Image.network(
                                image,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              ]),
            ),
          ),
          MyTheme.smallVerticalPadding,
          Expanded(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(32.0))),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.product.nom,
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold)),
                            RatingView(
                              iconSize: 20,
                              fontSize: 20,
                              value: widget.product.rating?.toInt() ?? 0,
                            ),
                          ],
                        ),
                        Text("${widget.product.prix} DA",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    MyTheme.mediumVerticalPadding,
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(widget
                                  .product.artisan.user.image ??
                              'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                  "${widget.product.artisan.user.nom} ${widget.product.artisan.user.prenom}",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ),
                            RatingView(
                              iconSize: 18,
                              fontSize: 18,
                              value: widget.product.artisan.rating.toInt(),
                            ),
                          ],
                        ),
                      ],
                    ),
                    MyTheme.mediumVerticalPadding,
                    Text(widget.product.description,
                        style: TextStyle(fontSize: 14, color: MyTheme.grey)),
                    MyTheme.mediumVerticalPadding,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0)),
                            border: Border.all(
                                color: Colors.grey[350]!,
                                width: 1.5), // Add an outline
                          ),
                          child: IconButton(
                            onPressed: decrementQuantity,
                            icon: const Icon(Icons.remove),
                            color: Colors.grey[700]!,
                            iconSize: 24.0,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          height: 51,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                  color: Colors.grey[350]!,
                                  width: 1.5), // Add top border
                              bottom: BorderSide(
                                  color: Colors.grey[350]!,
                                  width: 1.5), // Add bottom border
                            ),
                          ),
                          child: Center(
                            child: Text(
                              _quantity.toString(),
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0)),
                            border: Border.all(
                                color: Colors.grey[350]!,
                                width: 1.5), // Add an outline
                          ),
                          child: IconButton(
                            onPressed: incrementQuantity,
                            icon: const Icon(Icons.add),
                            color: Colors.grey[700]!,
                            iconSize: 24.0,
                          ),
                        ),
                      ],
                    ),
                    MyTheme.mediumVerticalPadding,
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
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
                                cartController.addItem(
                                    widget.product, _quantity);

                                Get.snackbar(
                                  "Produit ajouté au panier",
                                  "${widget.product.nom} a été ajouté au panier",
                                  backgroundColor: Colors.green,
                                  duration: const Duration(milliseconds: 1500),
                                  icon: const Icon(
                                    Icons.check_circle,
                                    color: Colors.white,
                                  ),
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.TOP,
                                );
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                      ],
                    )
                  ],
                ),
              ),
            ),
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
