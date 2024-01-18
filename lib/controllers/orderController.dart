// ignore_for_file: file_names, avoid_print, non_constant_identifier_names

import 'package:algeria_eats/constants.dart';
import 'package:algeria_eats/controllers/authController.dart';
import 'package:algeria_eats/controllers/cartController.dart';
import 'package:algeria_eats/helpers/dio_exceptions.dart';
import 'package:algeria_eats/models/order.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
//import 'dart:developer' as console show log;

class OrderController extends GetxController {
  CartController cartController = Get.put(CartController());
  AuthController authController = Get.put(AuthController());
  RxList<Order> userOrders = <Order>[].obs;
  RxBool isLoading = false.obs;
  final dio = Dio();

  Future<List<Order>?> getOrders() async {
    try {
      var token = await authController.getToken();
      isLoading.value = true;
      final response = await dio.get(
        '$apiUrl/orders',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }),
      );

      final responseData = response.data;
      userOrders.value = (responseData['orders'] as List<dynamic>)
          .map((orderJson) => Order.fromJson(orderJson))
          .toList();

      isLoading.value = false;
      return responseData;
    } catch (e) {
      if (e is DioExceptions) {
        print('DioException: ${e.message}');
      } else {
        print('Exception: $e');
      }
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> makeOrder(
      String adresse, String wilaya, String daira, String commune) async {
    try {
      var token = await authController.getToken();
      print(token);
      isLoading.value = true;

      for (var item in cartController.cartItems) {
        final response = await dio.post(
          '$apiUrl/orders',
          data: {
            'artisan_id': item.product.artisan.user_id,
            'adresse': adresse,
            'wilaya': wilaya,
            'daira': daira,
            'commune': commune,
            'order_items': [
              {
                'product_id': item.product.id,
                'quantity': item.quantity,
              }
            ]
          },
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
            // Add these options to handle redirections
            followRedirects: true,
            maxRedirects:
                5, // Set the maximum number of redirections you want to allow
          ),
        );

        final responseData = response.data;
        print(responseData);
        print(response);
      }

      isLoading.value = false;
    } catch (e) {
      if (e is DioExceptions) {
        print('DioException: ${e.message}');
      } else {
        print('Exception: $e');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
