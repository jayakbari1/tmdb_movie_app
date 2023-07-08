import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class TMDBModel {
  TMDBModel({
    required this.id,
    required this.originalTitle,
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.voteCount,
    required this.voteAverage,
    this.posterPath = '',
  });

  factory TMDBModel.fromJson(Map<String, dynamic> json) =>
      _$TMDBModelFromJson(json);
  final int? id;
  @JsonKey(name: 'original_title')
  final String originalTitle;
  final String title;
  final String overview;
  @JsonKey(name: 'release_date')
  final String releaseDate;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'vote_count')
  final int voteCount;
  @JsonKey(name: 'vote_average')
  final double voteAverage;

  Map<String, dynamic> toJson() => _$TMDBModelToJson(this);
}
