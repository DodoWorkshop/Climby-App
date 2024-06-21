import 'dart:async';

import 'package:climby/client/api_client.dart';
import 'package:climby/model/authentication.dart';
import 'package:climby/repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, Authentication?> {
  final AuthenticationRepository _authenticationRepository;
  final ApiClient _apiClient;

  late StreamSubscription<Authentication?> _authenticationSubscription;

  AuthenticationBloc(this._authenticationRepository, this._apiClient)
      : super(null) {
    on<_AuthenticationChanged>(_onAuthenticationChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    _authenticationSubscription = _authenticationRepository.auth.listen(
      (auth) => add(_AuthenticationChanged(auth)),
    );
  }

  void _onAuthenticationChanged(
    _AuthenticationChanged event,
    Emitter<Authentication?> emit,
  ) {
    _apiClient.token = event.authentication?.jwt;

    emit(event.authentication);
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<Authentication?> emit,
  ) {
    _authenticationRepository.logout();
  }

  @override
  Future<void> close() {
    _authenticationSubscription.cancel();
    return super.close();
  }
}

sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

final class _AuthenticationChanged extends AuthenticationEvent {
  const _AuthenticationChanged(this.authentication);

  final Authentication? authentication;
}

final class AuthenticationLogoutRequested extends AuthenticationEvent {}
