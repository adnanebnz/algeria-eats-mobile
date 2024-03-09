// ignore_for_file: file_names

import 'dart:developer' show log;

import 'package:algeria_eats/features/auth/models/user.dart';
import 'package:algeria_eats/core/managers/dio_instance.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
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
  void onInit() async {
    super.onInit();
    String? token = await getToken();
    if (token != null) {
      await me();
    }
  }

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
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

      user.value = User.fromJson(responseData['user']);
      Get.offAllNamed("/home");
      isLoggedIn.value = true;
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future me() async {
    isLoading.value = true;
    final token = await getToken();
    final response = await dio.get(
      '/me',
    );

    if (response.statusCode != 200 || token == null) {
      isLoggedIn.value = false;
    } else {
      final responseData = response.data;
      user.value = User.fromJson(responseData['user']);
      isLoggedIn.value = true;
      isLoading.value = false;
      return user;
    }
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
