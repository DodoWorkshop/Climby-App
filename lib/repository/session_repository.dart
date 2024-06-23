import 'dart:convert';

import 'package:climby/client/api_client.dart';
import 'package:climby/repository/repository.dart';
import 'package:climby/util/log_utils.dart';

import '../model/session.dart';
import '../model/session_entry.dart';

class SessionRepository extends HttpRepository<ApiClient> {
  static const String baseUri = "/sessions";

  SessionRepository(super.client);

  Future<Session?> getActiveSession() async {
    final uri = Uri.parse("$baseUri/active");
    final response = await client.get(uri);

    if (response.statusCode == 404) {
      LogUtils.log("No active session found");
      return null;
    }

    final json = jsonDecode(response.body);

    return Session.fromJson(json);
  }

  Future<Session> startSession(int placeId) async {
    final uri = Uri.parse("$baseUri/start");
    final response = await client.post(
      uri,
      body: jsonEncode({
        'placeId': placeId
      }),
    );

    final json = jsonDecode(response.body);

    return Session.fromJson(json);
  }

  Future<SessionEntry> addSessionEntry(int difficultyLevelId) async{
    final uri = Uri.parse("$baseUri/active/entries");

    final response = await client.post(
      uri,
      body: jsonEncode({
        'difficultyLevelId': difficultyLevelId
      }),
    );

    final json = jsonDecode(response.body);

    return SessionEntry.fromJson(json);
  }

  Future<void> deleteSessionEntry(int entryId) async{
    final uri = Uri.parse("$baseUri/active/entries/$entryId");

    await client.delete(uri);
  }

  Future<void> endSession(DateTime? endDate) async {
    final uri = Uri.parse("$baseUri/active/stop");

    await client.post(uri,
      body: jsonEncode({
        'endDate': endDate?.toIso8601String()
      })
    );
  }

  Future<List<Session>> getAllSessions() async {
    final uri = Uri.parse(baseUri);

    final response = await client.get(uri);
    final List<dynamic> list = jsonDecode(response.body);

    return list.map((json) => Session.fromJson(json)).toList();
  }
}
