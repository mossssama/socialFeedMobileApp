import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:social_feed/core/constants.dart';

class DioClient {
  final Logger logger;
  late final Dio dio;

  DioClient({required this.logger}) {
    dio = Dio(
      BaseOptions(baseUrl: baseUrl, connectTimeout: const Duration(seconds: 20), receiveTimeout: const Duration(seconds: 20), headers: {
        'Content-Type': "application/json",
      }),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          logger.i("Request: ${options.method} ${options.baseUrl}${options.path}");
          logger.i("Headers: ${options.headers}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          logger.i("Response: ${response.statusCode} ${response.data}");
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          logger.i("Error: ${e.message}");
          return handler.next(e);
        },
      ),
    );
  }
}
