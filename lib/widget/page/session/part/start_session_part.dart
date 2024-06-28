import 'package:climby/bloc/place_bloc.dart';
import 'package:climby/bloc/session_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../model/place.dart';

class StartSessionPart extends StatefulWidget {
  const StartSessionPart({super.key});

  @override
  State<StatefulWidget> createState() => _StartSessionPartState();
}

class _StartSessionPartState extends State<StartSessionPart> {
  Place? _place;

  @override
  void initState() {
    super.initState();

    context.read<PlaceBloc>().add(FetchPlacesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Choisir une salle",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            BlocBuilder<PlaceBloc, PlaceBlocState>(
              builder: (context, state) => DropdownMenu(
                dropdownMenuEntries: state.places
                    .map((place) => DropdownMenuEntry<Place>(
                          value: place,
                          label: place.name,
                        ))
                    .toList(),
                onSelected: (place) => setState(() => _place = place),
                trailingIcon:
                    state.isLoading ? const CircularProgressIndicator() : null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: FilledButton(
                onPressed: _place != null
                    ? () => context
                        .read<SessionBloc>()
                        .add(StartSessionEvent(_place!))
                    : null,
                child: const Text("Démarrer une session"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
