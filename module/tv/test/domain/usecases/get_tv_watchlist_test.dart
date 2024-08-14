import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../tv_dummy_data/tv_dummy_object.dart';

void main() {
  late GetWatchlistTvUsecases usecases;
  late MockTvRepositories mockTvRepositories;

  setUp(() {
    mockTvRepositories = MockTvRepositories();
    usecases = GetWatchlistTvUsecases(mockTvRepositories);
  });

  test('should get watchlist tv series from the repository', () async {
    // arrang
    when(mockTvRepositories.getWatchlistTvSeries())
        .thenAnswer((_) async => Right(testTvList));
    // act
    final result = await usecases.execute();
    // assert
    expect(result, Right(testTvList));
  });
}
