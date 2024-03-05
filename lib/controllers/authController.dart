// ignore_for_file: file_names, avoid_print

import 'package:algeria_eats/constants.dart';
import 'package:algeria_eats/models/user.dart';
import 'package:algeria_eats/utils/dio_exceptions.dart';
import 'package:algeria_eats/utils/dio_instance.dart';
import 'package:dio/dio.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
// import 'dart:developer' as console show log;

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
        '$apiUrl/auth/login',
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
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
    } catch (e) {
      isLoggedIn.value = false;
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

  Future<Map<String, dynamic>?> me() async {
    isLoading.value = true;
    final token = await getToken();
    try {
      final response = await dio.get(
        '$apiUrl/me',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        }),
      );

      if (response.statusCode != 200 || token == null) {
        isLoggedIn.value = false;
      } else {
        final responseData = response.data;
        // map the response to the user model
        user.value = User.fromJson(responseData['user']);
        isLoggedIn.value = true;
        isLoading.value = false;
        return responseData;
      }
    } catch (e) {
      if (e is DioExceptions) {
        print('DioException: ${e.message}');
      } else {
        print('Exception: $e');
      }
      return {
        'error': e.toString(),
      };
    }
    return null;
  }

  Future<String?> getToken() async {
    final token = await box.read('token');
    return token;
  }

  Future<void> logout() async {
    final token = await box.read('token');
    await dio.post(
      '$apiUrl/auth/logout',
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      }),
    );
    await box.remove('token');
    isLoggedIn.value = false;
  }
}
