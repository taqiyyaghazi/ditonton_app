import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/tv_detail_entities.dart';
import '../repositories/tv_repositories.dart';

class GetTvDetailUsecases {
  final TvRepositories repository;

  GetTvDetailUsecases(this.repository);

  Future<Either<Failure, TvDetailEntities>> execute(int id) {
    return repository.getTvSeriesDetail(id);
  }
}
