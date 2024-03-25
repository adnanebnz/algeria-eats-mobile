import 'dart:developer' show log;

import 'package:algeria_eats/core/managers/dio_instance.dart';
import 'package:algeria_eats/core/managers/token_manager.dart';
import 'package:algeria_eats/features/auth/models/user.dart';
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
  final TokenManager _tokenManager = TokenManager();

  @override
  void onInit() async {
    super.onInit();
    String? token = await _tokenManager.getToken();
    if (token != null) {
      await me();
      await saveFcmToken();
    }
  }

  Future<void> saveFcmToken() async {
    try {
      String fcmKey = await box.read("fcm_key");
      await dio.post('/device-key',
          data: {'fcm_key': fcmKey, 'user_id': user.value.id});
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }
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

      await _tokenManager.trimAndSaveToken(token);

      user.value = User.fromJson(responseData['user']);
      Get.offAllNamed("/main");
      isLoggedIn.value = true;
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future register() async {
    try {
      isLoading.value = true;
      // final response = await dio.post("/auth/register", data: {});
      // TODO FINISH METHOD
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future me() async {
    try {
      isLoading.value = true;
      final response = await dio.get(
        '/me',
      );

      if (response.statusCode != 200) {
        isLoggedIn.value = false;
      } else {
        final responseData = response.data;
        user.value = User.fromJson(responseData['user']);
        isLoggedIn.value = true;
        return user;
      }
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await dio.post(
      '/auth/logout',
    );
    await _tokenManager.removeToken();
    isLoggedIn.value = false;
  }

  Future<void> refreshToken() async {
    final response = await dio.post(
      '/auth/refresh',
    );
    final token = response.data['token'];
    await _tokenManager.updateToken(token);
  }
}
