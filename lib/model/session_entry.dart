import 'package:climby/model/difficulty_level.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_entry.freezed.dart';
part 'session_entry.g.dart';

@freezed
class SessionEntry with _$SessionEntry {
  const factory SessionEntry({
    required int id,
    required DifficultyLevel difficultyLevel,
    required DateTime createdAt,
  }) = _SessionEntry;

  factory SessionEntry.fromJson(Map<String, Object?> json) =>
      _$SessionEntryFromJson(json);
}
