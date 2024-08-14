import 'package:core/common/exception.dart';

import '../../models/movie_table.dart';
import '../db/database_helper.dart';

abstract class MovieLocalDatasources {
  Future<String> insertWatchlist(MovieTable movie);
  Future<String> removeWatchlist(MovieTable movie);
  Future<MovieTable?> getMovieById(int id);
  Future<List<MovieTable>> getWatchlistMovies();
  Future<void> cacheNowPlayingMovies(List<MovieTable> movies);
  Future<List<MovieTable>> getCachedNowPlayingMovies();
}

class MovieLocalDatasourcesImpl implements MovieLocalDatasources {
  final DatabaseHelper _databaseHelper;

  MovieLocalDatasourcesImpl({required DatabaseHelper databaseHelper})
      : _databaseHelper = databaseHelper;

  @override
  Future<MovieTable?> getMovieById(int id) async {
    final result = await _databaseHelper.getMovieById(id);
    if (result != null) {
      return MovieTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<MovieTable>> getWatchlistMovies() async {
    final result = await _databaseHelper.getWatchlistMovies();
    return result.map((e) => MovieTable.fromMap(e)).toList();
  }

  @override
  Future<String> insertWatchlist(MovieTable movie) async {
    try {
      await _databaseHelper.insertWatchlist(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(MovieTable movie) async {
    try {
      await _databaseHelper.removeWatchlist(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<void> cacheNowPlayingMovies(List<MovieTable> movies) async {
    await _databaseHelper.clearCache('now playing');
    await _databaseHelper.insertCacheTransaction(movies, 'now playing');
  }

  @override
  Future<List<MovieTable>> getCachedNowPlayingMovies() async {
    final result = await _databaseHelper.getCacheMovies('now playing');
    if (result.isNotEmpty) {
      return result.map((e) => MovieTable.fromMap(e)).toList();
    } else {
      throw CacheException('Can\'t get the data :(');
    }
  }
}
