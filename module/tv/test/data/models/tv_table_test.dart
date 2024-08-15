import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv_table.dart';
import 'package:tv/domain/entities/tv_entities.dart';

void main() {
  const tTvTable = TvTable(
    id: 1,
    name: 'name',
    posterPath: 'posterPath',
    overview: 'overview',
  );

  final tTvEntitiesWatchlist = TvEntities.watchlist(
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
  );

  const tTvJson = {
    'id': 1,
    'name': 'name',
    'posterPath': 'posterPath',
    'overview': 'overview',
  };

  test('should be a subclass of tTvTable entity', () async {
    final result = tTvTable.toEntity();
    expect(result, tTvEntitiesWatchlist);
  });

  test('should be a subclass of TvSeriesTable json', () async {
    final result = tTvTable.toJson();
    expect(result, tTvJson);
  });
}
