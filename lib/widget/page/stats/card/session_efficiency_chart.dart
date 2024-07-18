import 'package:climby/bloc/stat_bloc.dart';
import 'package:climby/widget/page/stats/card/stat_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../util/tuple.dart';

class SessionEfficiencyChart extends StatelessWidget {
  static const int step = 10;

  const SessionEfficiencyChart({super.key});

  @override
  Widget build(BuildContext context) {
    return StatCard(
      title: "Efficacité en session",
      builder: _buildDisplay,
    );
  }

  Future<Widget> _buildDisplay(
      BuildContext context, StatBlocState state) async {
    if (state.allSessions.isEmpty) {
      return const Center(
        child: Text("Quantité de donnée insuffisante"),
      );
    }

    final theme = Theme.of(context);

    final entries =
        state.allSessions.fold(<Tuple<int, int>>[], (entries, session) {
      if (session.isDone) {
        for (var entry in session.entries) {
          final minutesSinceStart = Duration(
            milliseconds: entry.createdAt.millisecondsSinceEpoch -
                session.startedAt.millisecondsSinceEpoch,
          ).inMinutes;
          entries.add(Tuple(minutesSinceStart, entry.difficultyLevel.score));
        }
      }
      return entries;
    }).toList();

    final totalScore =
        entries.map((entry) => entry.item2).reduce((a, b) => a + b);

    entries.sort((a, b) => a.item1.compareTo(b.item1));

    final List<Tuple<int, int>> groupedPoints = [];
    int currentX = 0;
    int currentY = 0;

    for (var point in entries) {
      if ((point.item1 - currentX).abs() <= step) {
        currentY += point.item2;
      } else {
        groupedPoints.add(Tuple(currentX, currentY));
        currentX = point.item1;
        currentY = point.item2;
      }
    }
    groupedPoints.add(Tuple(currentX, currentY));

    final data = groupedPoints
        .map(
          (point) => FlSpot(
            point.item1.toDouble(),
            point.item2 / totalScore,
          ),
        )
        .toList();

    return AspectRatio(
      aspectRatio: 1.4,
      child: LineChart(
        LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: data,
                dotData: const FlDotData(show: false),
                color: theme.colorScheme.primary,
                isCurved: true,
                curveSmoothness: 0.3,
                belowBarData: BarAreaData(
                  show: true,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
            minY: 0,
            minX: 0,
            maxY: 1,
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                axisNameWidget: const Text("Pourcentage de score"),
                axisNameSize: 30,
                sideTitles: SideTitles(
                  interval: 0.2,
                  showTitles: true,
                  reservedSize: 40,
                  getTitlesWidget: (value, meta) {
                    return Text('${(value * 100).toInt()}%');
                  },
                ),
              ),
              rightTitles: const AxisTitles(),
              bottomTitles: AxisTitles(
                axisNameWidget: const Text("Temps en minute"),
                sideTitles: SideTitles(
                  interval: 10,
                  showTitles: true,
                  reservedSize: 20,
                  getTitlesWidget: (value, meta) {
                    return Text('${value.toInt()}');
                  },
                ),
              ),
              topTitles: const AxisTitles(),
            )),
        curve: Curves.linear,
        duration: const Duration(milliseconds: 400),
      ),
    );
  }
}
