import 'package:algeria_eats/core/managers/dio_instance.dart';
import 'package:algeria_eats/features/artisans/models/artisan.dart';
import 'package:algeria_eats/features/auth/controllers/auth_controller.dart';
import 'package:algeria_eats/features/products/models/product.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ArtisanController extends GetxController {
  RxList<Artisan> artisans = <Artisan>[].obs;
  RxList<Artisan> neirestArtisans = <Artisan>[].obs;
  RxList<Product> artisanProducts = <Product>[].obs;
  RxBool isLoading = false.obs;
  final dio = DioInstance.getDio();

  @override
  void onInit() {
    super.onInit();
    getArtisans();
    getNeirestArtisans();
  }

  @override
  void onClose() {
    artisans.clear();
    artisanProducts.clear();

    super.onClose();
  }

  Future<List<Artisan>?> getNeirestArtisans() async {
    try {
      isLoading.value = true;
      final response = await dio.get('/neirest-artisans',
          data: {"user_id": Get.find<AuthController>().user.value.id});

      final responseData = response.data;
      neirestArtisans.value = (responseData['artisans'] as List<dynamic>)
          .map((artisanJson) =>
              Artisan.fromJson(artisanJson as Map<String, dynamic>))
          .toList();

      isLoading.value = false;
      return neirestArtisans;
    } catch (e) {
      if (kDebugMode) {
        printError(info: e.toString());
      }
    } finally {
      isLoading.value = false;
    }
    return null;
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
      }
    } finally {
      isLoading.value = false;
    }
    return null;
  }
}
