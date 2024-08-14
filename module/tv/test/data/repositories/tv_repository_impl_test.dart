import 'dart:io';

import 'package:core/common/exception.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/data/models/genre_model.dart';
import 'package:tv/data/models/tv_detail_model.dart';
import 'package:tv/data/models/tv_model.dart';
import 'package:tv/data/repositories/tv_repository_impl.dart';
import 'package:tv/domain/entities/tv_entities.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../tv_dummy_data/tv_dummy_object.dart';

void main() {
  late TvRepositoryImpl repository;
  late MockTvRemoteDatasources mockTvRemoteDatasources;
  late MockTvLocalDatasources mockTvLocalDatasources;

  setUp(() {
    mockTvRemoteDatasources = MockTvRemoteDatasources();
    mockTvLocalDatasources = MockTvLocalDatasources();
    repository = TvRepositoryImpl(
      tvRemoteDatasources: mockTvRemoteDatasources,
      tvLocalDatasources: mockTvLocalDatasources,
    );
  });

  const tTvModel = TvModel(
    adult: false,
    backdropPath: "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
    genreIds: [10765, 18, 10759],
    id: 94997,
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: "House of the Dragon",
    overview:
        "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
    popularity: 3351.882,
    posterPath: "/7QMsOTMUswlwxJP0rTTZfmz2tX2.jpg",
    firstAirDate: "2022-08-21",
    name: "House of the Dragon",
    voteAverage: 8.406,
    voteCount: 4621,
  );

  final tTv = TvEntities(
    adult: false,
    backdropPath: "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
    genreIds: const [10765, 18, 10759],
    id: 94997,
    originCountry: const ['US'],
    originalLanguage: 'en',
    originalName: "House of the Dragon",
    overview:
        "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
    popularity: 3351.882,
    posterPath: "/7QMsOTMUswlwxJP0rTTZfmz2tX2.jpg",
    firstAirDate: "2022-08-21",
    name: "House of the Dragon",
    voteAverage: 8.406,
    voteCount: 4621,
  );

  final tTvModelList = <TvModel>[tTvModel];
  final tTvList = <TvEntities>[tTv];
  group('On The air TV Series', () {
    test('should return Tv list when call to data source is success', () async {
      // arrange
      when(mockTvRemoteDatasources.getOnAirTvSeries())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getOnAirTvSeries();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDatasources.getOnAirTvSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getOnAirTvSeries();
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockTvRemoteDatasources.getOnAirTvSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getOnAirTvSeries();
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });
  group('Popular Tv Series', () {
    test('should return tv list when call to data source is success', () async {
      // arrange
      when(mockTvRemoteDatasources.getPopularTvSeries())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getPopularTvSeries();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDatasources.getPopularTvSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopularTvSeries();
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockTvRemoteDatasources.getPopularTvSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTvSeries();
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated TV', () {
    test('should return TV list when call to data source is successful',
        () async {
      // arrange
      when(mockTvRemoteDatasources.getTopRatedTvSeries())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getTopRatedTvSeries();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDatasources.getTopRatedTvSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTvSeries();
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockTvRemoteDatasources.getTopRatedTvSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTvSeries();
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });
  group('Get Tv Detail', () {
    const tId = 1;
    const tTvDetail = TvDetailModel(
      adult: false,
      backdropPath: '/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg',
      genres: [
        GenreModel(id: 10765, name: "Sci-Fi & Fantasy"),
        GenreModel(id: 18, name: "Drama"),
        GenreModel(id: 10759, name: "Action & Adventure"),
      ],
      id: 94997,
      inProduction: true,
      languages: ['en'],
      lastAirDate: "2024-07-28",
      name: "House of the Dragon",
      numberOfEpisodes: 18,
      numberOfSeasons: 2,
      originCountry: ['US'],
      originalLanguage: 'en',
      originalName: "House of the Dragon",
      overview:
          "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
      popularity: 2642.374,
      posterPath: "/7QMsOTMUswlwxJP0rTTZfmz2tX2.jpg",
      tagline: "All must choose.",
      type: 'Scripted',
      voteAverage: 8.406,
      voteCount: 4616,
    );

    test(
        'should return TV data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTvRemoteDatasources.getTvDetail(tId))
          .thenAnswer((_) async => tTvDetail);
      // act
      final result = await repository.getTvSeriesDetail(tId);
      // assert
      verify(mockTvRemoteDatasources.getTvDetail(tId));
      expect(result, equals(const Right(testTvDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDatasources.getTvDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvSeriesDetail(tId);
      // assert
      verify(mockTvRemoteDatasources.getTvDetail(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTvRemoteDatasources.getTvDetail(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvSeriesDetail(tId);
      // assert
      verify(mockTvRemoteDatasources.getTvDetail(tId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get TV Recommendations', () {
    final tTvList = <TvModel>[];
    const tId = 1;

    test('should return data (TV list) when the call is successful', () async {
      // arrange
      when(mockTvRemoteDatasources.getTvRecommendations(tId))
          .thenAnswer((_) async => tTvList);
      // act
      final result = await repository.getTvSeriesRecommendations(tId);
      // assert
      verify(mockTvRemoteDatasources.getTvRecommendations(tId));
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDatasources.getTvRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvSeriesRecommendations(tId);
      // assertbuild runner
      verify(mockTvRemoteDatasources.getTvRecommendations(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockTvRemoteDatasources.getTvRecommendations(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvSeriesRecommendations(tId);
      // assert
      verify(mockTvRemoteDatasources.getTvRecommendations(tId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Seach Tv Series', () {
    const tQuery = 'House';

    test('should return tv list when call to data source is successful',
        () async {
      // arrange
      when(mockTvRemoteDatasources.searchTvSeries(tQuery))
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDatasources.searchTvSeries(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockTvRemoteDatasources.searchTvSeries(tQuery))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockTvLocalDatasources.insertWatchlist(testTvTable2))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveTvWatchlist(testTvDetail);
      // assert
      expect(result, const Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockTvLocalDatasources.insertWatchlist(testTvTable2))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveTvWatchlist(testTvDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockTvLocalDatasources.removeWatchlist(testTvTable2))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeTvWatchlist(testTvDetail);
      // assert
      expect(result, const Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockTvLocalDatasources.removeWatchlist(testTvTable2))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeTvWatchlist(testTvDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      const tId = 1;
      when(mockTvLocalDatasources.getTvSerisById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToTvWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist Tv', () {
    test('should return list of Tv', () async {
      // arrange
      when(mockTvLocalDatasources.getWatchlistTvSeries())
          .thenAnswer((_) async => [testTvTable2]);
      // act
      final result = await repository.getWatchlistTvSeries();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTv2]);
    });
  });
}
