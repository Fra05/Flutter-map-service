part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

class OnMapDone extends MapEvent {}

class OnMoveMap extends MapEvent {
  final LatLng middleMap;
  OnMoveMap(this.middleMap);
}

class OnNewLocation extends MapEvent {
  final LatLng location;
  OnNewLocation(this.location);
}
