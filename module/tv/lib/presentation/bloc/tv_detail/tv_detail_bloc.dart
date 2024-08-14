import 'package:core/common/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv_detail_entities.dart';
import '../../../domain/entities/tv_entities.dart';
import '../../../domain/usecases/get_tv_detail.dart';
import '../../../domain/usecases/get_tv_recommendations.dart';
import '../../../domain/usecases/get_watchlist_tv_status.dart';
import '../../../domain/usecases/remove_watchlist_tv.dart';
import '../../../domain/usecases/save_watchlist_tv.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvDetailUsecases _getTvDetailUsecases;
  final GetTvRecommendationsUsecases _getTvRecommendationsUsecases;
  final GetWatchlistTvStatusUsecases _getWatchlistTvStatusUsecases;
  final SaveWatchlistTvUsecases _saveWatchlistTvUsecases;
  final RemoveWatchlistTvUsecases _removeWatchlistTvUsecases;

  TvDetailBloc(
    this._getTvDetailUsecases,
    this._getTvRecommendationsUsecases,
    this._getWatchlistTvStatusUsecases,
    this._saveWatchlistTvUsecases,
    this._removeWatchlistTvUsecases,
  ) : super(const TvDetailState()) {
    on<OnFetchTvDetail>(_onFetchTvDetail);
    on<OnAddWatchlistTv>(_onAddWatchlistTv);
    on<OnRemoveFromWatchlistTv>(_onRemoveFromWatchlistTv);
    on<OnLoadWatchlistStatusTv>(_onLoadWatchlistStatusTv);
  }

  void _onFetchTvDetail(
    OnFetchTvDetail event,
    Emitter<TvDetailState> emit,
  ) async {
    emit(state.copyWith(statusTvDetail: RequestState.Loading));
    final detailResult = await _getTvDetailUsecases.execute(event.id);
    final recommendationsResult =
        await _getTvRecommendationsUsecases.execute(event.id);
    detailResult.fold(
      (failure) {
        emit(state.copyWith(
          statusTvDetail: RequestState.Error,
          message: failure.message,
        ));
      },
      (detailResult) {
        emit(state.copyWith(
          statusTvRecommendations: RequestState.Loading,
          statusTvDetail: RequestState.Loaded,
          tvDetailEntities: detailResult,
        ));
        recommendationsResult.fold(
          (failure) {
            emit(state.copyWith(
              statusTvRecommendations: RequestState.Error,
              message: failure.message,
            ));
          },
          (recommendationsResult) {
            if (recommendationsResult.isEmpty) {
              emit(state.copyWith(statusTvRecommendations: RequestState.Empty));
            } else {
              emit(state.copyWith(
                statusTvRecommendations: RequestState.Loaded,
                tvRecommendations: recommendationsResult,
              ));
            }
          },
        );
      },
    );
  }

  void _onAddWatchlistTv(
    OnAddWatchlistTv event,
    Emitter<TvDetailState> emit,
  ) async {
    final tvDetail = event.tvDetailEntities;
    final result = await _saveWatchlistTvUsecases.execute(tvDetail);

    result.fold(
      (failure) => emit(state.copyWith(watchlistMessage: failure.message)),
      (successMessage) =>
          emit(state.copyWith(watchlistMessage: successMessage)),
    );

    add(OnLoadWatchlistStatusTv(tvDetail.id));
  }

  void _onRemoveFromWatchlistTv(
    OnRemoveFromWatchlistTv event,
    Emitter<TvDetailState> emit,
  ) async {
    final tvDetail = event.tvDetailEntities;
    final result = await _removeWatchlistTvUsecases.execute(tvDetail);

    result.fold(
      (failure) => emit(state.copyWith(watchlistMessage: failure.message)),
      (successMessage) =>
          emit(state.copyWith(watchlistMessage: successMessage)),
    );

    add(OnLoadWatchlistStatusTv(tvDetail.id));
  }

  void _onLoadWatchlistStatusTv(
    OnLoadWatchlistStatusTv event,
    Emitter<TvDetailState> emit,
  ) async {
    final status = await _getWatchlistTvStatusUsecases.execute(event.id);
    emit(state.copyWith(isAddedtoWatchlist: status));
  }
}
