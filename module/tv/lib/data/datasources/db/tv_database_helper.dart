import 'package:sqflite/sqflite.dart';

import '../../models/tv_table.dart';

class TvDatabaseHelper {
  static TvDatabaseHelper? _tvDatabaseHelper;
  TvDatabaseHelper._instance() {
    _tvDatabaseHelper = this;
  }

  static const String _tblWatchlistTv = 'watchlist_tv';

  factory TvDatabaseHelper() =>
      _tvDatabaseHelper ?? TvDatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton_tv.db';

    var db = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
            CREATE TABLE $_tblWatchlistTv (
              id INTEGER PRIMARY KEY,
              name TEXT,
              overview TEXT,
              posterPath TEXT
            )
          ''');
      },
    );

    return db;
  }

  Future<int> insertWatchlist(TvTable tv) async {
    final db = await database;
    return await db!.insert(_tblWatchlistTv, tv.toJson());
  }

  Future<int> removeWatchlist(TvTable tv) async {
    final db = await database;

    return await db!.delete(
      _tblWatchlistTv,
      where: 'id = ?',
      whereArgs: [tv.id],
    );
  }

  Future<Map<String, dynamic>?> getTvById(int id) async {
    final db = await database;
    final result = await db!.query(
      _tblWatchlistTv,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTv() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db!.query(_tblWatchlistTv);

    return result;
  }
}
