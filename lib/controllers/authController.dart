// ignore_for_file: file_names, avoid_print

import 'package:algeria_eats/constants.dart';
import 'package:algeria_eats/models/user.dart';
import 'package:dio/dio.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  final dio = Dio();

  Future<Map<String, dynamic>> login(String email, String password) async {
    isLoading.value = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();

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

      final token = responseData['token'];
      await prefs.setString('token', token);
      return responseData;
    } catch (e) {
      return {
        'error': e.toString(),
      };
    } finally {
      isLoggedIn.value = true;
      isLoading.value = false;
    }
  }

  Future<Map<String, dynamic>> me() async {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      final response = await dio.get(
        '$apiUrl/me',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        }),
      );

      final responseData = response.data;
      // map the response to the user model
      user.value = User.fromJson(responseData['user']);

      isLoading.value = false;
      return responseData;
    } catch (e) {
      print(e.toString());
      return {
        'error': e.toString(),
      };
    }
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token;
  }

  Future<bool> checkIsLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      isLoggedIn.value = true;
      return true;
    } else {
      isLoggedIn.value = false;
      return false;
    }
  }

  void setLoggedIn(bool value) {
    isLoggedIn.value = value;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    await dio.post(
      '$apiUrl/auth/logout',
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      }),
    );
    await prefs.remove('token');
    isLoggedIn.value = false;
  }
}
