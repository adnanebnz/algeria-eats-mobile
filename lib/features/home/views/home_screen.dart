import 'package:algeria_eats/components/nearest_artisan_profile.dart';
import 'package:algeria_eats/components/neirest_artisans_shimmer.dart';
import 'package:algeria_eats/features/artisans/controllers/artisan_controller.dart';
import 'package:algeria_eats/features/auth/controllers/auth_controller.dart';
import 'package:algeria_eats/features/cart/controllers/cart_controller.dart';
import 'package:algeria_eats/features/cart/views/cart_screen.dart';
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
  ArtisanController artisanController = Get.find<ArtisanController>();

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
                Row(
                  children: [
                    Badge(
                      isLabelVisible: false,
                      backgroundColor: Colors.red[400],
                      offset: const Offset(0, 3),
                      label: const Text("1"),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notifications_none_rounded,
                          )),
                    ),
                    Obx(
                      () => Badge(
                        offset: const Offset(0, 3),
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
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.green.shade400,
                    borderRadius: BorderRadius.circular(16)),
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Claim Your Daily \nfree delivery now!",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          FilledButton(
                              style: ButtonStyle(
                                  //white button
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.grey[50]!)),
                              onPressed: () {},
                              child: const Text(
                                'Order now',
                                style: TextStyle(color: Colors.black),
                              ))
                        ],
                      ),
                      Expanded(
                        child: Image.asset(
                          fit: BoxFit.cover,
                          'assets/images/food-plate.png',
                          height: MediaQuery.of(context).size.height * 0.16,
                        ),
                      ),
                    ]),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Artisans proches de vous",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            child: Obx(() {
              if (artisanController.neirestArtisans.isEmpty) {
                return const NeirestArtisansShimmer();
              }

              return ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  width: 5,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: artisanController.neirestArtisans.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: NeirestArtisanProfile(
                      artisan: artisanController.neirestArtisans[index],
                    ),
                  );
                },
              );
            }),
          ),
          const SizedBox(
            height: 8,
          ),
          const FeaturedProductsScreen(),
        ],
      ),
    );
  }
}
