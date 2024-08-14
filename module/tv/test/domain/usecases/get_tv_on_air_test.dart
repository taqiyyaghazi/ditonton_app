import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv_entities.dart';
import 'package:tv/domain/usecases/get_on_air_tv.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetOnAirTvUsecases usecases;
  late MockTvRepositories mockTvRepositories;

  setUp(() {
    mockTvRepositories = MockTvRepositories();
    usecases = GetOnAirTvUsecases(mockTvRepositories);
  });

  final tTv = <TvEntities>[];

  test('should get tv on air for repository', () async {
    // arrange
    when(mockTvRepositories.getOnAirTvSeries())
        .thenAnswer((_) async => Right(tTv));
    // act
    final result = await usecases.execute();
    // assert
    expect(result, Right(tTv));
  });
}
