import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/session.dart';
import '../repository/session_repository.dart';

class SessionHistoryBloc
    extends Bloc<_SessionHistoryBlocEvent, SessionHistoryBlocState> {
  final SessionRepository sessionRepository;

  SessionHistoryBloc(this.sessionRepository)
      : super(SessionHistoryBlocState.value([])) {
    on<FetchHistoryEvent>(_handleFetchHistory);
  }

  void _handleFetchHistory(
      FetchHistoryEvent event, Emitter<SessionHistoryBlocState> emit) async {
    final sessions = await sessionRepository.getAllSessions();
    final history = sessions.where((session) => session.isDone)
        .toList();

    history.sort((session1, session2) => session1.startedAt.compareTo(session2.startedAt));

    emit(SessionHistoryBlocState.value(history));
  }
}

abstract class _SessionHistoryBlocEvent {}

class FetchHistoryEvent extends _SessionHistoryBlocEvent {}

class SessionHistoryBlocState {
  final bool isLoading;
  final List<Session> sessions;

  SessionHistoryBlocState({
    required this.isLoading,
    required this.sessions,
  });

  factory SessionHistoryBlocState.loading() => SessionHistoryBlocState(
        isLoading: true,
        sessions: [],
      );

  factory SessionHistoryBlocState.value(List<Session> sessions) =>
      SessionHistoryBlocState(
        isLoading: false,
        sessions: sessions,
      );
}
