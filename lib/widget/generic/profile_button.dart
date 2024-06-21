import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:climby/model/authentication.dart';
import 'package:climby/repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/authentication_bloc.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, Authentication?>(
      builder: (context, state) => PopupMenuButton<Function>(
        icon: CircleAvatar(
          radius: 18,
          child: ClipOval(child: Image.network(state!.profile.pictureUrl.toString())),
        ),
        itemBuilder: (context) => [
          PopupMenuItem<Function>(
            value: context.read<AuthenticationRepository>().logout,
            child: const ListTile(
              title: Text('Déconnexion'),
            ),
          ),
        ],
        onSelected: (function) => function.call(),
      ),
    );
  }
}
