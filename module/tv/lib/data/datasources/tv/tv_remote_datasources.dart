import 'dart:convert';
import 'package:core/common/exception.dart';
import 'package:core/common/urls.dart';
import 'package:core/utils/ssl_pinning.dart';

import '../../models/tv_detail_model.dart';
import '../../models/tv_model.dart';
import '../../models/tv_response_model.dart';

abstract class TvRemoteDatasources {
  Future<List<TvModel>> getOnAirTvSeries();
  Future<List<TvModel>> getPopularTvSeries();
  Future<List<TvModel>> getTopRatedTvSeries();
  Future<TvDetailModel> getTvDetail(int id);
  Future<List<TvModel>> getTvRecommendations(int id);
  Future<List<TvModel>> searchTvSeries(String query);
}

class TvRemoteDatasourcesImpl implements TvRemoteDatasources {
  final SSLPinningClient client;

  TvRemoteDatasourcesImpl({required this.client});

  @override
  Future<List<TvModel>> getOnAirTvSeries() async {
    final url = Uri.parse('${Urls.BASE_URL}/tv/on_the_air?${Urls.API_KEY}');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return TvResponseModel.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getPopularTvSeries() async {
    final url = Uri.parse('${Urls.BASE_URL}/tv/popular?${Urls.API_KEY}');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return TvResponseModel.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTopRatedTvSeries() async {
    final url = Uri.parse('${Urls.BASE_URL}/tv/top_rated?${Urls.API_KEY}');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return TvResponseModel.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvDetailModel> getTvDetail(int id) async {
    final url = Uri.parse('${Urls.BASE_URL}/tv/$id?${Urls.API_KEY}');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return TvDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTvRecommendations(int id) async {
    final url =
        Uri.parse('${Urls.BASE_URL}/tv/$id/recommendations?${Urls.API_KEY}');

    final response = await client.get(url);

    if (response.statusCode == 200) {
      return TvResponseModel.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> searchTvSeries(String query) async {
    final url =
        Uri.parse('${Urls.BASE_URL}/search/tv?${Urls.API_KEY}&query=$query');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return TvResponseModel.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }
}
