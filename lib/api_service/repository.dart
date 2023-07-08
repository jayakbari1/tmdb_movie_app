// ignore_for_file: public_member_api_docs, only_throw_errors, lines_longer_than_80_chars, inference_failure_on_function_invocation

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:tmdb_movie_app/api_service/api_service.dart';
import 'package:tmdb_movie_app/api_service/dio.dart';
import 'package:tmdb_movie_app/api_service/status_code.dart';
import 'package:tmdb_movie_app/generics/respose_or_error_generics.dart';
import 'package:tmdb_movie_app/model/tmdb_result_model.dart';
import 'package:tmdb_movie_app/model/video_result_model.dart';
import 'package:tmdb_movie_app/utils/strings.dart';

class Repository {
  Repository._internal();

  static final Repository instance = Repository._internal();

  final client = RestClient(SingletonDio.instance.dio);

  Future<ResponseOrError<TMDBResult>> getMovieData(int page) async {
    return loadData(client.getMovies(page));
  }

  Future<ResponseOrError<VideoResult>> getMovieVideos(
      int id, String apiKey) async {
    return loadData(client.getVideos(apiKey, id));
  }

  Future<ResponseOrError<TMDBResult>> getSearchMovieResult(
    int page,
    String title,
  ) async {
    return loadData(client.getSearchMovies(page, title));
  }
}

/*Future<bool> checkConnectivity() async {
  final internetResponse = Connectivity().onConnectivityChanged;

  if (await internetResponse.isEmpty) {
    return false;
  } else {
    return true;
  }
}*/

/// Function to check for the internet connection
Future<bool> checkInternetConnectivity() async {
  try {
    final internetResponse = await InternetAddress.lookup('www.google.com');
    if (internetResponse.isNotEmpty &&
        internetResponse[0].rawAddress.isNotEmpty) {
      return true;
    }
  } catch (e) {
    return false;
  }
  return false;
}

final client = RestClient(SingletonDio.instance.dio);

Future<ResponseOrError<T>> loadData<T>(Future<T> function) async {
  if (await checkInternetConnectivity()) {
    try {
      final response = await function;
      return ResponseOrError.success(response: response);
    } catch (e, s) {
      return catchError(e, s);
    }
  } else {
    return ResponseOrError.failure(errorInfo: Strings.noInternet);
  }
}

ResponseOrError<T> catchError<T>(Object e, StackTrace s) {
  if (e is DioError) {
    if (e.error is SocketException) {
      return ResponseOrError.failure(errorInfo: Strings.noInternet);
    }
    return ResponseOrError.failure(
      errorInfo: errorOnResponseHandler(e.response?.statusCode),
    );
  } else {
    debugPrintStack(stackTrace: s);
    debugPrint('error is $e');
    return ResponseOrError.failure(errorInfo: Strings.someThingWrong);
  }
}

String errorOnResponseHandler(int? statusCode) {
  if (statusCode == StatusCode.unauthorized) {
    return Strings.error401;
  } else if (statusCode == StatusCode.unauthorized) {
    return Strings.error402;
  } else if (statusCode == StatusCode.notFound) {
    return Strings.error404;
  } else {
    return Strings.someThingWrong;
  }
}
