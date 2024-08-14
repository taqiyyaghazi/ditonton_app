part of 'tv_list_bloc.dart';

class TvListState extends Equatable {
  final String message;
  final RequestState status;
  final List<TvEntities> onTheAirTv;
  final List<TvEntities> popularTv;
  final List<TvEntities> topRatedTv;

  const TvListState({
    this.message = '',
    this.status = RequestState.Empty,
    this.onTheAirTv = const [],
    this.popularTv = const [],
    this.topRatedTv = const [],
  });

  TvListState copyWith({
    String? message,
    RequestState? status,
    List<TvEntities>? onTheAirTv,
    List<TvEntities>? popularTv,
    List<TvEntities>? topRatedTv,
  }) {
    return TvListState(
      message: message ?? this.message,
      status: status ?? this.status,
      onTheAirTv: onTheAirTv ?? this.onTheAirTv,
      popularTv: popularTv ?? this.popularTv,
      topRatedTv: topRatedTv ?? this.topRatedTv,
    );
  }

  @override
  List<Object> get props {
    return [
      message,
      status,
      onTheAirTv,
      popularTv,
      topRatedTv,
    ];
  }
}
