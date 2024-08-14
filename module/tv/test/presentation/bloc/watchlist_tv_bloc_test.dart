import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv_entities.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';
import 'package:tv/presentation/bloc/watchlist_tv/watchlist_tv_bloc.dart';

import 'watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvUsecases])
void main() {
  late WatchlistTvBloc bloc;
  late MockGetWatchlistTvUsecases mockGetWatchlistTvUsecases;

  setUp(() {
    mockGetWatchlistTvUsecases = MockGetWatchlistTvUsecases();
    bloc = WatchlistTvBloc(mockGetWatchlistTvUsecases);
  });

  final tTv = TvEntities(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originCountry: const ['originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvList = <TvEntities>[tTv];

  group('Watchlist Tv Series', () {
    test('initial state should be empty', () {
      expect(bloc.state, const WatchlistTvState(status: RequestState.Empty));
    });
    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistTvUsecases.execute())
            .thenAnswer((_) async => Right(tTvList));
        return bloc;
      },
      act: (bloc) {
        bloc.add(OnGetWatchlistTv());
      },
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const WatchlistTvState(status: RequestState.Loading),
        WatchlistTvState(result: tTvList, status: RequestState.Loaded),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTvUsecases.execute());
      },
    );
    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'should emit [Loading, Error] when get search is unsuccessfull',
      build: () {
        when(mockGetWatchlistTvUsecases.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) {
        bloc.add(OnGetWatchlistTv());
      },
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const WatchlistTvState(status: RequestState.Loading),
        const WatchlistTvState(
            status: RequestState.Error, message: 'Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTvUsecases.execute());
      },
    );
  });
}
