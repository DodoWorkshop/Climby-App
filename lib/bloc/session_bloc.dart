import 'package:climby/model/difficulty_level.dart';
import 'package:climby/model/place.dart';
import 'package:climby/model/session.dart';
import 'package:climby/model/session_entry.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/session_repository.dart';

class SessionBloc extends Bloc<SessionBlocEvent, Session?> {
  final SessionRepository _sessionRepository;

  SessionBloc(this._sessionRepository) : super(null) {
    on<FetchActiveSessionEvent>(_handleFetchActiveSessionEvent);
    on<StartSessionEvent>(_handleStartSessionEvent);
    on<AddEntryOnSessionEvent>(_handleAddEntryOnActiveSessionEvent);
    on<RemoveEntryFromActiveSessionEvent>(_handleRemoveEntryFromSessionEvent);
    on<EndSessionEvent>(_handleEndSessionEvent);
  }

  void _handleFetchActiveSessionEvent(
      FetchActiveSessionEvent event, Emitter<Session?> emit) async {
    final activeSession = await _sessionRepository.getActiveSession();

    emit(activeSession);
  }

  void _handleStartSessionEvent(
      StartSessionEvent event, Emitter<Session?> emit) async {
    if (state != null) {
      throw UnimplementedError("There is already an active session");
    }

    final session = await _sessionRepository.startSession(event.place.id);

    emit(session);
  }

  void _handleAddEntryOnActiveSessionEvent(
      AddEntryOnSessionEvent event, Emitter<Session?> emit) async {
    if (state == null) {
      throw UnimplementedError("There is no active session");
    }

    final SessionEntry entry = await _sessionRepository.addSessionEntry(event.level.id);
    final List<SessionEntry> entries = state!.entries + [entry];

    emit(state!.copyWith(entries: entries));
  }

  void _handleRemoveEntryFromSessionEvent(
      RemoveEntryFromActiveSessionEvent event, Emitter<Session?> emit) async {
    if (state == null) {
      throw UnimplementedError("There is no active session");
    }

    await _sessionRepository.deleteSessionEntry(event.entry.id);

    // Fetch session updates
    add(FetchActiveSessionEvent());
  }

  void _handleEndSessionEvent(EndSessionEvent event, Emitter<Session?> emit) async {
    if (state == null) {
      throw UnimplementedError("There is no active session");
    }

    await _sessionRepository.endSession(event.endDate);

    // Fetch session updates
    add(FetchActiveSessionEvent());
  }
}

abstract class SessionBlocEvent {}

class FetchActiveSessionEvent extends SessionBlocEvent {}

class StartSessionEvent extends SessionBlocEvent {
  final Place place;

  StartSessionEvent(this.place);
}

class AddEntryOnSessionEvent extends SessionBlocEvent {
  final DifficultyLevel level;

  AddEntryOnSessionEvent(this.level);
}

class RemoveEntryFromActiveSessionEvent extends SessionBlocEvent {
  final SessionEntry entry;

  RemoveEntryFromActiveSessionEvent(this.entry);
}

class EndSessionEvent extends SessionBlocEvent {
  final DateTime? endDate;

  EndSessionEvent({this.endDate});
}
