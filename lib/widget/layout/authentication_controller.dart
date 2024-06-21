import 'package:climby/bloc/authentication_bloc.dart';
import 'package:climby/model/authentication.dart';
import 'package:climby/widget/page/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationController extends StatelessWidget {
  final Widget child;

  const AuthenticationController({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, Authentication?>(
      builder: (context, authentication) {
        if (authentication != null) {
          return child;
        }

        return const LoginPage();
      },
    );
  }
}
