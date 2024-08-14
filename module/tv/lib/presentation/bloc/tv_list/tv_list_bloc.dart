import 'package:core/common/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv_entities.dart';
import '../../../domain/usecases/get_on_air_tv.dart';
import '../../../domain/usecases/get_popular_tv.dart';
import '../../../domain/usecases/get_top_rated_tv.dart';

part 'tv_list_event.dart';
part 'tv_list_state.dart';

class TvListBloc extends Bloc<TvListEvent, TvListState> {
  final GetOnAirTvUsecases _getOnAirTvUsecases;
  final GetPopularTvUsecases _getPopularTvUsecases;
  final GetTopRatedTvUsecases _getTopRatedTvUsecases;

  TvListBloc(
    this._getOnAirTvUsecases,
    this._getPopularTvUsecases,
    this._getTopRatedTvUsecases,
  ) : super(const TvListState()) {
    on<OnGetOnTheAirTvSeries>(_onGetOnTheAirTvSeries);
    on<OnGetPopularTvSeries>(_onGetPopularTvSeries);
    on<OnGetTopRatedTvSeries>(_onGetTopRatedTvSeries);
  }

  void _onGetOnTheAirTvSeries(
    OnGetOnTheAirTvSeries event,
    Emitter<TvListState> emit,
  ) async {
    emit(state.copyWith(status: RequestState.Loading));
    final result = await _getOnAirTvUsecases.execute();
    result.fold(
      (failure) => emit(state.copyWith(
        status: RequestState.Error,
        message: failure.message,
      )),
      (result) => emit(state.copyWith(
        status: RequestState.Loaded,
        onTheAirTv: result,
      )),
    );
  }

  void _onGetPopularTvSeries(
    OnGetPopularTvSeries event,
    Emitter<TvListState> emit,
  ) async {
    emit(state.copyWith(status: RequestState.Loading));
    final result = await _getPopularTvUsecases.execute();
    result.fold(
      (failure) => emit(state.copyWith(
        status: RequestState.Error,
        message: failure.message,
      )),
      (result) => emit(state.copyWith(
        status: RequestState.Loaded,
        popularTv: result,
      )),
    );
  }

  void _onGetTopRatedTvSeries(
    OnGetTopRatedTvSeries event,
    Emitter<TvListState> emit,
  ) async {
    emit(state.copyWith(status: RequestState.Loading));
    final result = await _getTopRatedTvUsecases.execute();
    result.fold(
      (failure) => emit(state.copyWith(
        status: RequestState.Error,
        message: failure.message,
      )),
      (result) => emit(state.copyWith(
        status: RequestState.Loaded,
        topRatedTv: result,
      )),
    );
  }
}
