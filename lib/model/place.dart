import 'package:freezed_annotation/freezed_annotation.dart';

import 'difficulty_level.dart';

part 'place.freezed.dart';
part 'place.g.dart';

@freezed
class Place with _$Place {
  const factory Place({
    required int id,
    required String name,
    required List<DifficultyLevel> difficultyLevels,
  }) = _Place;

  factory Place.fromJson(Map<String, Object?> json) => _$PlaceFromJson(json);
}
