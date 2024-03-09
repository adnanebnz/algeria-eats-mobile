import 'package:algeria_eats/core/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../errors/dio_exceptions.dart';
import '../utils/error_snackbar.dart';

class DioInstance {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: apiUrl,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${GetStorage().read('token')}',
    },
  ))
    ..interceptors.add(PrettyDioLogger())
    ..interceptors.add(InterceptorsWrapper(
      onError: (DioException error, ErrorInterceptorHandler handler) {
        DioExceptions dioExceptions = DioExceptions.fromDioError(error);

        ErrorSnackBar.show(dioExceptions.message, 'error');

        handler.next(error);
      },
      // onRequest: (options, handler) async {
      //   // handle token refresh later
      //   return handler.next(options);
      // },
    ));

  static Dio getDio() {
    return _dio;
  }
}
