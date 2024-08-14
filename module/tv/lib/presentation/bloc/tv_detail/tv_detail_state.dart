part of 'tv_detail_bloc.dart';

class TvDetailState extends Equatable {
  final String message;
  final List<TvEntities> tvRecommendations;
  final TvDetailEntities? tvDetailEntities;
  final RequestState statusTvRecommendations;
  final RequestState statusTvDetail;
  final String watchlistMessage;
  final bool isAddedtoWatchlist;

  const TvDetailState({
    this.message = '',
    this.tvRecommendations = const [],
    this.tvDetailEntities,
    this.statusTvRecommendations = RequestState.Empty,
    this.statusTvDetail = RequestState.Empty,
    this.watchlistMessage = '',
    this.isAddedtoWatchlist = false,
  });

  TvDetailState copyWith({
    String? message,
    List<TvEntities>? tvRecommendations,
    TvDetailEntities? tvDetailEntities,
    RequestState? statusTvRecommendations,
    RequestState? statusTvDetail,
    String? watchlistMessage,
    bool? isAddedtoWatchlist,
  }) {
    return TvDetailState(
      message: message ?? this.message,
      tvRecommendations: tvRecommendations ?? this.tvRecommendations,
      tvDetailEntities: tvDetailEntities ?? this.tvDetailEntities,
      statusTvRecommendations:
          statusTvRecommendations ?? this.statusTvRecommendations,
      statusTvDetail: statusTvDetail ?? this.statusTvDetail,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedtoWatchlist: isAddedtoWatchlist ?? this.isAddedtoWatchlist,
    );
  }

  @override
  List<Object?> get props {
    return [
      message,
      tvRecommendations,
      tvDetailEntities,
      statusTvRecommendations,
      statusTvDetail,
      watchlistMessage,
      isAddedtoWatchlist,
    ];
  }
}
