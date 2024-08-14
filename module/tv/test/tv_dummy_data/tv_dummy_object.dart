import 'package:tv/data/models/tv_table.dart';
import 'package:tv/domain/entities/genre.dart';
import 'package:tv/domain/entities/tv_detail_entities.dart';
import 'package:tv/domain/entities/tv_entities.dart';

final testTv = TvEntities(
  adult: false,
  backdropPath: "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
  genreIds: const [10765, 18, 10759],
  id: 94997,
  originCountry: const ["US"],
  originalLanguage: 'en',
  originalName: 'House of the Dragon',
  overview:
      "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
  popularity: 2642.374,
  posterPath: "/7QMsOTMUswlwxJP0rTTZfmz2tX2.jpg",
  firstAirDate: "2022-08-21",
  name: "House of the Dragon",
  voteAverage: 8.406,
  voteCount: 4616,
);

final testTvList = [testTv];

const testTvDetail = TvDetailEntities(
  adult: false,
  backdropPath: "/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg",
  genres: [
    Genre(id: 10765, name: "Sci-Fi & Fantasy"),
    Genre(id: 18, name: "Drama"),
    Genre(id: 10759, name: "Action & Adventure"),
  ],
  id: 94997,
  inProduction: true,
  languages: ["en"],
  lastAirDate: "2024-07-28",
  name: "House of the Dragon",
  numberOfEpisodes: 18,
  numberOfSeasons: 2,
  originCountry: ["US"],
  originalLanguage: 'en',
  originalName: "House of the Dragon",
  overview:
      "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
  popularity: 2642.374,
  posterPath: "/7QMsOTMUswlwxJP0rTTZfmz2tX2.jpg",
  tagline: "All must choose.",
  type: 'Scripted',
  voteAverage: 8.406,
  voteCount: 4616,
);

final testWatchlistTv = TvEntities.watchlist(
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  name: 'name',
);

final testWatchlistTv2 = TvEntities.watchlist(
  id: 94997,
  overview:
      "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
  posterPath: "/7QMsOTMUswlwxJP0rTTZfmz2tX2.jpg",
  name: "House of the Dragon",
);

final testTvFromCache = TvEntities.watchlist(
  id: 94997,
  overview:
      "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
  posterPath: "/7QMsOTMUswlwxJP0rTTZfmz2tX2.jpg",
  name: "House of the Dragon",
);

const testTvCache = TvTable(
  id: 94997,
  overview:
      "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
  posterPath: "/7QMsOTMUswlwxJP0rTTZfmz2tX2.jpg",
  name: "House of the Dragon",
);

final testTvCacheMap = {
  'id': 94997,
  'overview':
      "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
  'posterPath': "/7QMsOTMUswlwxJP0rTTZfmz2tX2.jpg",
  'name': "House of the Dragon",
};

const testTvTable = TvTable(
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  name: 'name',
);

const testTvTable2 = TvTable(
  id: 94997,
  overview:
      "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
  posterPath: "/7QMsOTMUswlwxJP0rTTZfmz2tX2.jpg",
  name: "House of the Dragon",
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
