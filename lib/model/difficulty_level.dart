import 'package:freezed_annotation/freezed_annotation.dart';

part 'difficulty_level.freezed.dart';
part 'difficulty_level.g.dart';

@freezed
class DifficultyLevel with _$DifficultyLevel {
  const factory DifficultyLevel({
    required int id,
    required int color,
    required int score,
  }) = _DifficultyLevel;

  factory DifficultyLevel.fromJson(Map<String, Object?> json) =>
      _$DifficultyLevelFromJson(json);
}
