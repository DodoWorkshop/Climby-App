import 'package:climby/model/place.dart';
import 'package:climby/model/session_entry.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'session.freezed.dart';
part 'session.g.dart';

@freezed
class Session with _$Session {
  const Session._();

  const factory Session({
    required int id,
    required Place place,
    required DateTime startedAt,
    required DateTime? endedAt,
    required List<SessionEntry> entries,
  }) = _Session;

  factory Session.fromJson(Map<String, Object?> json) =>
      _$SessionFromJson(json);

  bool get isDone => endedAt != null;

  // TODO: cache this
  int computeScore() => entries.isEmpty
      ? 0
      : entries
          .map((entry) => entry.difficultyLevel.score)
          .reduce((score1, score2) => score1 + score2);

  // TODO: cache this
  int computeScorePerHour() {
    if (!isDone) return 0;

    final score = computeScore();

    if (score == 0) return 0;

    final durationInMinutes = Duration(
            milliseconds: endedAt!.millisecondsSinceEpoch -
                startedAt.millisecondsSinceEpoch)
        .inMinutes;

    if (durationInMinutes == 0) return 0;

    return ((score * 60) / durationInMinutes).round();
  }
}
