import 'package:core/common/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/movie_list/movie_list_bloc.dart';
import '../widgets/movie_card_list.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  const TopRatedMoviesPage({super.key});

  @override
  State<TopRatedMoviesPage> createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    context.read<MovieListBloc>().add(OnGetTopRatedMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MovieListBloc, MovieListState>(
          builder: (context, state) {
            if (state.status == RequestState.Loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == RequestState.Error) {
              return Center(child: Text(state.message));
            }
            if (state.status == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.topRated[index];
                  return MovieCard(movie);
                },
                itemCount: state.topRated.length,
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
