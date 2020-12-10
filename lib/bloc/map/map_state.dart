part of 'map_bloc.dart';

@immutable
class MapState {
  final bool mapDone;

  final LatLng middleLocation;

  MapState({
    this.mapDone = false,
    this.middleLocation,
  });

  MapState copyWith({
    bool mapDone,
    LatLng middleLocation,
  }) =>
      MapState(
        mapDone: mapDone ?? this.mapDone,
        middleLocation: middleLocation ?? this.middleLocation,
      );
}
