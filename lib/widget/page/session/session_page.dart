import 'package:climby/bloc/session_bloc.dart';
import 'package:climby/widget/page/session/part/active_session_part.dart';
import 'package:climby/widget/page/session/part/start_session_part.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionPage extends StatelessWidget {
  const SessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SessionBloc>().add(FetchActiveSessionEvent());

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Scaffold(
        body: BlocBuilder<SessionBloc, SessionBlocState>(
          builder: (context, state) {
            switch (state) {
              case NoSessionState noSessionState:
                return noSessionState.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : const Center(child: StartSessionPart());
              case ActiveSessionState _:
                return const ActiveSessionPart();
            }
          },
        ),
      ),
    );
  }
}
