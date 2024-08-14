import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv_entities.dart';
import 'package:tv/domain/usecases/get_on_air_tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';
import 'package:tv/presentation/bloc/tv_list/tv_list_bloc.dart';

import 'tv_list_bloc_test.mocks.dart';

@GenerateMocks([
  GetOnAirTvUsecases,
  GetPopularTvUsecases,
  GetTopRatedTvUsecases,
])
void main() {
  late TvListBloc bloc;
  late MockGetOnAirTvUsecases mockGetOnAirTvUsecases;
  late MockGetPopularTvUsecases mockGetPopularTvUsecases;
  late MockGetTopRatedTvUsecases mockGetTopRatedTvUsecases;

  setUp(() {
    mockGetOnAirTvUsecases = MockGetOnAirTvUsecases();
    mockGetPopularTvUsecases = MockGetPopularTvUsecases();
    mockGetTopRatedTvUsecases = MockGetTopRatedTvUsecases();
    bloc = TvListBloc(
      mockGetOnAirTvUsecases,
      mockGetPopularTvUsecases,
      mockGetTopRatedTvUsecases,
    );
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

  group('Get On The Air Tv Series', () {
    test('initial state should be empty', () {
      expect(bloc.state, const TvListState(status: RequestState.Empty));
    });
    blocTest<TvListBloc, TvListState>(
      'should emit [Loading, HasData] when data is gotten succesfully',
      build: () {
        when(mockGetOnAirTvUsecases.execute())
            .thenAnswer((_) async => Right(tTvList));
        return bloc;
      },
      act: (bloc) => bloc.add(OnGetOnTheAirTvSeries()),
      expect: () => [
        const TvListState(status: RequestState.Loading),
        TvListState(status: RequestState.Loaded, onTheAirTv: tTvList),
      ],
      verify: (bloc) {
        verify(mockGetOnAirTvUsecases.execute());
      },
    );
    blocTest<TvListBloc, TvListState>(
      'should emit [Loading, Error] when get search is unsuccessfull',
      build: () {
        when(mockGetOnAirTvUsecases.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) {
        bloc.add(OnGetOnTheAirTvSeries());
      },
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const TvListState(status: RequestState.Loading),
        const TvListState(
            status: RequestState.Error, message: 'Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetOnAirTvUsecases.execute());
      },
    );
  });
  group('Get Popular Tv Series', () {
    test('initial state should be empty', () {
      expect(bloc.state, const TvListState(status: RequestState.Empty));
    });
    blocTest<TvListBloc, TvListState>(
      'should emit [Loading, HasData] when data is gotten succesfully',
      build: () {
        when(mockGetPopularTvUsecases.execute())
            .thenAnswer((_) async => Right(tTvList));
        return bloc;
      },
      act: (bloc) => bloc.add(OnGetPopularTvSeries()),
      expect: () => [
        const TvListState(status: RequestState.Loading),
        TvListState(status: RequestState.Loaded, popularTv: tTvList),
      ],
      verify: (bloc) {
        verify(mockGetPopularTvUsecases.execute());
      },
    );
    blocTest<TvListBloc, TvListState>(
      'should emit [Loading, Error] when get search is unsuccessfull',
      build: () {
        when(mockGetPopularTvUsecases.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) {
        bloc.add(OnGetPopularTvSeries());
      },
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const TvListState(status: RequestState.Loading),
        const TvListState(
            status: RequestState.Error, message: 'Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetPopularTvUsecases.execute());
      },
    );
  });
  group('Get Top Rated Tv Series', () {
    test('initial state should be empty', () {
      expect(bloc.state, const TvListState(status: RequestState.Empty));
    });
    blocTest<TvListBloc, TvListState>(
      'should emit [Loading, HasData] when data is gotten succesfully',
      build: () {
        when(mockGetTopRatedTvUsecases.execute())
            .thenAnswer((_) async => Right(tTvList));
        return bloc;
      },
      act: (bloc) => bloc.add(OnGetTopRatedTvSeries()),
      expect: () => [
        const TvListState(status: RequestState.Loading),
        TvListState(status: RequestState.Loaded, topRatedTv: tTvList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTvUsecases.execute());
      },
    );
    blocTest<TvListBloc, TvListState>(
      'should emit [Loading, Error] when get search is unsuccessfull',
      build: () {
        when(mockGetTopRatedTvUsecases.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) {
        bloc.add(OnGetTopRatedTvSeries());
      },
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const TvListState(status: RequestState.Loading),
        const TvListState(
            status: RequestState.Error, message: 'Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTvUsecases.execute());
      },
    );
  });
}
