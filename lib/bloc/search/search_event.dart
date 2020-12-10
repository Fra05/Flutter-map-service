part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class OnAddHistoric extends SearchEvent {
  final SearchResult result;
  OnAddHistoric(this.result);
}
