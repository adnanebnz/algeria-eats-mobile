// ignore_for_file: file_names

import 'package:algeria_eats/models/user.dart';
import 'package:algeria_eats/utils/dio_exceptions.dart';
import 'package:algeria_eats/utils/dio_instance.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoggedIn = false.obs;
  Rx<User> user = User(
          adresse: "",
          created_at: "",
          email: "",
          id: null,
          image: "",
          nom: "",
          num_telephone: "",
          prenom: "",
          updated_at: "",
          wilaya: "")
      .obs;

  final box = GetStorage();
  final dio = DioInstance.getDio();

  @override
  void onInit() {
    super.onInit();
    me();
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    isLoading.value = true;

    try {
      final response = await dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      final responseData = response.data;

      String token = responseData['token'];
      List<String> parts = token.split('|');
      String trimmedToken = parts.length > 1 ? parts[1] : '';
      await box.write('token', trimmedToken);

      isLoggedIn.value = true;

      return responseData;
    } on DioException catch (e) {
      isLoggedIn.value = false;
      DioExceptions dioExceptions = DioExceptions.fromDioError(e);
      if (kDebugMode) {
        print('DioException: ${dioExceptions.message}');
      }
      return {
        'error': dioExceptions.message,
      };
    } finally {
      isLoading.value = false;
    }
  }

  Future<Map<String, dynamic>?> me() async {
    isLoading.value = true;
    final token = await getToken();
    try {
      final response = await dio.get(
        '/me',
      );

      if (response.statusCode != 200 || token == null) {
        isLoggedIn.value = false;
        update();
      } else {
        final responseData = response.data;
        // map the response to the user model
        user.value = User.fromJson(responseData['user']);
        isLoggedIn.value = true;
        isLoading.value = false;
        update();
        return responseData;
      }
    } on DioException catch (e) {
      DioExceptions dioExceptions = DioExceptions.fromDioError(e);
      if (kDebugMode) {
        print('DioException: ${dioExceptions.message}');
      }
      return {
        'error': dioExceptions.message,
      };
    }
    return null;
  }

  Future<String?> getToken() async {
    final token = await box.read('token');
    return token;
  }

  Future<void> logout() async {
    await dio.post(
      '/auth/logout',
    );
    await box.remove('token');
    isLoggedIn.value = false;
  }

  Future isTokenExpired(String token) async {
    final response = await dio.get(
      '/me',
    );
    if (response.statusCode == 401) {
      return true;
    }
    return false;
  }

  Future refreshToken() async {
    final response = await dio.post(
      '/auth/refresh',
    );
    return response.data['token'];
  }
}
