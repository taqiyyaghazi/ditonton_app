import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv_model.dart';
import 'package:tv/data/models/tv_response_model.dart';

import '../../json_reader_tv.dart';

void main() {
  const tTvModel = TvModel(
    adult: false,
    backdropPath: "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
    genreIds: [10765, 18, 10759],
    id: 94997,
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: "House of the Dragon",
    overview:
        "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
    popularity: 3351.882,
    posterPath: "/7QMsOTMUswlwxJP0rTTZfmz2tX2.jpg",
    firstAirDate: "2022-08-21",
    name: "House of the Dragon",
    voteAverage: 8.406,
    voteCount: 4621,
  );

  const tTvResponseModel = TvResponseModel(tvList: <TvModel>[tTvModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJsonTv('tv_dummy_data/on_air.json'));
      // act
      final result = TvResponseModel.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });
  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "adult": false,
            "backdrop_path": "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
            "genre_ids": [10765, 18, 10759],
            "id": 94997,
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "House of the Dragon",
            "overview":
                "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
            "popularity": 3351.882,
            "poster_path": "/7QMsOTMUswlwxJP0rTTZfmz2tX2.jpg",
            "first_air_date": "2022-08-21",
            "name": "House of the Dragon",
            "vote_average": 8.406,
            "vote_count": 4621
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
