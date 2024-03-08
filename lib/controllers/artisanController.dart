// ignore_for_file: file_names, avoid_print

import 'package:algeria_eats/constants.dart';
import 'package:algeria_eats/models/artisan.dart';
import 'package:algeria_eats/models/product.dart';
import 'package:algeria_eats/utils/dio_exceptions.dart';
import 'package:algeria_eats/utils/dio_instance.dart';
import 'package:dio/dio.dart';
import 'package:get/state_manager.dart';

class ArtisanController extends GetxController {
  RxList<Artisan> artisans = <Artisan>[].obs;
  RxList<Product> artisanProducts = <Product>[].obs;
  RxBool isLoading = false.obs;
  final dio = DioInstance.instance.getDio();

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

  Future<Map<String, dynamic>> getArtisans() async {
    try {
      isLoading.value = true;
      final response = await dio.get(
        '$apiUrl/artisans',
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );

      final responseData = response.data;
      artisans.value = (responseData['artisans'] as List<dynamic>)
          .map((artisanJson) => Artisan.fromJson(artisanJson))
          .toList();

      isLoading.value = false;
      return responseData;
    } catch (e) {
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

  Future<Map<String, dynamic>?> getArtisanProducts(Artisan artisan) async {
    try {
      isLoading.value = true;
      final response = await dio.get(
        '/products?artisan=${artisan.user.nom} ${artisan.user.prenom}',
      );

      final responseData = response.data;
      artisanProducts.value = (responseData['products'] as List<dynamic>)
          .map((productJson) => Product.fromJson(productJson))
          .toList();

      isLoading.value = false;
      return responseData;
    } catch (e) {
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
