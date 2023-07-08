import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tmdb_movie_app/utils/strings.dart';

class SingletonDio {
  SingletonDio._internal();
  static final SingletonDio instance = SingletonDio._internal();

  Dio dio = Dio(
    BaseOptions(
      // connectTimeout: const Duration(seconds: 5),
      // //sendTimeout: const Duration(microseconds: 0),
      // receiveTimeout: const Duration(seconds: 2),
      queryParameters: {
        'api_key': Strings.apiKey,
      },
      followRedirects: true,
      persistentConnection: false,
    ),
  )..interceptors.addAll([ChuckerDioInterceptor()]);

  /// For Multi Part Request
  Dio newDio = Dio(
    BaseOptions(
      headers: {
        'Authorization': 'Bearer public_12a1yKsEd4wcBQ427o96MYCTCMvR',
        'Content-type': 'multipart/form-data',
      },
    ),
  );
}

class CustomInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('URI : ${options.uri}');
    super.onRequest(options, handler);
  }
}
