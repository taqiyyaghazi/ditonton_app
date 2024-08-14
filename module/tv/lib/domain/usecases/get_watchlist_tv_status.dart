import '../repositories/tv_repositories.dart';

class GetWatchlistTvStatusUsecases {
  final TvRepositories repository;

  GetWatchlistTvStatusUsecases(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToTvWatchlist(id);
  }
}
