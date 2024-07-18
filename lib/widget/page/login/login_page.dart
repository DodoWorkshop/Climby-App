import 'package:climby/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
            FutureBuilder(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }

                  return Text(
                      "v${snapshot.hasData ? snapshot.data!.version : "?.?.?"}");
                }),
            Container(height: 10),
            const Image(image: AssetImage('assets/logo.png')),
            Container(height: 10),
            FilledButton(
              onPressed: () =>
                  context.read<AuthenticationBloc>().add(LoginEvent()),
              child: const Text('Connexion'),
            ),
          ],
        ),
      ),
    );
  }
}
