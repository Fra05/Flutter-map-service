import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:mapa_app/bloc/map/map_bloc.dart';
import 'package:mapa_app/bloc/my_location/my_location_bloc.dart';

import 'package:mapa_app/widgets/widgets.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    context.bloc<MyLocationBloc>().startTracking();

    super.initState();
  }

  @override
  void dispose() {
    context.bloc<MyLocationBloc>().cancelTracking();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<MyLocationBloc, MyLocationState>(
              builder: (_, state) => createMap(state)),
          Positioned(top: 15, child: SearchBar()),
        ],
      ),
      floatingActionButton: BtnUbicacion(),
    );
  }

  Widget createMap(MyLocationState state) {
    if (!state.isLocation) return Center(child: Text('Ubicando...'));

    final mapBloc = BlocProvider.of<MapBloc>(context);

    final cameraPosition = new CameraPosition(target: state.location, zoom: 15);

    return BlocBuilder<MapBloc, MapState>(
      builder: (context, _) {
        return GoogleMap(
          initialCameraPosition: cameraPosition,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: true,
          onMapCreated: mapBloc.initMapa,
          onCameraMove: (cameraPosition) =>
              mapBloc.add(OnMoveMap(cameraPosition.target)),
        );
      },
    );
  }
}
