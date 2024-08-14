import 'package:core/common/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_now_playing_movies.dart';
import '../../../domain/usecases/get_popular_movies.dart';
import '../../../domain/usecases/get_top_rated_movies.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies _getNowPlayingMovies;
  final GetPopularMovies _getPopularMovies;
  final GetTopRatedMovies _getTopRatedMovies;

  MovieListBloc(
    this._getNowPlayingMovies,
    this._getPopularMovies,
    this._getTopRatedMovies,
  ) : super(const MovieListState()) {
    on<OnGetNowPlayingMovies>(_onGetNowPlayingMovies);
    on<OnGetPopularMovies>(_onGetPopularMovies);
    on<OnGetTopRatedMovies>(_onGetTopRatedMovies);
  }

  void _onGetNowPlayingMovies(
    OnGetNowPlayingMovies event,
    Emitter<MovieListState> emit,
  ) async {
    emit(state.copyWith(status: RequestState.Loading));
    final result = await _getNowPlayingMovies.execute();

    result.fold(
      (failure) => emit(state.copyWith(
        status: RequestState.Error,
        message: failure.message,
      )),
      (data) => emit(state.copyWith(
        status: RequestState.Loaded,
        nowPlaying: data,
      )),
    );
  }

  void _onGetPopularMovies(
    OnGetPopularMovies event,
    Emitter<MovieListState> emit,
  ) async {
    emit(state.copyWith(status: RequestState.Loading));
    final result = await _getPopularMovies.execute();

    result.fold(
      (failure) => emit(state.copyWith(
        status: RequestState.Error,
        message: failure.message,
      )),
      (data) => emit(state.copyWith(
        status: RequestState.Loaded,
        popular: data,
      )),
    );
  }

  void _onGetTopRatedMovies(
    OnGetTopRatedMovies event,
    Emitter<MovieListState> emit,
  ) async {
    emit(state.copyWith(status: RequestState.Loading));
    final result = await _getTopRatedMovies.execute();

    result.fold(
      (failure) => emit(state.copyWith(
        status: RequestState.Error,
        message: failure.message,
      )),
      (data) => emit(state.copyWith(
        status: RequestState.Loaded,
        topRated: data,
      )),
    );
  }
}
