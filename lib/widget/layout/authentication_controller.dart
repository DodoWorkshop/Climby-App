import 'package:climby/bloc/authentication_bloc.dart';
import 'package:climby/widget/page/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationController extends StatefulWidget {
  final Widget child;

  const AuthenticationController({super.key, required this.child});

  @override
  State<StatefulWidget> createState() => _AuthenticationControllerState();
}

class _AuthenticationControllerState extends State<AuthenticationController> {
  @override
  void initState() {
    context.read<AuthenticationBloc>().add(AutoLoginEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationBlocState>(
      builder: (context, state) {
        if (state is AuthenticatedState) {
          return widget.child;
        }

        if (state is UnauthenticatedBloc && state.isConnecting) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Connexion en cours..."),
                  Container(height: 12),
                  const CircularProgressIndicator(),
                ],
              ),
            ),
          );
        }

        return const LoginPage();
      },
    );
  }
}
