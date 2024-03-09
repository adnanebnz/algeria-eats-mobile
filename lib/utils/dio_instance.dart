import 'package:algeria_eats/constants.dart';
import 'package:algeria_eats/controllers/authController.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'dio_exceptions.dart';
import 'error_snackbar.dart';

class DioInstance {
  static final AuthController authController = AuthController();
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: apiUrl,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${GetStorage().read('token')}',
    },
  ))
    ..interceptors.add(InterceptorsWrapper(
      onError: (DioException error, ErrorInterceptorHandler handler) {
        DioExceptions dioExceptions = DioExceptions.fromDioError(error);

        ErrorSnackBar.show(dioExceptions.message, 'error');

        handler.next(error);
      },
      onRequest: (options, handler) async {
        String? token = GetStorage().read('token');
        if (token != null) {
          if (await authController.isTokenExpired(token)) {
            String newToken = await authController.refreshToken();
            GetStorage().write('token', newToken);
            token = newToken;
          }
          options.headers['Bearer'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ))
    ..interceptors.add(PrettyDioLogger());

  static Dio getDio() {
    return _dio;
  }
}
