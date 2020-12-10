import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

part 'my_location_event.dart';
part 'my_location_state.dart';

class MyLocationBloc extends Bloc<MyLocationEvent, MyLocationState> {
  MyLocationBloc() : super(MyLocationState());

  // Geolocator
  final _geolocator = new Geolocator();
  StreamSubscription<Position> _positionSubscription;

  void startTracking() {
    final locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

    _positionSubscription = this
        ._geolocator
        .getPositionStream(locationOptions)
        .listen((Position position) {
      final newLocation = new LatLng(position.latitude, position.longitude);
      add(OnNewLocation(newLocation));
    });
  }

  void cancelTracking() {
    _positionSubscription?.cancel();
  }

  @override
  Stream<MyLocationState> mapEventToState(MyLocationEvent event) async* {
    if (event is OnNewLocation) {
      yield state.copyWith(isLocation: true, location: event.location);
    }
  }
}
