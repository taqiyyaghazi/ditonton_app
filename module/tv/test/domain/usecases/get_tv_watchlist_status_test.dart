import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_watchlist_tv_status.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTvStatusUsecases usecases;
  late MockTvRepositories mockTvRepositories;

  setUp(() {
    mockTvRepositories = MockTvRepositories();
    usecases = GetWatchlistTvStatusUsecases(mockTvRepositories);
  });

  test('should get watchlist tv status from repository', () async {
    // arrange
    when(mockTvRepositories.isAddedToTvWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecases.execute(1);
    // assert
    expect(result, true);
  });
}
