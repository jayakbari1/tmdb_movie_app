import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb_movie_app/model/video_model.dart';

part 'video_result_model.g.dart';

@JsonSerializable()
class VideoResult {
  VideoResult({
    required this.results,
    required this.id,
  });

  factory VideoResult.fromJson(Map<String, dynamic> json) {
    return _$VideoResultFromJson(json);
  }

  final List<VideoModel> results;
  @JsonKey(name: 'id')
  final int id;

  Map<String, dynamic> toJson() => _$VideoResultToJson(this);
}
