import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv_entities.dart';
import 'package:tv/domain/usecases/search_tv.dart';
import 'package:tv/presentation/bloc/tv_search/tv_search_bloc.dart';

import 'tv_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTvUsecases])
void main() {
  late TvSearchBloc tvSearchBloc;
  late MockSearchTvUsecases mockSearchTvUsecases;

  setUp(() {
    mockSearchTvUsecases = MockSearchTvUsecases();
    tvSearchBloc = TvSearchBloc(mockSearchTvUsecases);
  });

  final tTvModel = TvEntities(
    adult: false,
    backdropPath: "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
    genreIds: const [10765, 18, 10759],
    id: 94997,
    originCountry: const ['US'],
    originalLanguage: "en",
    originalName: "House of the Dragon",
    overview:
        "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
    popularity: 2642.374,
    posterPath: "/7QMsOTMUswlwxJP0rTTZfmz2tX2.jpg",
    firstAirDate: "2022-08-21",
    name: "House of the Dragon",
    voteAverage: 8.406,
    voteCount: 4616,
  );

  final tTvList = <TvEntities>[tTvModel];
  const tQuery = 'House';

  group('Tv Search', () {
    test('initial state should be empty', () {
      expect(
          tvSearchBloc.state, const TvSearchState(status: RequestState.Empty));
    });
    blocTest<TvSearchBloc, TvSearchState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSearchTvUsecases.execute(tQuery))
            .thenAnswer((_) async => Right(tTvList));
        return tvSearchBloc;
      },
      act: (bloc) {
        bloc.add(const OnTvQueryChanged(query: tQuery));
      },
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const TvSearchState(status: RequestState.Loading),
        TvSearchState(result: tTvList, status: RequestState.Loaded),
      ],
      verify: (bloc) {
        verify(mockSearchTvUsecases.execute(tQuery));
      },
    );
    blocTest<TvSearchBloc, TvSearchState>(
      'should emit [Loading, Error] when get search is unsuccessfull',
      build: () {
        when(mockSearchTvUsecases.execute(tQuery)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return tvSearchBloc;
      },
      act: (bloc) {
        bloc.add(const OnTvQueryChanged(query: tQuery));
      },
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const TvSearchState(status: RequestState.Loading),
        const TvSearchState(
            status: RequestState.Error, message: 'Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchTvUsecases.execute(tQuery));
      },
    );
  });
}
