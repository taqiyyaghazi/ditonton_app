import 'package:core/common/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv_entities.dart';
import '../../../domain/usecases/get_watchlist_tv.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchlistTvUsecases _getWatchlistTvUsecases;
  WatchlistTvBloc(
    this._getWatchlistTvUsecases,
  ) : super(const WatchlistTvState()) {
    on<OnGetWatchlistTv>((event, emit) async {
      emit(state.copyWith(status: RequestState.Loading));
      final result = await _getWatchlistTvUsecases.execute();
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
