import 'package:algeria_eats/constants.dart';
import 'package:algeria_eats/controllers/authController.dart';
import 'package:algeria_eats/utils/dio_exceptions.dart';
import 'package:algeria_eats/utils/error_snackbar.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioInstance {
  final box = GetStorage();
  final authController = AuthController();
  static Dio _dio = Dio();
  static final DioInstance _instance = DioInstance._internal();

  DioInstance._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: apiUrl,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Bearer': 'Bearer ${box.read('token')}',
      },
    ))
      ..interceptors.add(PrettyDioLogger())
      ..interceptors.add(InterceptorsWrapper(
        onError: (DioException error, ErrorInterceptorHandler handler) {
          DioExceptions dioExceptions = DioExceptions.fromDioError(error);

          ErrorSnackBar.show(dioExceptions.message, 'error');

          handler.next(error);
        },
        onRequest: (options, handler) async {
          String token = box.read('token');

          if (await authController.isTokenExpired(token)) {
            String newToken = await authController.refreshToken();

            box.write('token', newToken);

            token = newToken;
          }

          options.headers['Bearer'] = 'Bearer $token';

          return handler.next(options);
        },
      ));
  }

  static DioInstance get instance {
    return _instance;
  }

  Dio getDio() {
    return _dio;
  }
}
