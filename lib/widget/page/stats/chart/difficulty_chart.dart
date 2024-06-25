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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "Répartition de la difficulté",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Container(height: 10),
            AspectRatio(
              aspectRatio: 1,
              child: BlocListener<StatBloc, StatBlocState>(
                listener: (context, state) => setState(() => _place = state.sessionsPerPlace.keys.first),
                listenWhen: (_, __) => _place == null,
                child: BlocBuilder<StatBloc, StatBlocState>(
                  builder: (context, state) {
                    final theme = Theme.of(context);

                    if (state.isLoading) {
                      return const Center(
                        child: Text("Chargement en cours..."),
                      );
                    }

                    if (state.sessionsPerPlace.isEmpty) {
                      return const Center(
                        child: Text("Quantité de donnée insuffisante"),
                      );
                    }

                    if(_place == null){
                      return const Center(
                        child: Text("Pas de salle sélectionnée"),
                      );
                    }


                    if(!state.sessionsPerPlace.containsKey(_place)){
                      return const Center(
                        child: Text("Salle invalide"),
                      );
                    }

                    final Map<int, int> data = state.sessionsPerPlace[_place]
                        !.expand((session) => session.entries)
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

                    return Column(
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
                          dropdownMenuEntries: state.sessionsPerPlace
                              .keys
                              .map((place) => DropdownMenuEntry<Place>(
                            value: place,
                            label: place.name,
                          ))
                              .toList(),
                          onSelected: (place) => setState(() => _place = place),
                          initialSelection: _place,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
