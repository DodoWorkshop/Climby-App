import 'package:climby/bloc/stat_bloc.dart';
import 'package:climby/util/date_utils.dart' as DateUtility;
import 'package:climby/widget/page/stats/card/stat_card.dart';
import 'package:flutter/material.dart';

class GeneralStats extends StatelessWidget {
  const GeneralStats({super.key});

  @override
  Widget build(BuildContext context) {
    return StatCard(
      title: "Statistiques générales",
      builder: _buildDisplay,
    );
  }

  Future<Widget> _buildDisplay(
      BuildContext context, StatBlocState state) async {
    final sessionAmount = state.allSessions.length;

    if (sessionAmount == 0) {
      return const Center(
        child: Text("Quantité de donnée insuffisante"),
      );
    }

    final blocAmount = state.allSessions
        .map((session) => session.entries.length)
        .reduce((a, b) => a + b);

    final mostFrequentedPlace = state.sessionsPerPlace.entries
        .reduce((a, b) => a.value.length > b.value.length ? a : b)
        .key;

    final scores = state.allSessions.map((session) => session.computeScore());

    final best = scores.reduce((a, b) => a > b ? a : b);
    final mean = scores.reduce((a, b) => a + b) / sessionAmount;

    final sessionDurations = state.allSessions
        .where((session) => session.isDone)
        .map((session) => session.endedAt!.difference(session.startedAt));

    final totalTime = sessionDurations.reduce((a, b) => a + b);
    final meanTime = Duration(
        milliseconds:
            (totalTime.inMilliseconds / sessionDurations.length).floor());

    return Column(
      children: [
        Row(
          children: [
            Text("Nombre de sessions réalisées: ",
                style: Theme.of(context).textTheme.labelMedium),
            Text(sessionAmount.toString()),
          ],
        ),
        Row(
          children: [
            Text("Nombre de blocs réalisés: ",
                style: Theme.of(context).textTheme.labelMedium),
            Text(blocAmount.toString()),
          ],
        ),
        Row(
          children: [
            Text("Salle la plus fréquentée: ",
                style: Theme.of(context).textTheme.labelMedium),
            Text(mostFrequentedPlace.name),
          ],
        ),
        Row(
          children: [
            Text("Score moyen par session: ",
                style: Theme.of(context).textTheme.labelMedium),
            Text(mean.floor().toString()),
          ],
        ),
        Row(
          children: [
            Text("Meilleur score: ",
                style: Theme.of(context).textTheme.labelMedium),
            Text(best.toString()),
          ],
        ),
        Row(
          children: [
            Text("Temps total: ",
                style: Theme.of(context).textTheme.labelMedium),
            Text(DateUtility.DateUtils.durationToHourMinutes(totalTime)),
          ],
        ),
        Row(
          children: [
            Text("Temps moyen d'une session: ",
                style: Theme.of(context).textTheme.labelMedium),
            Text(DateUtility.DateUtils.durationToHourMinutes(meanTime)),
          ],
        ),
      ],
    );
  }
}
