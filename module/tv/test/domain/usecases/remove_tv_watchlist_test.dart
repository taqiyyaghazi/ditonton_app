import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../tv_dummy_data/tv_dummy_object.dart';

void main() {
  late RemoveWatchlistTvUsecases usecases;
  late MockTvRepositories mockTvRepositories;

  setUp(() {
    mockTvRepositories = MockTvRepositories();
    usecases = RemoveWatchlistTvUsecases(mockTvRepositories);
  });

  test('should remove watchlist tv from repository', () async {
    // arrange
    when(mockTvRepositories.removeTvWatchlist(testTvDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecases.execute(testTvDetail);
    // assert
    expect(result, const Right('Removed from watchlist'));
  });
}
