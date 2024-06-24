import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/session.dart';
import '../repository/session_repository.dart';

class StatBloc extends Bloc<_StatBlocEvent, StatBlocState> {
  final SessionRepository sessionRepository;

  StatBloc(this.sessionRepository) : super(StatBlocState._init()) {
    on<FetchStatsEvent>(_handleFetchStats);
  }

  void _handleFetchStats(
      FetchStatsEvent event, Emitter<StatBlocState> emit) async {
    emit(state.copyWith(isLoading: true));

    final allSessions = await sessionRepository.getAllSessions();

    emit(
      state.copyWith(
        isLoading: false,
        allSessions: allSessions,
      ),
    );
  }
}

abstract class _StatBlocEvent {}

class FetchStatsEvent extends _StatBlocEvent {}

class StatBlocState {
  final bool isLoading;

  final List<Session> allSessions;

  StatBlocState({
    required this.isLoading,
    required this.allSessions,
  });

  factory StatBlocState._init() => StatBlocState(
        isLoading: true,
        allSessions: [],
      );

  StatBlocState copyWith({
    bool? isLoading,
    List<Session>? allSessions,
  }) =>
      StatBlocState(
        isLoading: isLoading ?? this.isLoading,
        allSessions: allSessions ?? this.allSessions,
      );
}
