part of 'movie_detail_bloc.dart';

class MovieDetailState extends Equatable {
  final String message;
  final List<Movie> movieRecommendations;
  final MovieDetail? movieDetail;
  final RequestState statusMovie;
  final RequestState statusRecommendations;
  final String watchlistMessage;
  final bool isAddedtoWatchlist;

  const MovieDetailState({
    this.message = '',
    this.movieRecommendations = const [],
    this.movieDetail,
    this.statusMovie = RequestState.Empty,
    this.statusRecommendations = RequestState.Empty,
    this.watchlistMessage = '',
    this.isAddedtoWatchlist = false,
  });

  MovieDetailState copyWith({
    String? message,
    List<Movie>? movieRecommendations,
    MovieDetail? movieDetail,
    RequestState? statusMovie,
    RequestState? statusRecommendations,
    String? watchlistMessage,
    bool? isAddedtoWatchlist,
  }) {
    return MovieDetailState(
      message: message ?? this.message,
      movieRecommendations: movieRecommendations ?? this.movieRecommendations,
      movieDetail: movieDetail ?? this.movieDetail,
      statusMovie: statusMovie ?? this.statusMovie,
      statusRecommendations:
          statusRecommendations ?? this.statusRecommendations,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedtoWatchlist: isAddedtoWatchlist ?? this.isAddedtoWatchlist,
    );
  }

  @override
  List<Object?> get props {
    return [
      message,
      movieRecommendations,
      movieDetail,
      statusMovie,
      statusRecommendations,
      watchlistMessage,
      isAddedtoWatchlist,
    ];
  }
}
