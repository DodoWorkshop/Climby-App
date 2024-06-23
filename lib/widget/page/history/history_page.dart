import 'package:climby/bloc/session_history_bloc.dart';
import 'package:climby/widget/generic/session_levels_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SessionHistoryBloc>().add(FetchHistoryEvent());

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Scaffold(
        body: Column(
          children: [
            Center(
              child: Text(
                "Historique",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Expanded(
                child: BlocBuilder<SessionHistoryBloc, SessionHistoryBlocState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Text("Chargement de l'historique...");
                }

                return ListView(
                  children: state.sessions.map((session) {
                    final duration =
                        session.endedAt!.difference(session.startedAt);

                    return ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            session.computeScore().toString(),
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                      title: Text(
                        session.place.name,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start ,
                        children: [
                          Text(
                            DateFormat()
                                .add_yMd()
                                .add_Hm()
                                .format(session.endedAt ?? session.startedAt),
                          ),
                          SessionLevelsBar(session: session),
                        ],
                      ),
                      trailing: SizedBox(
                        width: 45,
                        child: Text("${duration.inMinutes}min"),
                      ),
                    );
                  }).toList(),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
