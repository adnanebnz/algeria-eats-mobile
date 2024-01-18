// ignore_for_file: file_names, avoid_print

import 'package:algeria_eats/constants.dart';
import 'package:algeria_eats/helpers/dio_exceptions.dart';
import 'package:algeria_eats/models/order.dart';
import 'package:dio/dio.dart';
import 'package:get/state_manager.dart';
//import 'dart:developer' as console show log;

class ArtisanController extends GetxController {
  RxList<Order> userOrders = <Order>[].obs;
  RxBool isLoading = false.obs;
  final dio = Dio();

  Future<List<Order>?> getOrders() async {
    try {
      isLoading.value = true;
      final response = await dio.get(
        '$apiUrl/orders',
        options: Options(headers: {
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
}
