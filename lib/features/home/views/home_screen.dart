import 'package:algeria_eats/features/auth/controllers/auth_controller.dart';
import 'package:algeria_eats/features/cart/controllers/cart_controller.dart';
import 'package:algeria_eats/features/cart/views/cart_screen.dart';
import 'package:algeria_eats/features/products/views/categories_view.dart';
import 'package:algeria_eats/features/products/views/featured_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthController authController = Get.find<AuthController>();
  CartController cartController = Get.find<CartController>();
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            margin: const EdgeInsets.only(left: 12.0, right: 12.0, top: 14.0),
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Trouver votre \nPlat préféré",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[900]),
                    ),
                  ],
                ),
                const Spacer(),
                Obx(
                  () => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[100],
                    ),
                    child: Badge(
                      backgroundColor: Colors.orangeAccent,
                      label: Text(
                        cartController.cartItems.length.toString(),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Get.to(() => const CartScreen());
                        },
                        icon: const Icon(Icons.shopping_bag_outlined),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const CategoriesView(),
          FeaturedProductsScreen(),
        ],
      ),
    );
  }
}
