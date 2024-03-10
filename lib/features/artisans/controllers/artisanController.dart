// ignore_for_file: file_names, avoid_print

import 'dart:developer';

import 'package:algeria_eats/core/managers/dio_instance.dart';
import 'package:algeria_eats/features/artisans/models/artisan.dart';
import 'package:algeria_eats/features/products/models/product.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ArtisanController extends GetxController {
  RxList<Artisan> artisans = <Artisan>[].obs;
  RxList<Product> artisanProducts = <Product>[].obs;
  RxBool isLoading = false.obs;
  final dio = DioInstance.getDio();

  @override
  void onInit() {
    super.onInit();
    getArtisans();
  }

  @override
  void onClose() {
    artisans.clear();
    artisanProducts.clear();

    super.onClose();
  }

  Future<List<Artisan>?> getArtisans() async {
    try {
      isLoading.value = true;
      final response = await dio.get(
        '/artisans',
      );

      final responseData = response.data;
      artisans.value = (responseData['artisans'] as List<dynamic>)
          .map((artisanJson) =>
              Artisan.fromJson(artisanJson as Map<String, dynamic>))
          .toList();

      isLoading.value = false;
      return artisans;
    } catch (e) {
      if (kDebugMode) {
        printError(info: e.toString());
        //TODO interesting
      }
    } finally {
      isLoading.value = false;
    }
    return null;
  }

  Future<List<Product>?> getArtisanProducts(Artisan artisan) async {
    try {
      isLoading.value = true;
      final response = await dio.get(
        '/products?artisan=${artisan.user.nom} ${artisan.user.prenom}',
      );

      final responseData = response.data;
      artisanProducts.value = (responseData['products'] as List<dynamic>)
          .map((productJson) => Product.fromJson(productJson))
          .toList();

      return artisanProducts;
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }
    } finally {
      isLoading.value = false;
    }
    return null;
  }
}
