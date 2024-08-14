part of 'tv_detail_bloc.dart';

sealed class TvDetailEvent extends Equatable {
  const TvDetailEvent();

  @override
  List<Object> get props => [];
}

class OnFetchTvDetail extends TvDetailEvent {
  final int id;
  const OnFetchTvDetail(this.id);

  @override
  List<Object> get props => [id];
}

class OnAddWatchlistTv extends TvDetailEvent {
  final TvDetailEntities tvDetailEntities;

  const OnAddWatchlistTv(this.tvDetailEntities);

  @override
  List<Object> get props => [tvDetailEntities];
}

class OnRemoveFromWatchlistTv extends TvDetailEvent {
  final TvDetailEntities tvDetailEntities;

  const OnRemoveFromWatchlistTv(this.tvDetailEntities);

  @override
  List<Object> get props => [tvDetailEntities];
}

class OnLoadWatchlistStatusTv extends TvDetailEvent {
  final int id;

  const OnLoadWatchlistStatusTv(this.id);

  @override
  List<Object> get props => [id];
}
