// ignore_for_file: must_be_immutable

import 'package:algeria_eats/features/cart/controllers/cart_controller.dart';
import 'package:algeria_eats/features/cart/models/cart_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartItemCard extends StatelessWidget {
  CartItemCard({Key? key, required this.cartItem}) : super(key: key);

  final CartItem cartItem;

  CartController cartController = Get.find<CartController>();

  @override
  build(BuildContext context) {
    return Dismissible(
      key: Key(cartItem.product.id.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          cartController.removeItem(cartItem.product);
          Get.snackbar(
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            "Supprimé du panier",
            "${cartItem.product.nom} est supprimé de votre panier",
            snackPosition: SnackPosition.TOP,
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
            duration: const Duration(milliseconds: 1200),
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(16),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 120,
                width: 120,
                child: CachedNetworkImage(
                  imageUrl: cartItem.product.images[0],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    cartItem.product.categorie == "sucree" ? "Sucrée" : "Salée",
                    style: const TextStyle(fontSize: 13, color: Colors.orange),
                  ),
                  Text(
                    cartItem.product.nom,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${cartItem.product.prix} DA",
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            GetX<CartController>(
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => {
                        controller.decrementQuantity(cartItem.product),
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.orangeAccent,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      margin: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        controller
                            .getCartItemQuantity(cartItem.product)
                            .toString(),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    InkWell(
                      onTap: () => {
                        controller.incrementQuantity(cartItem.product),
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.orangeAccent,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
