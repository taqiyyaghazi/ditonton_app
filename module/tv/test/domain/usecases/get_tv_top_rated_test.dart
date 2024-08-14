import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv_entities.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTvUsecases usecases;
  late MockTvRepositories mockTvRepositories;

  setUp(() {
    mockTvRepositories = MockTvRepositories();
    usecases = GetTopRatedTvUsecases(mockTvRepositories);
  });

  final tTv = <TvEntities>[];

  test('should get list top rated tv series from repository', () async {
    // arrange
    when(mockTvRepositories.getTopRatedTvSeries())
        .thenAnswer((_) async => Right(tTv));
    // act
    final result = await usecases.execute();
    // assert
    expect(result, Right(tTv));
  });
}
