import 'dart:io';

import 'package:core/common/exception.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/tv_detail_entities.dart';
import '../../domain/entities/tv_entities.dart';
import '../../domain/repositories/tv_repositories.dart';
import '../datasources/tv/tv_local_datasources.dart';
import '../datasources/tv/tv_remote_datasources.dart';
import '../models/tv_table.dart';

class TvRepositoryImpl implements TvRepositories {
  final TvRemoteDatasources _tvRemoteDatasources;
  final TvLocalDatasources _tvLocalDatasources;

  TvRepositoryImpl({
    required TvRemoteDatasources tvRemoteDatasources,
    required TvLocalDatasources tvLocalDatasources,
  })  : _tvRemoteDatasources = tvRemoteDatasources,
        _tvLocalDatasources = tvLocalDatasources;

  @override
  Future<Either<Failure, List<TvEntities>>> getOnAirTvSeries() async {
    try {
      final result = await _tvRemoteDatasources.getOnAirTvSeries();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException catch (_) {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvEntities>>> getPopularTvSeries() async {
    try {
      final result = await _tvRemoteDatasources.getPopularTvSeries();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException catch (_) {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvEntities>>> getTopRatedTvSeries() async {
    try {
      final result = await _tvRemoteDatasources.getTopRatedTvSeries();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException catch (_) {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TvDetailEntities>> getTvSeriesDetail(int id) async {
    try {
      final result = await _tvRemoteDatasources.getTvDetail(id);
      return Right(result.toEntity());
    } on ServerException catch (_) {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvEntities>>> getTvSeriesRecommendations(
      int id) async {
    try {
      final result = await _tvRemoteDatasources.getTvRecommendations(id);
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException catch (_) {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvEntities>>> getWatchlistTvSeries() async {
    final result = await _tvLocalDatasources.getWatchlistTvSeries();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<bool> isAddedToTvWatchlist(int id) async {
    final result = await _tvLocalDatasources.getTvSerisById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeTvWatchlist(
      TvDetailEntities tvSeries) async {
    try {
      final result = await _tvLocalDatasources
          .removeWatchlist(TvTable.fromEntity(tvSeries));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveTvWatchlist(
      TvDetailEntities tvSeries) async {
    try {
      final result = await _tvLocalDatasources
          .insertWatchlist(TvTable.fromEntity(tvSeries));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<Either<Failure, List<TvEntities>>> searchTvSeries(String query) async {
    try {
      final result = await _tvRemoteDatasources.searchTvSeries(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
