import 'package:climby/bloc/stat_bloc.dart';
import 'package:climby/widget/page/stats/card/difficulty_chart.dart';
import 'package:climby/widget/page/stats/card/general_stats.dart';
import 'package:climby/widget/page/stats/card/score_chart.dart';
import 'package:climby/widget/page/stats/card/session_efficiency_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatefulWidget> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  @override
  void initState() {
    super.initState();

    context.read<StatBloc>().add(FetchStatsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text("Statistiques",
                  style: Theme.of(context).textTheme.titleLarge),
              Container(height: 12),
              const GeneralStats(),
              Container(height: 12),
              const ScoreChart(),
              Container(height: 12),
              const SessionEfficiencyChart(),
              Container(height: 12),
              const DifficultyChart(),
            ],
          ),
        ),
      ),
    );
  }
}
