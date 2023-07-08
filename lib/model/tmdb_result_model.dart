import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb_movie_app/model/model.dart';

part 'tmdb_result_model.g.dart';

@JsonSerializable()
class TMDBResult {
  TMDBResult({
    required this.results,
    required this.totalResults,
  });

  factory TMDBResult.fromJson(Map<String, dynamic> json) {
    return _$TMDBResultFromJson(json);
  }

  final List<TMDBModel> results;
  @JsonKey(name: 'total_results')
  final int totalResults;

  Map<String, dynamic> toJson() => _$TMDBResultToJson(this);
}
