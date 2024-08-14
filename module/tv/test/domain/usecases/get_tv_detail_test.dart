import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../tv_dummy_data/tv_dummy_object.dart';

void main() {
  late GetTvDetailUsecases usecases;
  late MockTvRepositories mockTvRepositories;

  setUp(() {
    mockTvRepositories = MockTvRepositories();
    usecases = GetTvDetailUsecases(mockTvRepositories);
  });

  const tId = 1;

  test('should get tv detail from the repository', () async {
    // arrange
    when(mockTvRepositories.getTvSeriesDetail(tId))
        .thenAnswer((_) async => const Right(testTvDetail));
    // act
    final result = await usecases.execute(tId);
    // assert
    expect(result, const Right(testTvDetail));
  });
}
