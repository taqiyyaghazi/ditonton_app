part of 'watchlist_movie_bloc.dart';

class WatchlistMovieState extends Equatable {
  final String message;
  final List<Movie> result;
  final RequestState status;

  const WatchlistMovieState({
    this.message = '',
    this.result = const [],
    this.status = RequestState.Empty,
  });

  WatchlistMovieState copyWith({
    String? message,
    List<Movie>? result,
    RequestState? status,
  }) {
    return WatchlistMovieState(
      message: message ?? this.message,
      result: result ?? this.result,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [message, result, status];
}
