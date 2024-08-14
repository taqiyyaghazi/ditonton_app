import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movies/domain/usecases/get_popular_movies.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';
import 'package:movies/presentation/bloc/movie_list/movie_list_bloc.dart';

import 'movie_list_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies, GetPopularMovies, GetTopRatedMovies])
void main() {
  late MovieListBloc bloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    bloc = MovieListBloc(
      mockGetNowPlayingMovies,
      mockGetPopularMovies,
      mockGetTopRatedMovies,
    );
  });

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
  final tMovieList = <Movie>[tMovie];

  group('Get Now Playing movies', () {
    test('initial state should be empty', () {
      expect(bloc.state, const MovieListState(status: RequestState.Empty));
    });
    blocTest<MovieListBloc, MovieListState>(
      'should emit [Loading, HasData] when data is gotten succesfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return bloc;
      },
      act: (bloc) => bloc.add(OnGetNowPlayingMovies()),
      expect: () => [
        const MovieListState(status: RequestState.Loading),
        MovieListState(status: RequestState.Loaded, nowPlaying: tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
    blocTest<MovieListBloc, MovieListState>(
      'should emit [Loading, Error] when get search is unsuccessfull',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) {
        bloc.add(OnGetNowPlayingMovies());
      },
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const MovieListState(status: RequestState.Loading),
        const MovieListState(
            status: RequestState.Error, message: 'Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
  });
  group('Get Popular movies', () {
    test('initial state should be empty', () {
      expect(bloc.state, const MovieListState(status: RequestState.Empty));
    });
    blocTest<MovieListBloc, MovieListState>(
      'should emit [Loading, HasData] when data is gotten succesfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return bloc;
      },
      act: (bloc) => bloc.add(OnGetPopularMovies()),
      expect: () => [
        const MovieListState(status: RequestState.Loading),
        MovieListState(status: RequestState.Loaded, popular: tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );
    blocTest<MovieListBloc, MovieListState>(
      'should emit [Loading, Error] when get search is unsuccessfull',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) {
        bloc.add(OnGetPopularMovies());
      },
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const MovieListState(status: RequestState.Loading),
        const MovieListState(
            status: RequestState.Error, message: 'Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );
  });
  group('Get Top Rated movies', () {
    test('initial state should be empty', () {
      expect(bloc.state, const MovieListState(status: RequestState.Empty));
    });
    blocTest<MovieListBloc, MovieListState>(
      'should emit [Loading, HasData] when data is gotten succesfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return bloc;
      },
      act: (bloc) => bloc.add(OnGetTopRatedMovies()),
      expect: () => [
        const MovieListState(status: RequestState.Loading),
        MovieListState(status: RequestState.Loaded, topRated: tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
    blocTest<MovieListBloc, MovieListState>(
      'should emit [Loading, Error] when get search is unsuccessfull',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) {
        bloc.add(OnGetTopRatedMovies());
      },
      wait: const Duration(milliseconds: 500),
      expect: () => [
        const MovieListState(status: RequestState.Loading),
        const MovieListState(
            status: RequestState.Error, message: 'Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });
}
