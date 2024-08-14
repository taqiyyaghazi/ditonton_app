import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/tv_entities.dart';
import '../repositories/tv_repositories.dart';

class GetTvRecommendationsUsecases {
  final TvRepositories repository;

  GetTvRecommendationsUsecases(this.repository);

  Future<Either<Failure, List<TvEntities>>> execute(id) {
    return repository.getTvSeriesRecommendations(id);
  }
}
