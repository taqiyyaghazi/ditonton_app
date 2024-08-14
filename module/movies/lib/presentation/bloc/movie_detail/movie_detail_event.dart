part of 'movie_detail_bloc.dart';

sealed class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class OnFetchMovieDetail extends MovieDetailEvent {
  final int id;

  const OnFetchMovieDetail({required this.id});

  @override
  List<Object> get props => [id];
}

class OnAddWatchlistMovie extends MovieDetailEvent {
  final MovieDetail movieDetail;

  const OnAddWatchlistMovie(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class OnRemoveFromWatchlistMovies extends MovieDetailEvent {
  final MovieDetail movieDetail;

  const OnRemoveFromWatchlistMovies(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class OnLoadWatchlistStatusMovie extends MovieDetailEvent {
  final int id;

  const OnLoadWatchlistStatusMovie(this.id);

  @override
  List<Object> get props => [id];
}
