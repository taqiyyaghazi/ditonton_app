import 'package:core/common/network_info.dart';
import 'package:core/utils/ssl_pinning.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:movies/data/datasources/db/database_helper.dart';
import 'package:movies/data/datasources/movie/movie_local_datasources.dart';
import 'package:movies/data/datasources/movie/movie_remote_datasources.dart';
import 'package:movies/domain/repositories/movie_repository.dart';

@GenerateMocks([
  // MOVIE
  MovieRepository,
  MovieRemoteDatasources,
  MovieLocalDatasources,
  DatabaseHelper,
  // Network info
  NetworkInfo,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient),
  MockSpec<SSLPinningClient>(as: #MockSSLPlinningClient)
])
void main() {}
