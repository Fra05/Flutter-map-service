part of 'widgets.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return FadeInDown(
            duration: Duration(milliseconds: 300),
            child: buildSearchbar(context));
      },
    );
  }

  Widget buildSearchbar(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: width,
        child: GestureDetector(
          onTap: () async {
            final proximity = context.bloc<MyLocationBloc>().state.location;
            final historial = context.bloc<SearchBloc>().state.historic;

            final result = await showSearch(
                context: context,
                delegate: SearchDestination(proximity, historial));
            this.searchResult(context, result);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            width: double.infinity,
            child: Text('Search destination',
                style: TextStyle(color: Colors.black87)),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 5))
                ]),
          ),
        ),
      ),
    );
  }

  Future searchResult(BuildContext context, SearchResult result) async {
    print('Canceled: ${result.cancel}');

    if (result.cancel) return;

    final mapBloc = context.bloc<MapBloc>();

    mapBloc.goToDestination(result.position);

    // Add to history
    final searchBloc = context.bloc<SearchBloc>();
    searchBloc.add(OnAddHistoric(result));
  }
}
