import 'package:climby/model/place.dart';
import 'package:climby/repository/place_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaceBloc extends Bloc<_PlaceBlocEvent, PlaceBlocState> {
  final PlaceRepository _placeRepository;

  PlaceBloc(this._placeRepository) : super(PlaceBlocState({})) {
    on<FetchPlacesEvent>(_handleFetchPlaces);
  }

  void _handleFetchPlaces(
      FetchPlacesEvent event, Emitter<PlaceBlocState> emit) async {
    final places = await _placeRepository.getAllPlaces();

    emit(PlaceBlocState(places));
  }
}

abstract class _PlaceBlocEvent {}

class FetchPlacesEvent extends _PlaceBlocEvent {}

class PlaceBlocState {
  final Set<Place> places;

  PlaceBlocState(this.places);

  PlaceBlocState append(Set<Place> places) {
    return PlaceBlocState({...this.places, ...places});
  }
}
