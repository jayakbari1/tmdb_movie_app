// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TMDBModel _$TMDBModelFromJson(Map<String, dynamic> json) => TMDBModel(
      id: json['id'] as int?,
      originalTitle: json['original_title'] as String,
      title: json['title'] as String,
      overview: json['overview'] as String,
      releaseDate: json['release_date'] as String,
      voteCount: json['vote_count'] as int,
      voteAverage: (json['vote_average'] as num).toDouble(),
      posterPath: json['poster_path'] as String? ?? '',
    );

Map<String, dynamic> _$TMDBModelToJson(TMDBModel instance) => <String, dynamic>{
      'id': instance.id,
      'original_title': instance.originalTitle,
      'title': instance.title,
      'overview': instance.overview,
      'release_date': instance.releaseDate,
      'poster_path': instance.posterPath,
      'vote_count': instance.voteCount,
      'vote_average': instance.voteAverage,
    };
