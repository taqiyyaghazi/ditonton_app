import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/tv_detail_entities.dart';
import '../entities/tv_entities.dart';

abstract class TvRepositories {
  Future<Either<Failure, List<TvEntities>>> getOnAirTvSeries();
  Future<Either<Failure, List<TvEntities>>> getPopularTvSeries();
  Future<Either<Failure, List<TvEntities>>> getTopRatedTvSeries();
  Future<Either<Failure, TvDetailEntities>> getTvSeriesDetail(int id);
  Future<Either<Failure, List<TvEntities>>> getTvSeriesRecommendations(int id);
  Future<Either<Failure, List<TvEntities>>> searchTvSeries(String query);
  Future<Either<Failure, String>> saveTvWatchlist(TvDetailEntities tvSeries);
  Future<Either<Failure, String>> removeTvWatchlist(TvDetailEntities tvSeries);
  Future<bool> isAddedToTvWatchlist(int id);
  Future<Either<Failure, List<TvEntities>>> getWatchlistTvSeries();
}
