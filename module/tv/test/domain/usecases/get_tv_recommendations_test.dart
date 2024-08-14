import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv_entities.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvRecommendationsUsecases usecases;
  late MockTvRepositories mockTvRepositories;

  setUp(() {
    mockTvRepositories = MockTvRepositories();
    usecases = GetTvRecommendationsUsecases(mockTvRepositories);
  });

  const tId = 1;
  final tTv = <TvEntities>[];

  test('should get tv recommendations from the repository', () async {
    // arrange
    when(mockTvRepositories.getTvSeriesRecommendations(tId))
        .thenAnswer((_) async => Right(tTv));
    // act
    final result = await usecases.execute(tId);
    // assert
    expect(result, Right(tTv));
  });
}
