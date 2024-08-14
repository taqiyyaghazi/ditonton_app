import 'package:core/common/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/entities/tv_entities.dart';
import '../../../domain/usecases/search_tv.dart';

part 'tv_search_event.dart';
part 'tv_search_state.dart';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchTvUsecases _searchTvUsecases;
  TvSearchBloc(this._searchTvUsecases) : super(const TvSearchState()) {
    on<OnTvQueryChanged>(
      (event, emit) async {
        emit(state.copyWith(status: RequestState.Loading));
        final result = await _searchTvUsecases.execute(event.query);
        result.fold(
          (failure) {
            emit(state.copyWith(
              status: RequestState.Error,
              message: failure.message,
            ));
          },
          (data) {
            emit(state.copyWith(
              status: RequestState.Loaded,
              result: data,
            ));
          },
        );
      },
      transformer: (events, mapper) {
        return events
            .debounceTime(const Duration(milliseconds: 500))
            .flatMap(mapper);
      },
    );
  }
}
