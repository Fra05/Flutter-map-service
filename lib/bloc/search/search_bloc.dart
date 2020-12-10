import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mapa_app/models/search_result.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is OnAddHistoric) {
      final exist = state.historic
          .where((result) =>
              result.destinationName == event.result.destinationName)
          .length;

      if (exist == 0) {
        final newHistoric = [...state.historic, event.result];
        yield state.copyWith(historic: newHistoric);
      }
    }
  }
}
