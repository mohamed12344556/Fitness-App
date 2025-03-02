import 'package:dio/dio.dart';
import 'package:fitness_app/core/api/api_constants.dart';

class DioFactory {
  static Dio? dio;

  static Dio getDio() {
    if (dio == null) {
      dio = Dio();
      dio!.options.baseUrl = ApiConstants.baseUrl;
      dio!.options.queryParameters = {'key': ApiConstants.apiKey};
      dio!.options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      dio!.interceptors.add(
        LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
        ),
      );
    }
    return dio!;
  }
}
