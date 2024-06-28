import 'package:climby/model/difficulty_level.dart';
import 'package:climby/model/place.dart';
import 'package:climby/model/session.dart';
import 'package:climby/model/session_entry.dart';
import 'package:climby/util/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/session_repository.dart';
import 'notification_bloc.dart';

class SessionBloc extends Bloc<SessionBlocEvent, SessionBlocState> {
  final SessionRepository _sessionRepository;
  final NotificationBloc _notificationBloc;

  SessionBloc(this._sessionRepository, this._notificationBloc)
      : super(NoSessionState(false)) {
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
          onError: (e) => _notificationBloc.add(
            SendErrorNotificationEvent(
              "Une erreur s'est produite lors de la récupération de la session",
              leadingIcon: Icons.error,
            ),
          ),
        );
  }

  void _handleStartSessionEvent(
    StartSessionEvent event,
    Emitter<SessionBlocState> emit,
  ) async {
    if (state is ActiveSessionState) {
      LogUtils.logError(
          UnimplementedError("There is already an active session"));

      _notificationBloc.add(
        SendErrorNotificationEvent(
          "Une erreur s'est produite lors du démarrage de la session",
          leadingIcon: Icons.error,
        ),
      );
    }

    emit(NoSessionState(true));

    await _sessionRepository.startSession(event.place.id).then(
          (session) => {
            emit(ActiveSessionState(session)),
            _notificationBloc.add(SendSuccessNotificationEvent(
              "Session démarrée!",
              leadingIcon: Icons.directions_run,
            ))
          },
          onError: (e) => _notificationBloc.add(
            SendErrorNotificationEvent(
              "Une erreur s'est produite lors du démarrage de la session",
              leadingIcon: Icons.error,
            ),
          ),
        );
  }

  void _handleAddEntryOnActiveSessionEvent(
    AddEntryOnSessionEvent event,
    Emitter<SessionBlocState> emit,
  ) async {
    switch (state) {
      case NoSessionState _:
        LogUtils.logError(UnimplementedError("There is no active session"));
        _notificationBloc.add(
          SendErrorNotificationEvent(
            "Une erreur s'est produite lors de la modification de la session",
            leadingIcon: Icons.error,
          ),
        );
      case ActiveSessionState activeSessionState:
        await _sessionRepository.addSessionEntry(event.level.id).then(
          (entry) {
            final session = activeSessionState.activeSession.copyWith(
                entries: activeSessionState.activeSession.entries + [entry]);
            emit(ActiveSessionState(session));
          },
          onError: (e) => _notificationBloc.add(
            SendErrorNotificationEvent(
              "Une erreur s'est produite lors de la modification de la session",
              leadingIcon: Icons.error,
            ),
          ),
        );
    }
  }

  void _handleRemoveEntryFromSessionEvent(
    RemoveEntryFromActiveSessionEvent event,
    Emitter<SessionBlocState> emit,
  ) async {
    switch (state) {
      case NoSessionState _:
        LogUtils.logError(UnimplementedError("There is no active session"));
        _notificationBloc.add(
          SendErrorNotificationEvent(
            "Une erreur s'est produite lors de la modification de la session",
            leadingIcon: Icons.error,
          ),
        );
      case ActiveSessionState _:
        await _sessionRepository.deleteSessionEntry(event.entry.id).then(
              // Fetch session updates
              (_) => add(FetchActiveSessionEvent()),
              onError: (e) => _notificationBloc.add(
                SendErrorNotificationEvent(
                  "Une erreur s'est produite lors de la modification de la session",
                  leadingIcon: Icons.error,
                ),
              ),
            );
    }
  }

  void _handleEndSessionEvent(
    EndSessionEvent event,
    Emitter<SessionBlocState> emit,
  ) async {
    switch (state) {
      case NoSessionState _:
        LogUtils.logError(UnimplementedError("There is no active session"));
        _notificationBloc.add(
          SendErrorNotificationEvent(
            "Une erreur s'est produite lors de la clôture de la session",
            leadingIcon: Icons.error,
          ),
        );
      case ActiveSessionState _:
        await _sessionRepository.endSession(event.endDate).then(
          // Fetch session updates
          (_) {
            add(FetchActiveSessionEvent());
            _notificationBloc.add(SendSuccessNotificationEvent(
              "Session Terminée!",
              leadingIcon: Icons.directions_run,
            ));
          },
          onError: (e) => _notificationBloc.add(
            SendErrorNotificationEvent(
              "Une erreur s'est produite lors de la clôture de la session",
              leadingIcon: Icons.error,
            ),
          ),
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
