import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/tv_entities.dart';
import '../repositories/tv_repositories.dart';

class GetPopularTvUsecases {
  final TvRepositories repository;

  GetPopularTvUsecases(this.repository);

  Future<Either<Failure, List<TvEntities>>> execute() {
    return repository.getPopularTvSeries();
  }
}
