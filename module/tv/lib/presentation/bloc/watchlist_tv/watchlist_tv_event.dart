part of 'watchlist_tv_bloc.dart';

sealed class WatchlistTvEvent extends Equatable {
  const WatchlistTvEvent();

  @override
  List<Object> get props => [];
}

class OnGetWatchlistTv extends WatchlistTvEvent {}
