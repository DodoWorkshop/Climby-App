import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:climby/client/api_client.dart';
import 'package:climby/constant/stored_keys.dart';
import 'package:climby/repository/authentication_repository.dart';
import 'package:climby/util/log_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'notification_bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationBlocState> {
  final AuthenticationRepository _authenticationRepository;
  final ApiClient _apiClient;
  final NotificationBloc _notificationBloc;

  AuthenticationBloc(
      this._authenticationRepository, this._apiClient, this._notificationBloc)
      : super(UnauthenticatedBloc(false)) {
    on<LoginEvent>(_handleLogin);
    on<AutoLoginEvent>(_handleAutoLogin);
    on<LogoutEvent>(_handleLogout);
  }

  void _handleAutoLogin(
      AutoLoginEvent event, Emitter<AuthenticationBlocState> emit) async {
    LogUtils.log("Attempting auto login...");

    emit(UnauthenticatedBloc(true));

    final prefs = await SharedPreferences.getInstance();

    final jwt = prefs.getString(JWT_KEY);
    if (jwt != null) {
      try {
        final userProfile = await _authenticationRepository.getUserProfile(jwt);
        _apiClient.token = jwt;

        final newState = AuthenticatedState(userProfile, jwt);

        emit(newState);

        _notificationBloc
            .add(SendSuccessNotificationEvent("Reconnexion réussie"));
      } catch (e) {
        LogUtils.logError(e);
        emit(UnauthenticatedBloc(false));
      }
    } else {
      emit(UnauthenticatedBloc(false));
    }
  }

  void _handleLogin(
      LoginEvent event, Emitter<AuthenticationBlocState> emit) async {
    emit(UnauthenticatedBloc(true));

    try {
      final credentials = await _authenticationRepository.login();

      await _setCredentials(credentials);

      final newState =
          AuthenticatedState(credentials.user, credentials.accessToken);

      emit(newState);

      _notificationBloc.add(SendSuccessNotificationEvent("Connexion réussie"));
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

      // Remove stored keys
      final prefs = await SharedPreferences.getInstance();
      prefs.remove(REFRESH_TOKEN_KEY);
      prefs.remove(JWT_KEY);
    } catch (e) {
      LogUtils.logError(e);
    }

    emit(UnauthenticatedBloc(false));
  }

  Future<void> _setCredentials(Credentials credentials) async {
    // Set api token
    final jwt = credentials.accessToken;
    final refreshToken = credentials.refreshToken;

    _apiClient.token = jwt;

    final prefs = await SharedPreferences.getInstance();
    prefs.setString(JWT_KEY, jwt);

    if (refreshToken != null) {
      prefs.setString(REFRESH_TOKEN_KEY, refreshToken);
    } else {
      LogUtils.log("Refresh token is null");
    }
  }
}

sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

class LoginEvent extends AuthenticationEvent {}

class AutoLoginEvent extends AuthenticationEvent {}

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
