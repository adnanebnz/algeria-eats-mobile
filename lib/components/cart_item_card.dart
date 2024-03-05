import 'package:algeria_eats/controllers/cartController.dart';
import 'package:algeria_eats/models/cartItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartItemCard extends StatefulWidget {
  const CartItemCard({Key? key, required this.cartItem}) : super(key: key);

  final CartItem cartItem;

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.cartItem.product.id.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          cartController.removeFromCart(widget.cartItem);
          Get.snackbar(
            "Supprimé du panier",
            "${widget.cartItem.product.nom} est supprimé de votre panier",
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
                child: Image.network(
                  widget.cartItem.product.images[0],
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
                    widget.cartItem.product.categorie == "sucree"
                        ? "Sucrée"
                        : "Salée",
                    style: const TextStyle(fontSize: 13, color: Colors.orange),
                  ),
                  Text(
                    widget.cartItem.product.nom,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${widget.cartItem.product.prix} DA",
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
                        controller.decrementItem(widget.cartItem),
                        setState(() {})
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
                            .getCartItemQuantity(widget.cartItem)
                            .toString(),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    InkWell(
                      onTap: () => {
                        controller.incrementItem(widget.cartItem),
                        setState(() {})
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
