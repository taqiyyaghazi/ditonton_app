part of 'tv_search_bloc.dart';

class TvSearchState extends Equatable {
  final String message;
  final List<TvEntities> result;
  final RequestState status;

  const TvSearchState({
    this.message = '',
    this.result = const [],
    this.status = RequestState.Empty,
  });

  @override
  List<Object> get props => [message, result, status];

  TvSearchState copyWith({
    String? message,
    List<TvEntities>? result,
    RequestState? status,
  }) {
    return TvSearchState(
      message: message ?? this.message,
      result: result ?? this.result,
      status: status ?? this.status,
    );
  }
}
