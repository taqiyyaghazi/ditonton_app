import 'package:core/common/exception.dart';

import '../../models/tv_table.dart';
import '../db/tv_database_helper.dart';

abstract class TvLocalDatasources {
  Future<String> insertWatchlist(TvTable tv);
  Future<String> removeWatchlist(TvTable tv);
  Future<TvTable?> getTvSerisById(int id);
  Future<List<TvTable>> getWatchlistTvSeries();
}

class TvLocalDatasourcesImpl implements TvLocalDatasources {
  final TvDatabaseHelper _databaseHelper;

  TvLocalDatasourcesImpl({required TvDatabaseHelper databaseHelper})
      : _databaseHelper = databaseHelper;

  @override
  Future<TvTable?> getTvSerisById(int id) async {
    final result = await _databaseHelper.getTvById(id);
    if (result != null) {
      return TvTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvTable>> getWatchlistTvSeries() async {
    final result = await _databaseHelper.getWatchlistTv();
    return result.map((e) => TvTable.fromMap(e)).toList();
  }

  @override
  Future<String> insertWatchlist(TvTable tv) async {
    try {
      await _databaseHelper.insertWatchlist(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TvTable tv) async {
    try {
      await _databaseHelper.removeWatchlist(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
