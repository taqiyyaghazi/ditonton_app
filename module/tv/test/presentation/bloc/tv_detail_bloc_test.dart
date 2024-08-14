import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv_entities.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';
import 'package:tv/domain/usecases/get_watchlist_tv_status.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/save_watchlist_tv.dart';
import 'package:tv/presentation/bloc/tv_detail/tv_detail_bloc.dart';

import '../../tv_dummy_data/tv_dummy_object.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvDetailUsecases,
  GetTvRecommendationsUsecases,
  GetWatchlistTvStatusUsecases,
  SaveWatchlistTvUsecases,
  RemoveWatchlistTvUsecases,
])
void main() {
  late TvDetailBloc bloc;
  late MockGetTvDetailUsecases mockGetTvDetailUsecases;
  late MockGetTvRecommendationsUsecases mockGetTvRecommendationsUsecases;
  late MockGetWatchlistTvStatusUsecases mockGetWatchlistTvStatusUsecases;
  late MockSaveWatchlistTvUsecases mockSaveWatchlistTvUsecases;
  late MockRemoveWatchlistTvUsecases mockRemoveWatchlistTvUsecases;

  setUp(() {
    mockGetTvDetailUsecases = MockGetTvDetailUsecases();
    mockGetTvRecommendationsUsecases = MockGetTvRecommendationsUsecases();
    mockGetWatchlistTvStatusUsecases = MockGetWatchlistTvStatusUsecases();
    mockSaveWatchlistTvUsecases = MockSaveWatchlistTvUsecases();
    mockRemoveWatchlistTvUsecases = MockRemoveWatchlistTvUsecases();
    bloc = TvDetailBloc(
      mockGetTvDetailUsecases,
      mockGetTvRecommendationsUsecases,
      mockGetWatchlistTvStatusUsecases,
      mockSaveWatchlistTvUsecases,
      mockRemoveWatchlistTvUsecases,
    );
  });

  const tId = 1;
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
  final tTvSeries = <TvEntities>[tTv];

  group('Tv Detail', () {
    test('initial state should be empty', () {
      expect(
          bloc.state, const TvDetailState(statusTvDetail: RequestState.Empty));
      expect(bloc.state,
          const TvDetailState(statusTvRecommendations: RequestState.Empty));
    });
    blocTest<TvDetailBloc, TvDetailState>(
      'should emit [LoadingDetailTv, HasDataDetailTV, LoadingTVRecommendations, HasDataRecommendationsTV] when data is gotten successfully',
      build: () {
        when(mockGetTvDetailUsecases.execute(tId))
            .thenAnswer((_) async => const Right(testTvDetail));
        when(mockGetTvRecommendationsUsecases.execute(tId))
            .thenAnswer((_) async => Right(tTvSeries));
        return bloc;
      },
      act: (bloc) => bloc.add(const OnFetchTvDetail(tId)),
      expect: () => [
        const TvDetailState(statusTvDetail: RequestState.Loading),
        const TvDetailState(
          statusTvRecommendations: RequestState.Loading,
          tvDetailEntities: testTvDetail,
          statusTvDetail: RequestState.Loaded,
        ),
        TvDetailState(
          statusTvDetail: RequestState.Loaded,
          tvDetailEntities: testTvDetail,
          statusTvRecommendations: RequestState.Loaded,
          tvRecommendations: tTvSeries,
        ),
      ],
      verify: (bloc) {
        verify(mockGetTvDetailUsecases.execute(tId));
        verify(mockGetTvRecommendationsUsecases.execute(tId));
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'should emit [TV Detail Error] when detail tv unsuccesfully',
      build: () {
        when(mockGetTvDetailUsecases.execute(tId)).thenAnswer((_) async =>
            const Left(ConnectionFailure('Failed to connect to the network')));
        when(mockGetTvRecommendationsUsecases.execute(tId))
            .thenAnswer((_) async => Right(tTvSeries));
        return bloc;
      },
      act: (bloc) => bloc.add(const OnFetchTvDetail(tId)),
      expect: () => [
        const TvDetailState(statusTvDetail: RequestState.Loading),
        const TvDetailState(
            statusTvDetail: RequestState.Error,
            message: 'Failed to connect to the network')
      ],
      verify: (bloc) {
        verify(mockGetTvDetailUsecases.execute(tId));
        verify(mockGetTvRecommendationsUsecases.execute(tId));
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'should emit [LoadingDetailTV, HasDataTvDetailEntities, NoDataRecommendationTV] when data recommendations TV is empty',
      build: () {
        when(mockGetTvDetailUsecases.execute(tId))
            .thenAnswer((_) async => const Right(testTvDetail));
        when(mockGetTvRecommendationsUsecases.execute(tId))
            .thenAnswer((_) async => const Right([]));
        return bloc;
      },
      act: (bloc) => bloc.add(const OnFetchTvDetail(tId)),
      expect: () => [
        const TvDetailState(statusTvDetail: RequestState.Loading),
        const TvDetailState(
          statusTvDetail: RequestState.Loaded,
          tvDetailEntities: testTvDetail,
          statusTvRecommendations: RequestState.Loading,
        ),
        const TvDetailState(
          statusTvDetail: RequestState.Loaded,
          tvDetailEntities: testTvDetail,
          statusTvRecommendations: RequestState.Empty,
        ),
      ],
      verify: (bloc) {
        verify(mockGetTvDetailUsecases.execute(tId));
        verify(mockGetTvRecommendationsUsecases.execute(tId));
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'should emit [LoadingDetailTv, HasDataTvDetailEntities, LoadingRecommendationTv, RecommendationTVError] when get data recommendations Tv is failed',
      build: () {
        when(mockGetTvDetailUsecases.execute(tId))
            .thenAnswer((_) async => const Right(testTvDetail));
        when(mockGetTvRecommendationsUsecases.execute(tId)).thenAnswer(
            (_) async => const Left(
                ConnectionFailure('Failed to connect to the network')));
        return bloc;
      },
      act: (bloc) => bloc.add(const OnFetchTvDetail(tId)),
      expect: () => [
        const TvDetailState(statusTvDetail: RequestState.Loading),
        const TvDetailState(
          statusTvDetail: RequestState.Loaded,
          statusTvRecommendations: RequestState.Loading,
          tvDetailEntities: testTvDetail,
        ),
        const TvDetailState(
          statusTvDetail: RequestState.Loaded,
          tvDetailEntities: testTvDetail,
          statusTvRecommendations: RequestState.Error,
          message: 'Failed to connect to the network',
        ),
      ],
      verify: (bloc) {
        verify(mockGetTvDetailUsecases.execute(tId));
        verify(mockGetTvRecommendationsUsecases.execute(tId));
      },
    );
  });

  group('Get watchlist status movie', () {
    blocTest<TvDetailBloc, TvDetailState>(
      'should emit [WatchlistStatus] is true',
      build: () {
        when(mockGetWatchlistTvStatusUsecases.execute(tId))
            .thenAnswer((_) async => true);
        return bloc;
      },
      act: (bloc) => bloc.add(const OnLoadWatchlistStatusTv(tId)),
      expect: () => [
        const TvDetailState(isAddedtoWatchlist: true),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTvStatusUsecases.execute(tId));
      },
    );
    blocTest<TvDetailBloc, TvDetailState>(
      'should emit [WatchlistStatus] is false',
      build: () {
        when(mockGetWatchlistTvStatusUsecases.execute(tId))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(const OnLoadWatchlistStatusTv(tId)),
      expect: () => [
        const TvDetailState(isAddedtoWatchlist: false),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTvStatusUsecases.execute(tId));
      },
    );
  });
  group('Add Watchlist Tv', () {
    blocTest<TvDetailBloc, TvDetailState>(
      'should emit [WatchlistMessage, WatchlistStatus] when added data to watchlist is succesfully ',
      build: () {
        when(mockSaveWatchlistTvUsecases.execute(testTvDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        when(mockGetWatchlistTvStatusUsecases.execute(testTvDetail.id))
            .thenAnswer((_) async => true);
        return bloc;
      },
      act: (bloc) => bloc.add(const OnAddWatchlistTv(testTvDetail)),
      expect: () => [
        const TvDetailState(watchlistMessage: 'Added to Watchlist'),
        const TvDetailState(
            watchlistMessage: 'Added to Watchlist', isAddedtoWatchlist: true),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistTvUsecases.execute(testTvDetail));
        verify(mockGetWatchlistTvStatusUsecases.execute(testTvDetail.id));
      },
    );
    blocTest<TvDetailBloc, TvDetailState>(
      'should emit [WatchlistMessage, WatchlistStatus] when added data to watchlist is unsuccessfully ',
      build: () {
        when(mockSaveWatchlistTvUsecases.execute(testTvDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        when(mockGetWatchlistTvStatusUsecases.execute(testTvDetail.id))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(const OnAddWatchlistTv(testTvDetail)),
      expect: () => [
        const TvDetailState(
            watchlistMessage: 'Failed', isAddedtoWatchlist: false),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistTvUsecases.execute(testTvDetail));
        verify(mockGetWatchlistTvStatusUsecases.execute(testTvDetail.id));
      },
    );
  });
  group('Remove Watchlist Tv', () {
    blocTest<TvDetailBloc, TvDetailState>(
      'should emit [WatchlistMessage, WatchlistStatus] when removed data from watchlist is succesfully',
      build: () {
        when(mockRemoveWatchlistTvUsecases.execute(testTvDetail))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        when(mockGetWatchlistTvStatusUsecases.execute(testTvDetail.id))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(const OnRemoveFromWatchlistTv(testTvDetail)),
      expect: () => [
        const TvDetailState(
          watchlistMessage: 'Removed from Watchlist',
          isAddedtoWatchlist: false,
        ),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistTvUsecases.execute(testTvDetail));
        verify(mockGetWatchlistTvStatusUsecases.execute(testTvDetail.id));
      },
    );
    blocTest<TvDetailBloc, TvDetailState>(
      'should emit [WatchlistMessage] when removed data from watchlist is unsuccesfully',
      build: () {
        when(mockRemoveWatchlistTvUsecases.execute(testTvDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        when(mockGetWatchlistTvStatusUsecases.execute(testTvDetail.id))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(const OnRemoveFromWatchlistTv(testTvDetail)),
      expect: () => [
        const TvDetailState(watchlistMessage: 'Failed'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistTvUsecases.execute(testTvDetail));
        verify(mockGetWatchlistTvStatusUsecases.execute(testTvDetail.id));
      },
    );
  });
}
