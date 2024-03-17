import 'package:algeria_eats/components/rating_view.dart';
import 'package:algeria_eats/features/cart/controllers/cart_controller.dart';
import 'package:algeria_eats/features/products/models/product.dart';
import 'package:algeria_eats/features/products/views/components/product_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  final VoidCallback decrementQuantity;
  final VoidCallback incrementQuantity;
  final int quantity;
  final CartController cartController;

  const ProductDetails({
    super.key,
    required this.product,
    required this.decrementQuantity,
    required this.incrementQuantity,
    required this.quantity,
    required this.cartController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.nom,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600)),
                  RatingView(
                    iconSize: 18,
                    fontSize: 18,
                    value: product.rating?.toInt() ?? 0,
                  ),
                ],
              ),
              Text("${product.prix} DA",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.orangeAccent)),
            ],
          ),
          MyTheme.mediumVerticalPadding,
          Row(
            children: [
              Builder(builder: (context) {
                if (product.artisan?.user.image != null) {
                  return CircleAvatar(
                    radius: 23,
                    backgroundImage: NetworkImage(
                      product.artisan!.user.image!,
                    ),
                  );
                } else {
                  return const CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 23,
                    backgroundImage: AssetImage(
                      'assets/images/profile-pic.png',
                    ),
                  );
                }
              }),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                        "${product.artisan?.user.nom} ${product.artisan?.user.prenom}",
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600)),
                  ),
                  RatingView(
                    iconSize: 16,
                    fontSize: 16,
                    value: product.artisan!.rating.toInt(),
                  ),
                ],
              ),
            ],
          ),
          MyTheme.mediumVerticalPadding,
          Text(product.description,
              style: TextStyle(fontSize: 13, color: MyTheme.grey)),
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
                      color: Colors.grey[350]!, width: 1.5), // Add an outline
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
                        color: Colors.grey[350]!, width: 1.5), // Add top border
                    bottom: BorderSide(
                        color: Colors.grey[350]!,
                        width: 1.5), // Add bottom border
                  ),
                ),
                child: Center(
                  child: Text(
                    quantity.toString(),
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
                      color: Colors.grey[350]!, width: 1.5), // Add an outline
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
          MyTheme.largeVerticalPadding,
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.orangeAccent),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                onPressed: () {
                  cartController.addItem(product, quantity);

                  Get.snackbar(
                    isDismissible: true,
                    dismissDirection: DismissDirection.horizontal,
                    "Produit ajouté au panier",
                    "${product.nom} a été ajouté au panier",
                    backgroundColor: Colors.green,
                    duration: const Duration(milliseconds: 2000),
                    icon: const Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    ),
                    colorText: Colors.white,
                    snackPosition: SnackPosition.TOP,
                  );
                },
                icon: const Icon(Icons.shopping_cart),
                label: const Text("Ajouter au panier")),
          ),
        ],
      ),
    );
  }
}
