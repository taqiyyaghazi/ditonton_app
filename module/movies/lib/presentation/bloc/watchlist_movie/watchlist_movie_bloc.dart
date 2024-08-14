import 'package:core/common/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_watchlist_movies.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies _getWatchlistMovies;
  WatchlistMovieBloc(
    this._getWatchlistMovies,
  ) : super(const WatchlistMovieState()) {
    on<OnGetWatchlistMovies>((event, emit) async {
      emit(state.copyWith(status: RequestState.Loading));
      final result = await _getWatchlistMovies.execute();
      result.fold(
        (failure) => emit(state.copyWith(
          status: RequestState.Error,
          message: failure.message,
        )),
        (result) => emit(state.copyWith(
          status: RequestState.Loaded,
          result: result,
        )),
      );
    });
  }
}
