import 'package:climby/bloc/session_bloc.dart';
import 'package:climby/model/difficulty_level.dart';
import 'package:climby/model/session.dart';
import 'package:climby/widget/generic/session_levels_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ActiveSessionPart extends StatefulWidget {
  const ActiveSessionPart({super.key});

  @override
  State<StatefulWidget> createState() => _ActiveSessionPartState();
}

class _ActiveSessionPartState extends State<ActiveSessionPart> {
  final ScrollController _scrollController = ScrollController();

  DifficultyLevel? _difficultyLevel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, SessionBlocState>(
        builder: (context, state) {
      switch (state) {
        case NoSessionState _:
          return const Text("No Session");
        case ActiveSessionState activeSessionState:
          final session = activeSessionState.activeSession;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSessionInfoCard(context, session),
              Container(height: 10),
              _buildEntryInputCard(context, session),
              Container(height: 10),
              Expanded(child: _buildSessionEntryList(context, session)),
              Container(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton(
                    onPressed: () => _handleSessionEnd(context, session),
                    child: const Text('Terminer la session'),
                  ),
                ],
              ),
            ],
          );
      }
    });
  }

  Widget _buildSessionInfoCard(BuildContext context, Session session) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "Infos",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Row(
              children: [
                Text(
                  "Salle: ",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Text(session.place.name)
              ],
            ),
            Row(
              children: [
                Text(
                  "Commencée à: ",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Text(DateFormat('kk:mm').format(session.startedAt))
              ],
            ),
            Row(
              children: [
                Text(
                  "Score actuel: ",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Text(session.entries.isEmpty
                    ? '0' // TODO: improve this...
                    : session.entries
                        .map((e) => e.difficultyLevel.score)
                        .reduce((a, b) => a + b)
                        .toString())
              ],
            ),
            Container(height: 6),
            SessionLevelsBar(session: session, height: 6),
          ],
        ),
      ),
    );
  }

  Widget _buildEntryInputCard(BuildContext context, Session session) {
    var entries = session.place.difficultyLevels
        .map((level) => DropdownMenuEntry<DifficultyLevel>(
            value: level,
            labelWidget: Icon(
              Icons.circle,
              color: Color(level.color),
            ),
            label: level.score.toString()))
        .toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "Ajouter un bloc",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Row(
              children: [
                DropdownMenu(
                  width: 80,
                  leadingIcon: _difficultyLevel != null
                      ? Icon(Icons.circle,
                          color: Color(_difficultyLevel!.color))
                      : null,
                  dropdownMenuEntries: entries,
                  onSelected: (level) =>
                      setState(() => _difficultyLevel = level),
                ),
                Container(width: 20),
                Expanded(
                  child: FilledButton(
                    onPressed: _difficultyLevel != null
                        ? () => context
                            .read<SessionBloc>()
                            .add(AddEntryOnSessionEvent(_difficultyLevel!))
                        : null,
                    child: const Text("Ajouter bloc complété"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSessionEntryList(BuildContext context, Session session) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Blocs complétés",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Expanded(
              child: session.entries.isEmpty
                  ? const Center(
                      child: Text("Aucun bloc réalisé pour le moment"))
                  : Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
                      child: ListView(
                        controller: _scrollController,
                        children: session.entries.reversed
                            .map(
                              (entry) => ListTile(
                                leading: Icon(
                                  Icons.circle,
                                  color: Color(entry.difficultyLevel.color),
                                ),
                                title: Text(
                                    "Terminé à ${DateFormat('kk:mm').format(entry.createdAt)}"),
                                subtitle: Text(
                                    '+${entry.difficultyLevel.score} point${entry.difficultyLevel.score > 1 ? 's' : ''}'),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () =>
                                      context.read<SessionBloc>().add(
                                            RemoveEntryFromActiveSessionEvent(
                                                entry),
                                          ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSessionEnd(BuildContext context, Session session) {
    final entries = session.entries.toList();
    final sessionBloc = context.read<SessionBloc>();

    if (entries.isEmpty) {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Valider session?'),
            content: const Text(
              "Vous n'avez validé aucun bloc." +
                  "\n\nÊtes vous sûr de valider cette session? Cette action ne peut pas être annulée.",
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Annuler'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FilledButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Valider'),
                onPressed: () {
                  sessionBloc.add(EndSessionEvent());
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      entries.sort(
          (entry1, entry2) => entry1.createdAt.compareTo(entry2.createdAt));
      final lastDate = entries.last.createdAt;

      if (DateTime.now().difference(lastDate).inHours > 0) {
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Valider session?'),
              content: const Text(
                "Cela fait plus d'une heure qu'aucun bloc n'a été entré."
                "\n\nSi cela provient d'un oubli de validation à la fin de la séance vous pouvez l'indiquer et l'heure sera corrigée."
                "\nSinon, vous pouvez simplement valider. "
                "\n\nCette action ne peut pas être annulée.",
              ),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Annuler'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text("J'ai oublié de valider"),
                  onPressed: () {
                    sessionBloc.add(
                      EndSessionEvent(
                        endDate: lastDate.add(
                          const Duration(minutes: 10),
                        ),
                      ),
                    );
                    Navigator.of(context).pop();
                  },
                ),
                FilledButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Valider'),
                  onPressed: () {
                    sessionBloc.add(EndSessionEvent());
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Valider session?'),
              content: const Text(
                'Êtes vous sûr de valider cette session?'
                '\n\nCette action ne peut pas être annulée.',
              ),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Annuler'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FilledButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Valider'),
                  onPressed: () {
                    sessionBloc.add(EndSessionEvent());
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }
}
