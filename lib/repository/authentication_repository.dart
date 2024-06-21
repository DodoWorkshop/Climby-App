import 'dart:async';

import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:climby/model/authentication.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthenticationRepository {
  final _controller = StreamController<Authentication?>();

  late Auth0 auth0;

  AuthenticationRepository() {
    auth0 = Auth0(dotenv.env['AUTH0_DOMAIN']!, dotenv.env['AUTH0_CLIENT_ID']!);
  }

  Stream<Authentication?> get auth async* {
    // TODO: handle auto connect
    // yield currentAuthState...

    yield* _controller.stream;
  }

  Future<void> login() async {
    try {
      final credentials = await auth0
          .webAuthentication(scheme: dotenv.env['AUTH0_CUSTOM_SCHEME'])
          .login(
            useHTTPS: false,
            scopes: {
              'openid',
              'profile',
              'email',
              'write:places',
            },
            audience: dotenv.env['AUTH0_AUDIENCE'],
          );

      final jwt = credentials.accessToken;

      final auth = Authentication(
        profile: credentials.user,
        jwt: jwt,
      );

      _controller.sink.add(auth);
    } catch (e) {
      print(e);
      _controller.sink.add(null);
    }
  }

  Future<void> logout() async {
    try {
      await auth0
          .webAuthentication(scheme: dotenv.env['AUTH0_CUSTOM_SCHEME'])
          .logout(useHTTPS: true);

      _controller.sink.add(null);
    } catch (e) {
      print(e);
    }
  }

  void dispose() => _controller.close();
}
