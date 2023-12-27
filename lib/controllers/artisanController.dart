import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:developer' as console show log;

class ArtisanController extends GetxController {
  //login user
  Future login(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final dio = Dio();
    try {
      final response = await dio.post(
        'http://10.0.2.2:8000/api/auth/login',
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
        data: {
          'email': email,
          'password': password,
        },
      );
      final token = json.encode(response.data['token']);
      await prefs.setString('token', token);
      return response.data;
    } catch (e) {
      return e.toString();
    }
  }

  Future getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token;
  }
}
