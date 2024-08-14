part of 'watchlist_tv_bloc.dart';

class WatchlistTvState extends Equatable {
  final String message;
  final List<TvEntities> result;
  final RequestState status;

  const WatchlistTvState({
    this.message = '',
    this.result = const [],
    this.status = RequestState.Empty,
  });

  WatchlistTvState copyWith({
    String? message,
    List<TvEntities>? result,
    RequestState? status,
  }) {
    return WatchlistTvState(
      message: message ?? this.message,
      result: result ?? this.result,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [message, result, status];
}
