import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/authentication_repository.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Climby",
              style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
            ),
            Container(height: 10),
            const Image(image: AssetImage('assets/logo.png')),
            Container(height: 10),
            FilledButton(
              onPressed: context.read<AuthenticationRepository>().login,
              child: const Text('Connexion'),
            ),
          ],
        ),
      ),
    );
  }
}
