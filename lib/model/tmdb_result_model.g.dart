// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TMDBResult _$TMDBResultFromJson(Map<String, dynamic> json) => TMDBResult(
      results: (json['results'] as List<dynamic>)
          .map((e) => TMDBModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalResults: json['total_results'] as int,
    );

Map<String, dynamic> _$TMDBResultToJson(TMDBResult instance) =>
    <String, dynamic>{
      'results': instance.results,
      'total_results': instance.totalResults,
    };
