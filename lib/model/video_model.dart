import 'package:json_annotation/json_annotation.dart';

part 'video_model.g.dart';

@JsonSerializable()
class VideoModel {
  VideoModel({
    required this.name,
    required this.videoKey,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) =>
      _$VideoModelFromJson(json);

  final String name;
  @JsonKey(name: 'key')
  final String videoKey;

  Map<String, dynamic> toJson() => _$VideoModelToJson(this);
}
