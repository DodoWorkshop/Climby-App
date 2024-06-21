import 'package:climby/model/place.dart';
import 'package:climby/model/session_entry.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'session.freezed.dart';
part 'session.g.dart';

@freezed
class Session with _$Session {
  const factory Session({
    required int id,
    required Place place,
    required DateTime startedAt,
    required DateTime? endedAt,
    required List<SessionEntry> entries,
  }) = _Session;

  factory Session.fromJson(Map<String, Object?> json) =>
      _$SessionFromJson(json);
}
