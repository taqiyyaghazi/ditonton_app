import 'package:core/common/network_info.dart';
import 'package:core/utils/ssl_pinning.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:movies/movies.dart';
import 'package:tv/tv.dart';

final locator = GetIt.instance;

void init() {
  // Bloc - MOVIE
  locator.registerFactory(() => MovieListBloc(locator(), locator(), locator()));
  locator.registerFactory(() =>
      MovieDetailBloc(locator(), locator(), locator(), locator(), locator()));
  locator.registerFactory(() => MovieSearchBloc(locator()));
  locator.registerFactory(() => WatchlistMovieBloc(locator()));
  // BLOC - TV
  locator.registerFactory(() => TvListBloc(locator(), locator(), locator()));
  locator.registerFactory(() => TvSearchBloc(locator()));
  locator.registerFactory(() => WatchlistTvBloc(locator()));
  locator.registerFactory(() =>
      TvDetailBloc(locator(), locator(), locator(), locator(), locator()));

  // use case movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // use case TV
  locator.registerLazySingleton(() => GetOnAirTvUsecases(locator()));
  locator.registerLazySingleton(() => GetPopularTvUsecases(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvUsecases(locator()));
  locator.registerLazySingleton(() => GetTvDetailUsecases(locator()));
  locator.registerLazySingleton(() => GetTvRecommendationsUsecases(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvStatusUsecases(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvUsecases(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvUsecases(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvUsecases(locator()));
  locator.registerLazySingleton(() => SearchTvUsecases(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDatasources: locator(),
      localDatasources: locator(),
      networkInfo: locator(),
    ),
  );

  locator.registerLazySingleton<TvRepositories>(
    () => TvRepositoryImpl(
      tvRemoteDatasources: locator(),
      tvLocalDatasources: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDatasources>(
      () => MovieRemoteDatasourcesImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDatasources>(
      () => MovieLocalDatasourcesImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvRemoteDatasources>(
      () => TvRemoteDatasourcesImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDatasources>(
      () => TvLocalDatasourcesImpl(databaseHelper: locator()));

  // network info
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));
  locator.registerLazySingleton<DataConnectionChecker>(
      () => DataConnectionChecker());

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerLazySingleton<TvDatabaseHelper>(() => TvDatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton<SSLPinningClient>(() => SSLPinningClient());
}
