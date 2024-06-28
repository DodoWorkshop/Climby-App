import 'package:climby/model/place.dart';
import 'package:climby/repository/place_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaceBloc extends Bloc<_PlaceBlocEvent, PlaceBlocState> {
  final PlaceRepository _placeRepository;

  PlaceBloc(this._placeRepository) : super(PlaceBlocState.value({})) {
    on<FetchPlacesEvent>(_handleFetchPlaces);
  }

  void _handleFetchPlaces(
      FetchPlacesEvent event, Emitter<PlaceBlocState> emit) async {
    emit(PlaceBlocState.loading());

    final places = await _placeRepository.getAllPlaces();

    emit(PlaceBlocState.value(places));
  }
}

abstract class _PlaceBlocEvent {}

class FetchPlacesEvent extends _PlaceBlocEvent {}

class PlaceBlocState {
  final bool isLoading;
  final Set<Place> places;

  PlaceBlocState(this.isLoading, this.places);

  factory PlaceBlocState.loading() => PlaceBlocState(true, {});

  factory PlaceBlocState.value(Set<Place> places) =>
      PlaceBlocState(false, places);

  PlaceBlocState append(Set<Place> places) {
    return PlaceBlocState(false, {...this.places, ...places});
  }
}
