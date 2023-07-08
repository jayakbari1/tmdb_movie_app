import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tmdb_movie_app/model/tmdb_result_model.dart';
import 'package:tmdb_movie_app/utils/strings.dart';

import '../model/video_result_model.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: Strings.baseUrl)

/// Responsible for Handling all the Network call
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('movie/upcoming')
  Future<TMDBResult> getMovies(@Query('page') int page);

  @GET('search/movie')
  Future<TMDBResult> getSearchMovies(
    @Query('page') int page,
    @Query('query') String title,
  );

  @GET('movie/{id}/videos')
  Future<VideoResult> getVideos(
    @Query('api_key') String apiKey,
    @Path('id') int id,
  );
}
