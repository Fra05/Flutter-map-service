import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:mapa_app/theme/uber_map_theme.dart';
import 'package:meta/meta.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(new MapState());

  // Controlador del mapa
  GoogleMapController _mapController;

  void initMapa(GoogleMapController controller) {
    if (!state.mapDone) {
      this._mapController = controller;
      this._mapController.setMapStyle(jsonEncode(uberMapTheme));

      add(OnMapDone());
    }
  }

  void cameraMove(LatLng destino) {
    final cameraUpdate = CameraUpdate.newCameraPosition(
      CameraPosition(
        target: destino,
        zoom: 15,
      ),
    );
    this._mapController?.animateCamera(cameraUpdate);
  }

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    if (event is OnMapDone) {
      yield state.copyWith(mapDone: true);
    } else if (event is OnMoveMap) {
      yield state.copyWith(middleLocation: event.middleMap);
    }
  }

  void goToDestination(LatLng destino) {
    this._mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: destino,
              zoom: 15,
            ),
          ),
        );
  }
}
