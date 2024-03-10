// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:developer';

import 'package:algeria_eats/core/managers/dio_instance.dart';
import 'package:algeria_eats/features/auth/controllers/authController.dart';
import 'package:algeria_eats/features/cart/controllers/cartController.dart';
import 'package:algeria_eats/features/order/models/order.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../cart/models/cartItem.dart';

class OrderController extends GetxController {
  CartController cartController = Get.find<CartController>();
  AuthController authController = Get.find<AuthController>();
  RxList<Order> userOrders = <Order>[].obs;
  RxBool isLoading = false.obs;
  final dio = DioInstance.getDio();

  @override
  void onInit() {
    super.onInit();
    getOrders();
  }

  @override
  void onClose() {
    userOrders.clear();
    super.onClose();
  }

  Future<void> getOrders() async {
    try {
      isLoading.value = true;
      final response = await dio.get(
        '/orders',
      );

      final responseData = response.data;
      userOrders.value = (responseData['orders'] as List<dynamic>)
          .map((orderJson) => Order.fromJson(orderJson))
          .toList();
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> makeOrder(
      String adresse, String wilaya, String daira, String commune) async {
    try {
      isLoading.value = true;

      // Group the cart items by artisan ID
      Map<int, List<CartItem>> groupedItems = {};
      for (var item in cartController.cartItems) {
        int? artisanId = item.product.artisan?.user_id;
        if (!groupedItems.containsKey(artisanId)) {
          groupedItems[artisanId!] = [];
        }
        groupedItems[artisanId]?.add(item);
      }

      // Create an order for each group
      for (var entry in groupedItems.entries) {
        List<Map<String, dynamic>> orderItems = entry.value
            .map((item) => {
                  'product_id': item.product.id,
                  'quantity': item.quantity,
                })
            .toList();

        var response = await dio.post(
          '/orders',
          data: {
            'artisan_id': entry.key,
            'adresse': adresse,
            'wilaya': wilaya,
            'daira': daira,
            'commune': commune,
            'orderItems': orderItems,
          },
        );

        if (response.statusCode == 200) {
          cartController.cartItems.clear();
          Get.toNamed("/order-success");
          //TODO CREATE ROTUE
        } else {
          Get.toNamed('/order-error');
          //TODO CREATE ROTUE
        }
      }
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }
      Get.toNamed('/order-error');
      //TODO CREATE ROTUE
    } finally {
      isLoading.value = false;
    }
  }
}