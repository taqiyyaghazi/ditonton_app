import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/repositories/tv_repositories.dart';
import '../entities/tv_detail_entities.dart';

class SaveWatchlistTvUsecases {
  final TvRepositories repository;

  SaveWatchlistTvUsecases(this.repository);

  Future<Either<Failure, String>> execute(TvDetailEntities tvDetail) {
    return repository.saveTvWatchlist(tvDetail);
  }
}
