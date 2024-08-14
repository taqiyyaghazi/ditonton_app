import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv_entities.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvUsecases usecases;
  late MockTvRepositories mockTvRepositories;

  setUp(() {
    mockTvRepositories = MockTvRepositories();
    usecases = GetPopularTvUsecases(mockTvRepositories);
  });

  final tTv = <TvEntities>[];

  test('should get popular tv series for repository', () async {
    // arrange
    when(mockTvRepositories.getPopularTvSeries())
        .thenAnswer((_) async => Right(tTv));
    // act
    final result = await usecases.execute();
    // assert
    expect(result, Right(tTv));
  });
}
