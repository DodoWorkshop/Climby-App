// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'difficulty_level.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DifficultyLevelImpl _$$DifficultyLevelImplFromJson(
        Map<String, dynamic> json) =>
    _$DifficultyLevelImpl(
      id: (json['id'] as num).toInt(),
      color: (json['color'] as num).toInt(),
      score: (json['score'] as num).toInt(),
    );

Map<String, dynamic> _$$DifficultyLevelImplToJson(
        _$DifficultyLevelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'color': instance.color,
      'score': instance.score,
    };
