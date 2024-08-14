import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv_entities.dart';
import 'package:tv/domain/usecases/search_tv.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvUsecases usecases;
  late MockTvRepositories mockTvRepositories;

  setUp(() {
    mockTvRepositories = MockTvRepositories();
    usecases = SearchTvUsecases(mockTvRepositories);
  });

  final tTv = <TvEntities>[];
  const tQuery = 'House';

  test('should get list of tv series from repository', () async {
    // arrange
    when(mockTvRepositories.searchTvSeries(tQuery))
        .thenAnswer((_) async => Right(tTv));
    // act
    final result = await usecases.execute(tQuery);
    // assert
    expect(result, Right(tTv));
  });
}
