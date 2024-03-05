import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioInstance {
  static final Dio _dio = Dio()..interceptors.add(PrettyDioLogger());
  static Dio getDio() {
    return _dio;
  }
}
