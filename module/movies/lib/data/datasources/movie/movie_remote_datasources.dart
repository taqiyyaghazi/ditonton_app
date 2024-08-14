import 'dart:convert';

import 'package:core/common/exception.dart';
import 'package:core/common/urls.dart';
import 'package:core/utils/ssl_pinning.dart';
import '../../models/movie_detail_model.dart';
import '../../models/movie_model.dart';
import '../../models/movie_response.dart';

abstract class MovieRemoteDatasources {
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<MovieDetailResponse> getMovieDetail(int id);
  Future<List<MovieModel>> getMovieRecommendations(int id);
  Future<List<MovieModel>> searchMovies(String query);
}

class MovieRemoteDatasourcesImpl implements MovieRemoteDatasources {
  final SSLPinningClient client;

  MovieRemoteDatasourcesImpl({required this.client});

  @override
  Future<MovieDetailResponse> getMovieDetail(int id) async {
    final response = await client
        .get(Uri.parse('${Urls.BASE_URL}/movie/$id?${Urls.API_KEY}'));

    if (response.statusCode == 200) {
      return MovieDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getMovieRecommendations(int id) async {
    final response = await client.get(Uri.parse(
        '${Urls.BASE_URL}/movie/$id/recommendations?${Urls.API_KEY}'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    final response = await client
        .get(Uri.parse('${Urls.BASE_URL}/movie/now_playing?${Urls.API_KEY}'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await client
        .get(Uri.parse('${Urls.BASE_URL}/movie/popular?${Urls.API_KEY}'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    final response = await client
        .get(Uri.parse('${Urls.BASE_URL}/movie/top_rated?${Urls.API_KEY}'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    final response = await client.get(Uri.parse(
        '${Urls.BASE_URL}/search/movie?${Urls.API_KEY}&query=$query'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }
}
