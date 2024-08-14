import 'package:core/common/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/data/datasources/tv/tv_local_datasources.dart';
import '../../helpers/test_helper.mocks.dart';
import '../../tv_dummy_data/tv_dummy_object.dart';

void main() {
  late TvLocalDatasourcesImpl datasourcesImpl;
  late MockTvDatabaseHelper mockTvDatabaseHelper;

  setUp(() {
    mockTvDatabaseHelper = MockTvDatabaseHelper();
    datasourcesImpl =
        TvLocalDatasourcesImpl(databaseHelper: mockTvDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockTvDatabaseHelper.insertWatchlist(testTvTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await datasourcesImpl.insertWatchlist(testTvTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockTvDatabaseHelper.insertWatchlist(testTvTable))
          .thenThrow(Exception());
      // act
      final call = datasourcesImpl.insertWatchlist(testTvTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove database is success',
        () async {
      // arrange
      when(mockTvDatabaseHelper.removeWatchlist(testTvTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await datasourcesImpl.removeWatchlist(testTvTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });
    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockTvDatabaseHelper.removeWatchlist(testTvTable))
          .thenThrow(Exception());
      // act
      final call = datasourcesImpl.removeWatchlist(testTvTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });
  group('Get TV detail by ID', () {
    const tId = 1;

    test('should return tv detail table when data is found', () async {
      // arrange
      when(mockTvDatabaseHelper.getTvById(tId))
          .thenAnswer((_) async => testTvMap);
      // act
      final call = await datasourcesImpl.getTvSerisById(tId);
      // assert
      expect(call, testTvTable);
    });
    test('should return null when data is not found', () async {
      // arrange
      when(mockTvDatabaseHelper.getTvById(tId)).thenAnswer((_) async => null);
      // act
      final call = await datasourcesImpl.getTvSerisById(tId);
      // assert
      expect(call, null);
    });
  });

  group('get watchlist tv', () {
    test('should return list of TvTable from database', () async {
      // arrange
      when(mockTvDatabaseHelper.getWatchlistTv())
          .thenAnswer((_) async => [testTvMap]);
      // act
      final call = await datasourcesImpl.getWatchlistTvSeries();
      // assert
      expect(call, [testTvTable]);
    });
  });
}
