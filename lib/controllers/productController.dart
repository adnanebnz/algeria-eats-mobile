// ignore_for_file: file_names, avoid_print

import 'package:algeria_eats/constants.dart';
import 'package:algeria_eats/helpers/dio_exceptions.dart';
import 'package:algeria_eats/models/product.dart';
import 'package:dio/dio.dart';
import 'package:get/state_manager.dart';
// import 'dart:developer' as console show log;

class ProductController extends GetxController {
  RxList<Product> products = <Product>[].obs;
  RxList<Product> featuredProducts = <Product>[].obs;
  RxInt sweetProductsCount = 0.obs;
  RxInt saltyProductsCount = 0.obs;
  RxBool isLoading = true.obs;
  final dio = Dio();

  Future<Map<String, dynamic>?> getAllProducts() async {
    try {
      isLoading.value = true;
      final response = await dio.get(
        '$apiUrl/products',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }),
      );

      final responseData = response.data;

      products.value =
          (responseData['products'] as List<dynamic>).map((productJson) {
        return Product.fromJson(productJson);
      }).toList();

      for (var product in products) {
        if (product.categorie == 'sucree') {
          sweetProductsCount.value++;
        } else {
          saltyProductsCount.value++;
        }
      }

      return responseData;
    } catch (e) {
      isLoading.value = false;
      if (e is DioExceptions) {
        print('DioException: ${e.message}');
      } else {
        print('Exception: $e');
      }
      return {
        'error': e.toString(),
      };
    } finally {
      isLoading.value = false;
    }
  }

  Future<Map<String, dynamic>?> getFeaturedProducts() async {
    try {
      isLoading.value = true;
      final response = await dio.get(
        '$apiUrl/products/featured',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }),
      );

      final responseData = response.data;

      featuredProducts.value =
          (responseData['products'] as List<dynamic>).map((productJson) {
        return Product.fromJson(productJson);
      }).toList();

      return responseData;
    } catch (e) {
      isLoading.value = false;
      if (e is DioExceptions) {
        print('DioException: ${e.message}');
      } else {
        print('Exception: $e');
      }
      return {
        'error': e.toString(),
      };
    } finally {
      isLoading.value = false;
    }
  }
}
