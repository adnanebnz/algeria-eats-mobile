import 'package:algeria_eats/components/cart_item_card.dart';
import 'package:algeria_eats/controllers/cartController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 1,
        leading: const BackButton(color: Colors.black),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: GetX<CartController>(
            builder: (controller) {
              if (controller.cartItems.isEmpty) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/images/empty.svg",
                        height: MediaQuery.of(context).size.height * 0.25),
                    const SizedBox(height: 20),
                    Text(
                      "Votre panier est vide",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[900]),
                    ),
                  ],
                ));
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: controller.cartItems.length,
                      itemBuilder: (context, index) {
                        return CartItemCard(
                          cartItem: controller.cartItems[index],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 10);
                      },
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(251, 146, 60, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Text('Total: ${controller.total.value} DA',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500))),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
