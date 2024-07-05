import 'package:climby/util/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/stat_bloc.dart';

typedef StatCardWidgetBuilder = Future<Widget> Function(
    BuildContext context, StatBlocState state);

class StatCard extends StatelessWidget {
  final String title;
  final StatCardWidgetBuilder builder;

  const StatCard({super.key, required this.title, required this.builder});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Container(height: 10),
            BlocBuilder<StatBloc, StatBlocState>(builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: Text("Chargement en cours..."),
                );
              }

              return FutureBuilder(
                  future: builder.call(context, state),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      LogUtils.logError(snapshot.error!);
                      return const Center(
                        child: Text("Une erreur s'est produite"),
                      );
                    }

                    if (!snapshot.hasData) {
                      return const Center(
                        child: Text("Construction en cours..."),
                      );
                    }

                    return snapshot.data!;
                  });
            }),
          ],
        ),
      ),
    );
  }
}
