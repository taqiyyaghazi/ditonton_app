import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movies/domain/usecases/get_watchlist_status.dart';
import 'package:movies/domain/usecases/remove_watchlist.dart';
import 'package:movies/domain/usecases/save_watchlist.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailBloc bloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    bloc = MovieDetailBloc(
      mockGetMovieDetail,
      mockGetMovieRecommendations,
      mockGetWatchListStatus,
      mockSaveWatchlist,
      mockRemoveWatchlist,
    );
  });

  const tId = 1;

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovies = <Movie>[tMovie];

  group('Movie Detail', () {
    test('initial state should be empty', () {
      expect(
          bloc.state, const MovieDetailState(statusMovie: RequestState.Empty));
      expect(bloc.state,
          const MovieDetailState(statusRecommendations: RequestState.Empty));
    });
    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit [LoadingDetailMovie, HasDataDetailMovie, LoadingMovieRecommendations, HasDataRecommendationsMovie] when data is gotten successfully',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovies));
        return bloc;
      },
      act: (bloc) => bloc.add(const OnFetchMovieDetail(id: tId)),
      expect: () => [
        const MovieDetailState(statusMovie: RequestState.Loading),
        const MovieDetailState(
          statusRecommendations: RequestState.Loading,
          movieDetail: testMovieDetail,
          statusMovie: RequestState.Loaded,
        ),
        MovieDetailState(
          statusMovie: RequestState.Loaded,
          movieDetail: testMovieDetail,
          statusRecommendations: RequestState.Loaded,
          movieRecommendations: tMovies,
        ),
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit [Movie Detail Error] when detail movie unsuccesfully',
      build: () {
        when(mockGetMovieDetail.execute(tId)).thenAnswer((_) async =>
            const Left(ConnectionFailure('Failed to connect to the network')));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovies));
        return bloc;
      },
      act: (bloc) => bloc.add(const OnFetchMovieDetail(id: tId)),
      expect: () => [
        const MovieDetailState(statusMovie: RequestState.Loading),
        const MovieDetailState(
            statusMovie: RequestState.Error,
            message: 'Failed to connect to the network')
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit [LoadingDetailMovie, HasDataMovieDetail, NoDataRecommendationMovie] when data recommendations movie is empty',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => const Right([]));
        return bloc;
      },
      act: (bloc) => bloc.add(const OnFetchMovieDetail(id: tId)),
      expect: () => [
        const MovieDetailState(statusMovie: RequestState.Loading),
        const MovieDetailState(
          statusMovie: RequestState.Loaded,
          movieDetail: testMovieDetail,
          statusRecommendations: RequestState.Loading,
        ),
        const MovieDetailState(
          statusMovie: RequestState.Loaded,
          movieDetail: testMovieDetail,
          statusRecommendations: RequestState.Empty,
        ),
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit [LoadingDetailMovie, HasDataMovieDetail, LoadingRecommendationMovie, RecommendationMovieError] when get data recommendations movie is failed',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(tId)).thenAnswer((_) async =>
            const Left(ConnectionFailure('Failed to connect to the network')));
        return bloc;
      },
      act: (bloc) => bloc.add(const OnFetchMovieDetail(id: tId)),
      expect: () => [
        const MovieDetailState(statusMovie: RequestState.Loading),
        const MovieDetailState(
          statusMovie: RequestState.Loaded,
          statusRecommendations: RequestState.Loading,
          movieDetail: testMovieDetail,
        ),
        const MovieDetailState(
          statusMovie: RequestState.Loaded,
          movieDetail: testMovieDetail,
          statusRecommendations: RequestState.Error,
          message: 'Failed to connect to the network',
        ),
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );
  });

  group('Get watchlist status movie', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit [WatchlistStatus] is true',
      build: () {
        when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
        return bloc;
      },
      act: (bloc) => bloc.add(const OnLoadWatchlistStatusMovie(tId)),
      expect: () => [
        const MovieDetailState(isAddedtoWatchlist: true),
      ],
      verify: (bloc) {
        verify(mockGetWatchListStatus.execute(tId));
      },
    );
    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit [WatchlistStatus] is false',
      build: () {
        when(mockGetWatchListStatus.execute(tId))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(const OnLoadWatchlistStatusMovie(tId)),
      expect: () => [
        const MovieDetailState(isAddedtoWatchlist: false),
      ],
      verify: (bloc) {
        verify(mockGetWatchListStatus.execute(tId));
      },
    );
  });
  group('Add Watchlist Movies', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit [WatchlistMessage, WatchlistStatus] when added data to watchlist is succesfully ',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
        return bloc;
      },
      act: (bloc) => bloc.add(const OnAddWatchlistMovie(testMovieDetail)),
      expect: () => [
        const MovieDetailState(watchlistMessage: 'Added to Watchlist'),
        const MovieDetailState(
            watchlistMessage: 'Added to Watchlist', isAddedtoWatchlist: true),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchListStatus.execute(tId));
      },
    );
    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit [WatchlistMessage, WatchlistStatus] when added data to watchlist is unsuccessfully ',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        when(mockGetWatchListStatus.execute(tId))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(const OnAddWatchlistMovie(testMovieDetail)),
      expect: () => [
        const MovieDetailState(
            watchlistMessage: 'Failed', isAddedtoWatchlist: false),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchListStatus.execute(tId));
      },
    );
  });
  group('Remove Watchlist Movies', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit [WatchlistMessage, WatchlistStatus] when removed data from watchlist is succesfully',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) =>
          bloc.add(const OnRemoveFromWatchlistMovies(testMovieDetail)),
      expect: () => [
        const MovieDetailState(
          watchlistMessage: 'Removed from Watchlist',
          isAddedtoWatchlist: false,
        ),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
      },
    );
    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit [WatchlistMessage] when removed data from watchlist is unsuccesfully',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) =>
          bloc.add(const OnRemoveFromWatchlistMovies(testMovieDetail)),
      expect: () => [
        const MovieDetailState(watchlistMessage: 'Failed'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
      },
    );
  });
}
