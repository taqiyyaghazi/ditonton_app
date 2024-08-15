import 'package:flutter_test/flutter_test.dart';
import 'package:movies/data/models/movie_table.dart';
import 'package:movies/domain/entities/movie.dart';

void main() {
  const tMovieTable = MovieTable(
    id: 1,
    title: 'title',
    posterPath: 'posterPath',
    overview: 'overview',
  );

  final tMovieWatchlist = Movie.watchlist(
    id: 1,
    overview: 'overview',
    posterPath: 'posterPath',
    title: 'title',
  );

  const tMovieTableJson = {
    'id': 1,
    'title': 'title',
    'posterPath': 'posterPath',
    'overview': 'overview',
  };

  test('should be a subclass of MovieTable entity', () async {
    final result = tMovieTable.toEntity();
    expect(result, tMovieWatchlist);
  });

  test('should be a subclass of MovieTable json', () async {
    final result = tMovieTable.toJson();
    expect(result, tMovieTableJson);
  });
}