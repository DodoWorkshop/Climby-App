import 'package:climby/widget/page/stats/card/stat_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/stat_bloc.dart';
import '../../../../model/place.dart';

class DifficultyChart extends StatefulWidget {
  const DifficultyChart({super.key});

  @override
  State<StatefulWidget> createState() => _DifficultyChartState();
}

class _DifficultyChartState extends State<DifficultyChart> {
  Place? _place;

  @override
  Widget build(BuildContext context) {
    return BlocListener<StatBloc, StatBlocState>(
      listener: (context, state) =>
          setState(() => _place = state.sessionsPerPlace.isNotEmpty
              ? state.sessionsPerPlace.keys.first
              : null
          ),
      listenWhen: (_, __) => _place == null,
      child: StatCard(
        title: "Répartition de la difficulté",
        builder: _buildDisplay,
      ),
    );
  }

  Future<Widget> _buildDisplay(
      BuildContext context, StatBlocState state) async {
    {
      final theme = Theme.of(context);

      if (state.sessionsPerPlace.isEmpty) {
        return const Center(
          child: Text("Quantité de donnée insuffisante"),
        );
      }

      if (_place == null) {
        return const Center(
          child: Text("Pas de salle sélectionnée"),
        );
      }

      if (!state.sessionsPerPlace.containsKey(_place)) {
        return const Center(
          child: Text("Salle invalide"),
        );
      }

      final Map<int, int> data = state.sessionsPerPlace[_place]!
          .expand((session) => session.entries)
          .map((entry) => entry.difficultyLevel)
          .fold(
        {},
        (map, difficultyLevel) {
          map.update(
            difficultyLevel.color,
            (value) => value + 1,
            ifAbsent: () => 1,
          );
          return map;
        },
      );

      final sections = data.entries
          .map((entry) => PieChartSectionData(
                color: Color(entry.key),
                value: entry.value.toDouble(),
                title: entry.value.toString(),
                titleStyle: theme.textTheme.labelMedium,
                radius: 40,
                titlePositionPercentageOffset: 1.5,
              ))
          .toList();

      return AspectRatio(
        aspectRatio: 1,
        child: Column(
          children: [
            Expanded(
              child: PieChart(
                PieChartData(
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 50,
                  sections: sections,
                ),
              ),
            ),
            Container(height: 20),
            DropdownMenu(
              dropdownMenuEntries: state.sessionsPerPlace.keys
                  .map((place) => DropdownMenuEntry<Place>(
                        value: place,
                        label: place.name,
                      ))
                  .toList(),
              onSelected: (place) => setState(() => _place = place),
              initialSelection: _place,
            ),
          ],
        ),
      );
    }
  }
}
