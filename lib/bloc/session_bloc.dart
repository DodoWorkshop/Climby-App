import 'package:climby/model/difficulty_level.dart';
import 'package:climby/model/place.dart';
import 'package:climby/model/session.dart';
import 'package:climby/model/session_entry.dart';
import 'package:climby/util/log_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/session_repository.dart';

class SessionBloc extends Bloc<SessionBlocEvent, SessionBlocState> {
  final SessionRepository _sessionRepository;

  SessionBloc(this._sessionRepository) : super(NoSessionState(false)) {
    on<FetchActiveSessionEvent>(_handleFetchActiveSessionEvent);
    on<StartSessionEvent>(_handleStartSessionEvent);
    on<AddEntryOnSessionEvent>(_handleAddEntryOnActiveSessionEvent);
    on<RemoveEntryFromActiveSessionEvent>(_handleRemoveEntryFromSessionEvent);
    on<EndSessionEvent>(_handleEndSessionEvent);
  }

  void _handleFetchActiveSessionEvent(
    FetchActiveSessionEvent event,
    Emitter<SessionBlocState> emit,
  ) async {
    emit(NoSessionState(true));

    await _sessionRepository.getActiveSession().then(
          (activeSession) => activeSession == null
              ? emit(NoSessionState(false))
              : emit(
                  ActiveSessionState(activeSession),
                ),
          onError: LogUtils.logError,
        );
  }

  void _handleStartSessionEvent(
    StartSessionEvent event,
    Emitter<SessionBlocState> emit,
  ) async {
    if (state is ActiveSessionState) {
      throw UnimplementedError("There is already an active session");
    }

    emit(NoSessionState(true));

    await _sessionRepository.startSession(event.place.id).then(
          (session) => emit(ActiveSessionState(session)),
          onError: LogUtils.logError,
        );
  }

  void _handleAddEntryOnActiveSessionEvent(
    AddEntryOnSessionEvent event,
    Emitter<SessionBlocState> emit,
  ) async {
    switch (state) {
      case NoSessionState _:
        throw UnimplementedError("There is no active session");
      case ActiveSessionState activeSessionState:
        await _sessionRepository.addSessionEntry(event.level.id).then(
          (entry) {
            final session = activeSessionState.activeSession.copyWith(
                entries: activeSessionState.activeSession.entries + [entry]);
            emit(ActiveSessionState(session));
          },
          onError: LogUtils.logError,
        );
    }
  }

  void _handleRemoveEntryFromSessionEvent(
    RemoveEntryFromActiveSessionEvent event,
    Emitter<SessionBlocState> emit,
  ) async {
    switch (state) {
      case NoSessionState _:
        throw UnimplementedError("There is no active session");
      case ActiveSessionState _:
        await _sessionRepository.deleteSessionEntry(event.entry.id).then(
              // Fetch session updates
              (_) => add(FetchActiveSessionEvent()),
              onError: LogUtils.logError,
            );
    }
  }

  void _handleEndSessionEvent(
    EndSessionEvent event,
    Emitter<SessionBlocState> emit,
  ) async {
    switch (state) {
      case NoSessionState _:
        throw UnimplementedError("There is no active session");
      case ActiveSessionState _:
        await _sessionRepository.endSession(event.endDate).then(
              // Fetch session updates
              (_) => add(FetchActiveSessionEvent()),
              onError: LogUtils.logError,
            );
    }
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

sealed class SessionBlocState {}

class NoSessionState extends SessionBlocState {
  final bool isLoading;

  NoSessionState(this.isLoading);
}

class ActiveSessionState extends SessionBlocState {
  final Session activeSession;

  ActiveSessionState(this.activeSession);
}
