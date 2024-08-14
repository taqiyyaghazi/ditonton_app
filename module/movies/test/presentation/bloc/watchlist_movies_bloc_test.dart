import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_watchlist_movies.dart';
import 'package:movies/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_movies_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late WatchlistMovieBloc bloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    bloc = WatchlistMovieBloc(mockGetWatchlistMovies);
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];

  group('Watchlist Movies', () {
    test('initial state should be empty', () {
      expect(bloc.state, const WatchlistMovieState(status: RequestState.Empty));
    });
    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return bloc;
      },
      act: (bloc) {
        bloc.add(OnGetWatchlistMovies());
      },
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const WatchlistMovieState(status: RequestState.Loading),
        WatchlistMovieState(result: tMovieList, status: RequestState.Loaded),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );
    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'should emit [Loading, Error] when get search is unsuccessfull',
      build: () {
        when(mockGetWatchlistMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) {
        bloc.add(OnGetWatchlistMovies());
      },
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const WatchlistMovieState(status: RequestState.Loading),
        const WatchlistMovieState(
            status: RequestState.Error, message: 'Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );
  });
}
