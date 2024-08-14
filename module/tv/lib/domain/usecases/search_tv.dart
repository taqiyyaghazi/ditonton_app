import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/tv_entities.dart';
import '../repositories/tv_repositories.dart';

class SearchTvUsecases {
  final TvRepositories repository;

  SearchTvUsecases(this.repository);

  Future<Either<Failure, List<TvEntities>>> execute(String query) {
    return repository.searchTvSeries(query);
  }
}
