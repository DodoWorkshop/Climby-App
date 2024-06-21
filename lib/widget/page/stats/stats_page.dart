import 'package:climby/widget/page/stats/tmp/test_chart.dart';
import 'package:climby/widget/page/stats/tmp/test_chart_2.dart';
import 'package:flutter/material.dart';


class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text("Stats", style:  Theme.of(context).textTheme.titleLarge),
              Container(height: 12),
              LineChartSample4(),
              Container(height: 12),
              RadarChartSample1()
            ],
          ),
        ),
      ),
    );
  }
}
