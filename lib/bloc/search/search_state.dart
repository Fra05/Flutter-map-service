part of 'search_bloc.dart';

@immutable
class SearchState {
  final List<SearchResult> historic;

  SearchState({List<SearchResult> historic})
      : this.historic = (historic == null) ? [] : historic;

  SearchState copyWith({List<SearchResult> historic}) => SearchState(
        historic: historic ?? this.historic,
      );
}
