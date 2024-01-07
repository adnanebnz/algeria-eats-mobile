// ignore_for_file: file_names, avoid_print

import 'package:algeria_eats/constants.dart';
import 'package:algeria_eats/models/artisan.dart';
import 'package:dio/dio.dart';
import 'package:get/state_manager.dart';
// import 'dart:developer' as console show log;

class ArtisanController extends GetxController {
  RxList<Artisan> artisans = <Artisan>[].obs;
  RxBool isLoading = false.obs;
  final dio = Dio();

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
      print(e.toString());
      return {
        'error': e.toString(),
      };
    } finally {
      isLoading.value = false;
    }
  }
}
