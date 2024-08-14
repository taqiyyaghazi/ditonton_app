library movies;

export 'package:movies/data/datasources/db/database_helper.dart';
export 'package:movies/data/datasources/movie/movie_local_datasources.dart';
export 'package:movies/data/datasources/movie/movie_remote_datasources.dart';
export 'package:movies/data/repositories/movie_repository_impl.dart';
export 'package:movies/domain/repositories/movie_repository.dart';
export 'package:movies/domain/usecases/get_movie_detail.dart';
export 'package:movies/domain/usecases/get_movie_recommendations.dart';
export 'package:movies/domain/usecases/get_now_playing_movies.dart';
export 'package:movies/domain/usecases/get_popular_movies.dart';
export 'package:movies/domain/usecases/get_top_rated_movies.dart';
export 'package:movies/domain/usecases/get_watchlist_movies.dart';
export 'package:movies/domain/usecases/get_watchlist_status.dart';
export 'package:movies/domain/usecases/remove_watchlist.dart';
export 'package:movies/domain/usecases/save_watchlist.dart';
export 'package:movies/domain/usecases/search_movies.dart';
export 'package:movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';
export 'package:movies/presentation/bloc/movie_list/movie_list_bloc.dart';
export 'package:movies/presentation/bloc/movie_search/movie_search_bloc.dart';
export 'package:movies/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';

export 'package:movies/presentation/pages/movie_detail_page.dart';
export 'package:movies/presentation/pages/popular_movies_page.dart';
export 'package:movies/presentation/pages/top_rated_movies_page.dart';
export 'package:movies/presentation/pages/watchlist_movies_page.dart';
export 'package:movies/presentation/widgets/custom_drawer.dart';
