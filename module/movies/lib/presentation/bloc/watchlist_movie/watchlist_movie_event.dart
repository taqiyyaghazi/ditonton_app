part of 'watchlist_movie_bloc.dart';

sealed class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();

  @override
  List<Object> get props => [];
}

class OnGetWatchlistMovies extends WatchlistMovieEvent {}
