part of 'my_location_bloc.dart';

@immutable
class MyLocationState {
  final bool isLocation;
  final LatLng location;

  MyLocationState({this.isLocation = false, this.location});

  MyLocationState copyWith({
    bool isLocation,
    LatLng location,
  }) =>
      new MyLocationState(
        isLocation: isLocation ?? this.isLocation,
        location: location ?? this.location,
      );
}
