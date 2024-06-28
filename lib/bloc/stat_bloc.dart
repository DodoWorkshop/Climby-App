import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/place.dart';
import '../model/session.dart';
import '../repository/session_repository.dart';

class StatBloc extends Bloc<_StatBlocEvent, StatBlocState> {
  final SessionRepository sessionRepository;

  StatBloc(this.sessionRepository) : super(StatBlocState._init()) {
    on<FetchStatsEvent>(_handleFetchStats);
  }

  void _handleFetchStats(
    FetchStatsEvent event,
    Emitter<StatBlocState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final allSessions = await sessionRepository.getAllSessions();

    final Map<Place, List<Session>> sessionsPerPlace = allSessions.fold(
      {},
      (map, session) {
        map.update(
          session.place,
          (sessions) {
            sessions.add(session);
            return sessions;
          },
          ifAbsent: () => [session],
        );

        return map;
      },
    );

    emit(
      state.copyWith(
          isLoading: false,
          allSessions: allSessions,
          sessionsPerPlace: sessionsPerPlace),
    );
  }
}

abstract class _StatBlocEvent {}

class FetchStatsEvent extends _StatBlocEvent {}

class StatBlocState {
  final bool isLoading;

  final List<Session> allSessions;
  final Map<Place, List<Session>> sessionsPerPlace;

  StatBlocState({
    required this.isLoading,
    required this.allSessions,
    required this.sessionsPerPlace,
  });

  factory StatBlocState._init() => StatBlocState(
        isLoading: true,
        allSessions: [],
        sessionsPerPlace: {},
      );

  StatBlocState copyWith({
    bool? isLoading,
    List<Session>? allSessions,
    Map<Place, List<Session>>? sessionsPerPlace,
  }) =>
      StatBlocState(
        isLoading: isLoading ?? this.isLoading,
        allSessions: allSessions ?? this.allSessions,
        sessionsPerPlace: sessionsPerPlace ?? this.sessionsPerPlace,
      );
}
