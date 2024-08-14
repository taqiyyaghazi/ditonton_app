import 'package:core/common/state_enum.dart';
import 'package:core/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';

import '../bloc/watchlist_movie/watchlist_movie_bloc.dart';
import '../widgets/movie_card_list.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  const WatchlistMoviesPage({super.key});

  @override
  State<WatchlistMoviesPage> createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistMovieBloc>().add(OnGetWatchlistMovies());
    context.read<WatchlistTvBloc>().add(OnGetWatchlistTv());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistMovieBloc>().add(OnGetWatchlistMovies());
    context.read<WatchlistTvBloc>().add(OnGetWatchlistTv());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Watchlist'),
          bottom: const PreferredSize(
            preferredSize: Size(double.infinity, 40),
            child: TabBar(
              dividerHeight: 0,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(
                  icon: Icon(Icons.movie),
                ),
                Tab(
                  icon: Icon(Icons.tv),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBarView(
            children: [
              BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
                builder: (context, state) {
                  if (state.status == RequestState.Loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.status == RequestState.Error) {
                    return Center(
                        key: const Key('error_message'),
                        child: Text(state.message));
                  }
                  if (state.status == RequestState.Loaded) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final movie = state.result[index];
                        return MovieCard(movie);
                      },
                      itemCount: state.result.length,
                    );
                  }
                  return const SizedBox();
                },
              ),
              BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
                builder: (context, state) {
                  if (state.status == RequestState.Loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.status == RequestState.Error) {
                    return Center(
                        key: const Key('error_message'),
                        child: Text(state.message));
                  }
                  if (state.status == RequestState.Loaded) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final tv = state.result[index];
                        return TvCardList(tv);
                      },
                      itemCount: state.result.length,
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
