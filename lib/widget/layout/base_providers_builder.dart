import 'package:climby/bloc/authentication_bloc.dart';
import 'package:climby/bloc/place_bloc.dart';
import 'package:climby/bloc/session_bloc.dart';
import 'package:climby/bloc/session_history_bloc.dart';
import 'package:climby/client/api_client.dart';
import 'package:climby/repository/place_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/authentication_repository.dart';
import '../../repository/session_repository.dart';

class BaseProvidersBuilder extends StatefulWidget {
  final Widget child;

  const BaseProvidersBuilder({super.key, required this.child});

  @override
  State<StatefulWidget> createState() => _BaseProvidersBuilderState();
}

class _BaseProvidersBuilderState extends State<BaseProvidersBuilder> {
  late ApiClient _apiClient;

  late AuthenticationRepository _authenticationRepository;
  late SessionRepository _sessionRepository;
  late PlaceRepository _placeRepository;

  late AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();

    _apiClient = ApiClient();
    _authenticationRepository = AuthenticationRepository();
    _sessionRepository = SessionRepository(_apiClient);
    _placeRepository = PlaceRepository(_apiClient);

    _authenticationBloc =
        AuthenticationBloc(_authenticationRepository, _apiClient);
  }

  @override
  Widget build(BuildContext context) {
    print("Rebuild providers");

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authenticationRepository),
        RepositoryProvider.value(value: _sessionRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _authenticationBloc),
          BlocProvider(create: (_) => SessionBloc(_sessionRepository)),
          BlocProvider(create: (_) => PlaceBloc(_placeRepository)),
          BlocProvider(create: (_) => SessionHistoryBloc(_sessionRepository)),
        ],
        child: widget.child,
      ),
    );
  }
}
