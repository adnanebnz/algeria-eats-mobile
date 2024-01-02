import 'package:algeria_eats/controllers/cartController.dart';
import 'package:algeria_eats/screens/categories_view.dart';
import 'package:algeria_eats/screens/featured_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:algeria_eats/controllers/authController.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthController authController = Get.put(AuthController());
  CartController cartController = Get.put(CartController());
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[50],
          ),
          margin: const EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0),
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Find your \nFavorite Food",
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
                () => badges.Badge(
                  badgeStyle:
                      const badges.BadgeStyle(badgeColor: Colors.orangeAccent),
                  badgeContent: Text(
                    cartController.cartItems.length.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  position: badges.BadgePosition.topEnd(top: -5, end: 1),
                  child: IconButton(
                    onPressed: () {
                      // TODO NAVIGATE TO CART SCREEN
                    },
                    icon: const Icon(Icons.shopping_bag_outlined),
                  ),
                ),
              ),
            ],
          ),
        ),
        const CategoriesView(),
        FeaturedProductsScreen(),
      ],
    );
  }
}
