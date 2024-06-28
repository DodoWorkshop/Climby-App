import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:climby/client/api_client.dart';
import 'package:climby/repository/authentication_repository.dart';
import 'package:climby/util/log_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationBlocState> {
  final AuthenticationRepository _authenticationRepository;
  final ApiClient _apiClient;

  AuthenticationBloc(this._authenticationRepository, this._apiClient)
      : super(UnauthenticatedBloc(false)) {
    on<LoginEvent>(_handleLogin);
    on<LogoutEvent>(_handleLogout);
  }

  void _handleLogin(
      LoginEvent event, Emitter<AuthenticationBlocState> emit) async {
    emit(UnauthenticatedBloc(true));

    try {
      final credentials = await _authenticationRepository.login();
      final newState =
          AuthenticatedState(credentials.user, credentials.accessToken);

      // Set api token
      _apiClient.token = newState.jwt;

      emit(newState);
    } catch (e) {
      LogUtils.logError(e);
      emit(UnauthenticatedBloc(false));
    }
  }

  void _handleLogout(
      LogoutEvent event, Emitter<AuthenticationBlocState> emit) async {
    emit(UnauthenticatedBloc(true));

    try {
      await _authenticationRepository.logout();

      // Set api token
      _apiClient.token = null;
    } catch (e) {
      LogUtils.logError(e);
    }

    emit(UnauthenticatedBloc(false));
  }
}

sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

class LoginEvent extends AuthenticationEvent {}

class LogoutEvent extends AuthenticationEvent {}

abstract class AuthenticationBlocState {}

class AuthenticatedState extends AuthenticationBlocState {
  final UserProfile profile;
  final String jwt;

  AuthenticatedState(this.profile, this.jwt);
}

class UnauthenticatedBloc extends AuthenticationBlocState {
  final bool isConnecting;

  UnauthenticatedBloc(this.isConnecting);
}
