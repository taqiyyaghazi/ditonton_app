import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/tv_entities.dart';
import '../repositories/tv_repositories.dart';

class GetWatchlistTvUsecases {
  final TvRepositories _repository;

  GetWatchlistTvUsecases(this._repository);

  Future<Either<Failure, List<TvEntities>>> execute() {
    return _repository.getWatchlistTvSeries();
  }
}
