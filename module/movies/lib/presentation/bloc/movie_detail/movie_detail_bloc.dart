import 'package:core/common/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/entities/movie_detail.dart';
import '../../../domain/usecases/get_movie_detail.dart';
import '../../../domain/usecases/get_movie_recommendations.dart';
import '../../../domain/usecases/get_watchlist_status.dart';
import '../../../domain/usecases/remove_watchlist.dart';
import '../../../domain/usecases/save_watchlist.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieDetailBloc(
    this.getMovieDetail,
    this.getMovieRecommendations,
    this.getWatchListStatus,
    this.saveWatchlist,
    this.removeWatchlist,
  ) : super(const MovieDetailState()) {
    on<OnFetchMovieDetail>(_onFetchMovieDetail);
    on<OnAddWatchlistMovie>(_onAddWatchlistMovie);
    on<OnRemoveFromWatchlistMovies>(_onRemoveFromWatchlistMovies);
    on<OnLoadWatchlistStatusMovie>(_onLoadWatchlistStatusMovie);
  }

  void _onFetchMovieDetail(
    OnFetchMovieDetail event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(state.copyWith(statusMovie: RequestState.Loading));
    final detailResult = await getMovieDetail.execute(event.id);
    final recommendationResult =
        await getMovieRecommendations.execute(event.id);
    detailResult.fold(
      (failure) {
        emit(state.copyWith(
          statusMovie: RequestState.Error,
          message: failure.message,
        ));
      },
      (data) {
        emit(state.copyWith(
          statusRecommendations: RequestState.Loading,
          statusMovie: RequestState.Loaded,
          movieDetail: data,
        ));
        recommendationResult.fold(
          (failure) {
            emit(state.copyWith(
              statusRecommendations: RequestState.Error,
              message: failure.message,
            ));
          },
          (datas) {
            if (datas.isEmpty) {
              emit(state.copyWith(statusRecommendations: RequestState.Empty));
            } else {
              emit(state.copyWith(
                statusRecommendations: RequestState.Loaded,
                movieRecommendations: datas,
              ));
            }
          },
        );
      },
    );
  }

  void _onAddWatchlistMovie(
    OnAddWatchlistMovie event,
    Emitter<MovieDetailState> emit,
  ) async {
    final movieDetail = event.movieDetail;
    final result = await saveWatchlist.execute(movieDetail);

    result.fold(
      (failure) => emit(state.copyWith(watchlistMessage: failure.message)),
      (successMessage) =>
          emit(state.copyWith(watchlistMessage: successMessage)),
    );

    add(OnLoadWatchlistStatusMovie(movieDetail.id));
  }

  void _onRemoveFromWatchlistMovies(
    OnRemoveFromWatchlistMovies event,
    Emitter<MovieDetailState> emit,
  ) async {
    final movieDetail = event.movieDetail;
    final result = await removeWatchlist.execute(movieDetail);

    result.fold(
      (failure) => emit(state.copyWith(watchlistMessage: failure.message)),
      (successMessage) =>
          emit(state.copyWith(watchlistMessage: successMessage)),
    );

    add(OnLoadWatchlistStatusMovie(movieDetail.id));
  }

  void _onLoadWatchlistStatusMovie(
    OnLoadWatchlistStatusMovie event,
    Emitter<MovieDetailState> emit,
  ) async {
    final status = await getWatchListStatus.execute(event.id);
    emit(state.copyWith(isAddedtoWatchlist: status));
  }
}
