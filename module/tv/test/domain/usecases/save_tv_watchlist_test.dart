import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/save_watchlist_tv.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../tv_dummy_data/tv_dummy_object.dart';

void main() {
  late SaveWatchlistTvUsecases usecases;
  late MockTvRepositories mockTvRepositories;

  setUp(() {
    mockTvRepositories = MockTvRepositories();
    usecases = SaveWatchlistTvUsecases(mockTvRepositories);
  });

  test('should save tv to the repository', () async {
    // arrange
    when(mockTvRepositories.saveTvWatchlist(testTvDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecases.execute(testTvDetail);
    // assert
    expect(result, const Right('Added to Watchlist'));
  });
}
