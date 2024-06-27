import 'package:climby/bloc/stat_bloc.dart';
import 'package:climby/widget/page/stats/card/stat_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScoreChart extends StatefulWidget {
  const ScoreChart({super.key});

  @override
  State<StatefulWidget> createState() => _ScoreChartState();
}

class _ScoreChartState extends State<ScoreChart> {
  bool _meanEnabled = false;

  @override
  Widget build(BuildContext context) {
    return StatCard(
      title: "Évolution du score",
      builder: _buildDisplay,
    );
  }

  Future<Widget> _buildDisplay(
      BuildContext context, StatBlocState state) async {
    final theme = Theme.of(context);

    if (state.sessionsPerPlace.isEmpty) {
      return const Center(
        child: Text("Quantité de donnée insuffisante"),
      );
    }

    var best = 0;
    final points =
        state.allSessions.where((session) => session.isDone).map((session) {
      final score = session.computeScore();
      if (score > best) {
        best = score;
      }

      return FlSpot(
        session.startedAt.millisecondsSinceEpoch.toDouble(),
        score.toDouble(),
      );
    }).toList();

    final mean = points.map((point) => point.y).reduce((v1, v2) => v1 + v2) /
        points.length;

    points.sort((point1, point2) => point1.x.compareTo(point2.x));

    final minX = points.first.x;
    final maxX = points.last.x + 1000000000;

    return AspectRatio(
      aspectRatio: 1.4,
      child: Column(
        children: [
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: true),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(),
                  leftTitles: AxisTitles(
                    axisNameWidget: Text(
                      "Score",
                      style: theme.textTheme.labelMedium,
                    ),
                    sideTitles: const SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      interval: 30,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      // => A month in milliseconds
                      interval: 2592000000,
                      getTitlesWidget: (value, meta) {
                        final DateTime date =
                            DateTime.fromMillisecondsSinceEpoch(value.toInt());
                        final DateFormat formatter = DateFormat('MMM');
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: Text(
                            formatter.format(date),
                            style: theme.textTheme.labelSmall,
                          ),
                        );
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(),
                ),
                borderData: FlBorderData(show: true),
                minY: 0,
                maxY: best + 20,
                minX: minX,
                maxX: maxX,
                lineBarsData: [
                  LineChartBarData(
                    spots: points,
                    color: theme.colorScheme.primary,
                    barWidth: 4,
                    belowBarData: BarAreaData(
                      show: _meanEnabled,
                      color: theme.colorScheme.secondary.withOpacity(0.4),
                      cutOffY: mean,
                      applyCutOffY: true,
                    ),
                    aboveBarData: BarAreaData(
                      show: _meanEnabled,
                      color: theme.colorScheme.primary.withOpacity(0.4),
                      cutOffY: mean,
                      applyCutOffY: true,
                    ),
                  ),
                  LineChartBarData(
                    show: _meanEnabled,
                    spots: [
                      FlSpot(minX, mean),
                      FlSpot(maxX, mean),
                    ],
                    color: theme.colorScheme.secondary,
                    dotData: const FlDotData(
                      show: false,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () => setState(() => _meanEnabled = !_meanEnabled),
                child:
                    Text("${_meanEnabled ? 'Cacher' : 'Afficher'} la moyenne"),
              )
            ],
          )
        ],
      ),
    );
  }
}
