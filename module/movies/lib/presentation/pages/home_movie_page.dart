import 'package:core/common/state_enum.dart';
import 'package:core/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/movie_list/movie_list_bloc.dart';
import '../widgets/movie_list.dart';
import '../widgets/show_heading.dart';
import 'popular_movies_page.dart';
import 'top_rated_movies_page.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({super.key});

  @override
  State<HomeMoviePage> createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    context.read<MovieListBloc>()
      ..add(OnGetNowPlayingMovies())
      ..add(OnGetPopularMovies())
      ..add(OnGetTopRatedMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<MovieListBloc, MovieListState>(
                builder: (context, state) {
                  if (state.status == RequestState.Loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.status == RequestState.Error) {
                    return Center(child: Text(state.message));
                  }
                  if (state.status == RequestState.Loaded) {
                    return MovieList(state.nowPlaying);
                  }
                  return const SizedBox();
                },
              ),
              buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<MovieListBloc, MovieListState>(
                builder: (context, state) {
                  if (state.status == RequestState.Loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.status == RequestState.Error) {
                    return Center(child: Text(state.message));
                  }
                  if (state.status == RequestState.Loaded) {
                    return MovieList(state.popular);
                  }
                  return const SizedBox();
                },
              ),
              buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<MovieListBloc, MovieListState>(
                builder: (context, state) {
                  if (state.status == RequestState.Loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.status == RequestState.Error) {
                    return Center(child: Text(state.message));
                  }
                  if (state.status == RequestState.Loaded) {
                    return MovieList(state.topRated);
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
}
