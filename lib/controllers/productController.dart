// ignore_for_file: file_names, avoid_print

import 'package:algeria_eats/constants.dart';
import 'package:algeria_eats/models/product.dart';
import 'package:algeria_eats/utils/dio_exceptions.dart';
import 'package:algeria_eats/utils/dio_instance.dart';
import 'package:algeria_eats/utils/error_snackbar.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
// import 'dart:developer' as console show log;

class ProductController extends GetxController {
  RxList<Product> products = <Product>[].obs;
  RxList<Product> featuredProducts = <Product>[].obs;
  RxInt sweetProductsCount = 0.obs;
  RxInt saltyProductsCount = 0.obs;
  RxBool isLoading = true.obs;

  final dio = DioInstance.getDio();

  @override
  void onInit() {
    super.onInit();
    getAllProducts();
    getFeaturedProducts();
  }

  @override
  void onClose() {
    products.clear();
    featuredProducts.clear();
    super.onClose();
  }

  Future getAllProducts() async {
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
    } catch (e) {
      isLoading.value = false;
      if (e is DioExceptions) {
        ErrorSnackBar.show(e.message, "error");
      } else {
        ErrorSnackBar.show("Something wrong happened!", "error");
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future getFeaturedProducts() async {
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
    } catch (e) {
      isLoading.value = false;
      if (e is DioExceptions) {
        ErrorSnackBar.show(e.message, "error");
      } else {
        ErrorSnackBar.show("Something wrong happened!", "error");
      }
    } finally {
      isLoading.value = false;
    }
  }
}
