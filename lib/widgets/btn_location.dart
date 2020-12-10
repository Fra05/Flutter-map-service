part of 'widgets.dart';

class BtnUbicacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapBloc = context.bloc<MapBloc>();
    final myLocation = context.bloc<MyLocationBloc>();

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(Icons.my_location, color: Colors.black87),
          onPressed: () {
            final destination = myLocation.state.location;
            mapBloc.cameraMove(destination);
          },
        ),
      ),
    );
  }
}
