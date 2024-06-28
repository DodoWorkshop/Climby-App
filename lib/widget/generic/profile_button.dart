import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/authentication_bloc.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationBlocState>(
      builder: (context, state) {
        if (state is AuthenticatedState) {
          return PopupMenuButton<Function>(
            icon: CircleAvatar(
              radius: 18,
              child: ClipOval(
                  child: Image.network(state.profile.pictureUrl.toString())),
            ),
            itemBuilder: (context) => [
              PopupMenuItem<Function>(
                value: () =>
                    context.read<AuthenticationBloc>().add(LogoutEvent()),
                child: const ListTile(
                  title: Text('Déconnexion'),
                ),
              ),
            ],
            onSelected: (function) => function.call(),
          );
        }
        return Container();
      },
    );
  }
}
