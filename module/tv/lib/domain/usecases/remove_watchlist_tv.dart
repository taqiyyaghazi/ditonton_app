import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/tv_detail_entities.dart';
import '../repositories/tv_repositories.dart';

class RemoveWatchlistTvUsecases {
  final TvRepositories repository;

  RemoveWatchlistTvUsecases(this.repository);

  Future<Either<Failure, String>> execute(TvDetailEntities tvDetail) {
    return repository.removeTvWatchlist(tvDetail);
  }
}
