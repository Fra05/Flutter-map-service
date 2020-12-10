part of 'my_location_bloc.dart';

@immutable
abstract class MyLocationEvent {}

class OnNewLocation extends MyLocationEvent {
  final LatLng location;
  OnNewLocation(this.location);
}
