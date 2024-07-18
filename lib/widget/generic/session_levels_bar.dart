import 'package:climby/model/session.dart';
import 'package:flutter/material.dart';

enum SessionLevelsBarSorting { difficulty, creationDate }

class SessionLevelsBar extends StatelessWidget {
  final Session session;
  final double height;
  final SessionLevelsBarSorting sorting;

  const SessionLevelsBar({
    super.key,
    required this.session,
    this.height = 10,
    this.sorting = SessionLevelsBarSorting.creationDate,
  });

  @override
  Widget build(BuildContext context) {
    switch (sorting) {
      case SessionLevelsBarSorting.difficulty:
        return _handleDifficultySorting();
      case SessionLevelsBarSorting.creationDate:
        return _handleCreationDateSorting();
    }
  }

  Widget _handleDifficultySorting() {
    final Map<int, int> data =
        session.entries.map((entry) => entry.difficultyLevel).fold(
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

    return Row(
        children: data.entries
            .map(
              (entry) => Flexible(
                flex: entry.value,
                child: Container(
                  height: height,
                  color: Color(entry.key),
                ),
              ),
            )
            .toList());
  }

  Widget _handleCreationDateSorting() {
    var entries = List.from(session.entries);
    entries.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    return Row(
        children: entries
            .map(
              (entry) => Flexible(
                flex: 1,
                child: Container(
                  height: height,
                  color: Color(entry.difficultyLevel.color),
                ),
              ),
            )
            .toList());
  }
}
