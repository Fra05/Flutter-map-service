import 'package:meta/meta.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class SearchResult {
  final bool cancel;
  final LatLng position;
  final String destinationName;
  final String description;

  SearchResult(
      {@required this.cancel,
      this.position,
      this.destinationName,
      this.description});
}
