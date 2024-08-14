import 'package:core/common/state_enum.dart';
import 'package:core/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:movies/presentation/widgets/movie_card_list.dart';
import 'package:tv/presentation/bloc/tv_search/tv_search_bloc.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';

  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
          bottom: const PreferredSize(
            preferredSize: Size(double.infinity, 40),
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              dividerHeight: 0,
              tabs: [
                Tab(icon: Icon(Icons.movie)),
                Tab(icon: Icon(Icons.tv)),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TabBarView(
            children: [
              // MOVIE
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    onChanged: (query) {
                      context
                          .read<MovieSearchBloc>()
                          .add(OnQueryChanged(query));
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search title',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.search,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Search Result',
                    style: kHeading6,
                  ),
                  BlocBuilder<MovieSearchBloc, MovieSearchState>(
                    builder: (context, state) {
                      if (state is SearchLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is SearchHasData) {
                        final result = state.result;
                        return Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemBuilder: (context, index) {
                              final movie = result[index];
                              return MovieCard(movie);
                            },
                            itemCount: result.length,
                          ),
                        );
                      }
                      if (state is SearchError) {
                        return Expanded(
                            child: Center(child: Text(state.message)));
                      }
                      return Expanded(child: Container());
                    },
                  ),
                ],
              ),
              // TV
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    onChanged: (value) {
                      context
                          .read<TvSearchBloc>()
                          .add(OnTvQueryChanged(query: value));
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search title',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.search,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Search Result',
                    style: kHeading6,
                  ),
                  BlocBuilder<TvSearchBloc, TvSearchState>(
                    builder: (context, state) {
                      if (state.status == RequestState.Loading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state.status == RequestState.Error) {
                        return Expanded(
                            child: Center(child: Text(state.message)));
                      }
                      if (state.status == RequestState.Loaded) {
                        final result = state.result;
                        return Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemBuilder: (context, index) {
                              final tv = result[index];
                              return TvCardList(tv);
                            },
                            itemCount: result.length,
                          ),
                        );
                      }
                      return Expanded(
                        child: Container(),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
