import 'package:climby/model/session.dart';
import 'package:flutter/material.dart';

class SessionLevelsBar extends StatelessWidget {
  final Session session;
  final double height;

  const SessionLevelsBar({super.key, required this.session, this.height = 10});

  @override
  Widget build(BuildContext context) {
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
}
