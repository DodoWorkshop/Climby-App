import 'dart:async';

import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthenticationRepository {
  late Auth0 auth0;

  AuthenticationRepository() {
    auth0 = Auth0(dotenv.env['AUTH0_DOMAIN']!, dotenv.env['AUTH0_CLIENT_ID']!);
  }

  Future<Credentials> login() {
    return auth0
        .webAuthentication(scheme: dotenv.env['AUTH0_CUSTOM_SCHEME'])
        .login(
          useHTTPS: false,
          scopes: {'openid', 'profile', 'email', 'offline_access'},
          audience: dotenv.env['AUTH0_AUDIENCE'],
        );
  }

  Future<void> logout() async {
    await auth0
        .webAuthentication(scheme: dotenv.env['AUTH0_CUSTOM_SCHEME'])
        .logout(useHTTPS: true);
  }

  Future<UserProfile> getUserProfile(String jwt) {
    return auth0.api.userProfile(accessToken: jwt);
  }
}
