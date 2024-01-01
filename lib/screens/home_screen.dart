import 'package:algeria_eats/screens/categories_view.dart';
import 'package:algeria_eats/screens/featured_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:algeria_eats/controllers/authController.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthController authController = Get.put(AuthController());
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 8.0, left: 8.0, top: 12.0),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          height: MediaQuery.of(context).size.height * 0.15,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(10, 10),
                    blurRadius: 50,
                    spreadRadius: 0,
                    color: Colors.grey.withOpacity(.1)),
              ],
              color: Colors.white),
          child: Obx(() {
            if (authController.isLoading.value) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: const Text(
                      "Bienvenue",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: const Text(
                      "Nom Prenom",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Bienvenue",
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    "${authController.user.value.nom} ${authController.user.value.prenom}",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87),
                  ),
                ],
              );
            }
          }),
        ),
        const CategoriesView(),
        FeaturedProductsScreen(),
      ],
    );
  }
}
