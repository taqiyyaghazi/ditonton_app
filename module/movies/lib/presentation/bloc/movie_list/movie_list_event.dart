part of 'movie_list_bloc.dart';

sealed class MovieListEvent extends Equatable {
  const MovieListEvent();

  @override
  List<Object> get props => [];
}

class OnGetNowPlayingMovies extends MovieListEvent {}

class OnGetPopularMovies extends MovieListEvent {}

class OnGetTopRatedMovies extends MovieListEvent {}
