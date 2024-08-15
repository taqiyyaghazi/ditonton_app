import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/genre_model.dart';
import 'package:tv/data/models/tv_detail_model.dart';
import 'package:tv/domain/entities/genre.dart';
import 'package:tv/domain/entities/tv_detail_entities.dart';

void main() {
  const tTvDetailModel = TvDetailModel(
    backdropPath: 'backdropPath',
    genres: [
      GenreModel(
        id: 1,
        name: 'name',
      ),
    ],
    id: 1,
    inProduction: true,
    languages: ['en'],
    lastAirDate: 'lastAirDate',
    name: 'name',
    numberOfEpisodes: 12,
    numberOfSeasons: 5,
    originCountry: ['en'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 2.3,
    posterPath: 'posterPath',
    tagline: 'tagline',
    type: 'type',
    voteAverage: 2.3,
    voteCount: 1500,
    adult: null,
  );

  const tTvDetailEntities = TvDetailEntities(
    backdropPath: 'backdropPath',
    genres: [
      Genre(
        id: 1,
        name: 'name',
      ),
    ],
    id: 1,
    inProduction: true,
    languages: ['en'],
    lastAirDate: 'lastAirDate',
    name: 'name',
    numberOfEpisodes: 12,
    numberOfSeasons: 5,
    originCountry: ['en'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 2.3,
    posterPath: 'posterPath',
    tagline: 'tagline',
    type: 'type',
    voteAverage: 2.3,
    voteCount: 1500,
    adult: null,
  );

  const tTvSeriesDetailJson = {
    'adult': null,
    'backdrop_path': 'backdropPath',
    'genres': [
      {
        'id': 1,
        'name': 'name',
      },
    ],
    'id': 1,
    'in_production': true,
    'languages': ['en'],
    'last_air_date': 'lastAirDate',
    'name': 'name',
    'number_of_episodes': 12,
    'number_of_seasons': 5,
    'origin_country': ['en'],
    'original_language': 'originalLanguage',
    'original_name': 'originalName',
    'overview': 'overview',
    'popularity': 2.3,
    'poster_path': 'posterPath',
    'tagline': 'tagline',
    'type': 'type',
    'vote_average': 2.3,
    'vote_count': 1500,
  };

  test('should be a subclass of TV Series Detail entity', () {
    final result = tTvDetailModel.toEntity();
    expect(result, tTvDetailEntities);
  });

  test('should be a subclass of TV Series Detail json', () {
    final result = tTvDetailModel.toJson();
    expect(result, tTvSeriesDetailJson);
  });
}
