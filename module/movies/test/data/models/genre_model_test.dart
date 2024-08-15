import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/genre_model.dart';
import 'package:tv/domain/entities/genre.dart';

void main() {
  const tGenreModel = GenreModel(
    id: 1,
    name: 'name',
  );

  const tGenre = Genre(
    id: 1,
    name: 'name',
  );

  const tGenreJson = {
    'id': 1,
    'name': 'name',
  };

  test('should be a subclass of Genre entity', () {
    final result = tGenreModel.toEntity();
    expect(result, tGenre);
  });

  test('should be a subclass of Genre json', () {
    final result = tGenreModel.toJson();
    expect(result, tGenreJson);
  });
}
