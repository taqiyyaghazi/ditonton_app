import 'package:core/common/network_info.dart';
import 'package:core/utils/ssl_pinning.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:tv/data/datasources/db/tv_database_helper.dart';
import 'package:tv/data/datasources/tv/tv_local_datasources.dart';
import 'package:tv/data/datasources/tv/tv_remote_datasources.dart';
import 'package:tv/domain/repositories/tv_repositories.dart';

@GenerateMocks([
  // TV
  TvRepositories,
  TvRemoteDatasources,
  TvLocalDatasources,
  TvDatabaseHelper,
  // Network info
  NetworkInfo,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient),
  MockSpec<SSLPinningClient>(as: #MockSSLPinningClient)
])
void main() {}
