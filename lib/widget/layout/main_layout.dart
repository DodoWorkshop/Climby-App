import 'package:climby/widget/generic/profile_button.dart';
import 'package:climby/widget/page/history/history_page.dart';
import 'package:climby/widget/page/session/session_page.dart';
import 'package:climby/widget/page/stats/stats_page.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<StatefulWidget> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: const TabBarView(
          children: [
            SessionPage(),
            StatsPage(),
            HistoryPage(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      bottom: const TabBar(
        tabs: [
          Tab(icon: Icon(Icons.play_arrow)),
          Tab(icon: Icon(Icons.bar_chart)),
          Tab(icon: Icon(Icons.history)),
        ],
      ),
      leading: const Image(image: AssetImage('assets/logo.png')),
      title: Center(
          child: Text('Climby', style: Theme.of(context).textTheme.titleLarge)),
      actions: const [ProfileButton()],
    );
  }
}
