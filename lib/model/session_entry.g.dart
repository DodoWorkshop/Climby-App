// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SessionEntryImpl _$$SessionEntryImplFromJson(Map<String, dynamic> json) =>
    _$SessionEntryImpl(
      id: (json['id'] as num).toInt(),
      difficultyLevel: DifficultyLevel.fromJson(
          json['difficultyLevel'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$SessionEntryImplToJson(_$SessionEntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'difficultyLevel': instance.difficultyLevel,
      'createdAt': instance.createdAt.toIso8601String(),
    };
