part of 'movie_list_bloc.dart';

class MovieListState extends Equatable {
  final String message;
  final RequestState status;
  final List<Movie> nowPlaying;
  final List<Movie> popular;
  final List<Movie> topRated;

  const MovieListState({
    this.message = '',
    this.status = RequestState.Empty,
    this.nowPlaying = const [],
    this.popular = const [],
    this.topRated = const [],
  });

  MovieListState copyWith({
    String? message,
    RequestState? status,
    List<Movie>? nowPlaying,
    List<Movie>? popular,
    List<Movie>? topRated,
  }) {
    return MovieListState(
      message: message ?? this.message,
      status: status ?? this.status,
      nowPlaying: nowPlaying ?? this.nowPlaying,
      popular: popular ?? this.popular,
      topRated: topRated ?? this.topRated,
    );
  }

  @override
  List<Object> get props => [message, status, nowPlaying, popular, topRated];
}
