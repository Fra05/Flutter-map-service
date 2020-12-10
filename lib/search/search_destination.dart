import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:mapa_app/models/search_response.dart';

import 'package:mapa_app/models/search_result.dart';
import 'package:mapa_app/services/traffic_service.dart';

class SearchDestination extends SearchDelegate<SearchResult> {
  @override
  final String searchFieldLabel;
  final TrafficService _trafficService;
  final LatLng proximidad;
  final List<SearchResult> historial;

  SearchDestination(this.proximidad, this.historial)
      : this.searchFieldLabel = 'Search...',
        this._trafficService = new TrafficService();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: () => this.query = '')
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () => this.close(context, SearchResult(cancel: true)));
  }

  @override
  Widget buildResults(BuildContext context) {
    return this._buildResultsSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (this.query.length == 0) {
      return ListView(
        children: [
          ...this
              .historial
              .map((result) => ListTile(
                    leading: Icon(Icons.history),
                    title: Text(result.destinationName),
                    subtitle: Text(result.description),
                    onTap: () {
                      this.close(context, result);
                    },
                  ))
              .toList()
        ],
      );
    }

    return this._buildResultsSuggestions();
  }

  Widget _buildResultsSuggestions() {
    if (this.query == 0) {
      return Container();
    }

    this
        ._trafficService
        .getSuggestionsPorQuery(this.query.trim(), this.proximidad);

    return StreamBuilder(
        stream: this._trafficService.suggestionsStream,
        builder:
            (BuildContext context, AsyncSnapshot<SearchResponse> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final places = snapshot.data.features;

          if (places.length == 0) {
            return ListTile(
              title: Text('No hay resultados con $query'),
            );
          }

          return ListView.separated(
            itemCount: places.length,
            separatorBuilder: (_, i) => Divider(),
            itemBuilder: (_, i) {
              final place = places[i];

              return ListTile(
                leading: Icon(Icons.place),
                title: Text(place.textEs),
                subtitle: Text(place.placeNameEs),
                onTap: () {
                  this.close(
                      context,
                      SearchResult(
                          cancel: false,
                          position: LatLng(place.center[1], place.center[0]),
                          destinationName: place.textEs,
                          description: place.placeNameEs));
                },
              );
            },
          );
        });
  }
}
