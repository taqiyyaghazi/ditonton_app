import 'dart:convert';
import 'package:core/common/exception.dart';
import 'package:core/common/urls.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tv/data/datasources/tv/tv_remote_datasources.dart';
import 'package:tv/data/models/tv_detail_model.dart';
import 'package:tv/data/models/tv_response_model.dart';
import '../../helpers/test_helper.mocks.dart';
import '../../json_reader_tv.dart';

void main() {
  late TvRemoteDatasourcesImpl datasourcesImpl;
  late MockSSLPinningClient mockSSLPinningClient;

  setUp(() {
    mockSSLPinningClient = MockSSLPinningClient();
    datasourcesImpl = TvRemoteDatasourcesImpl(client: mockSSLPinningClient);
  });

  group('get On The Air Tv Series', () {
    final tTvList = TvResponseModel.fromJson(
            json.decode(readJsonTv('tv_dummy_data/on_air.json')))
        .tvList;
    test('should return list of tv model when the response code is 200',
        () async {
      // arrange
      when(mockSSLPinningClient
              .get(Uri.parse('${Urls.BASE_URL}/tv/on_the_air?${Urls.API_KEY}')))
          .thenAnswer((_) async =>
              http.Response(readJsonTv('tv_dummy_data/on_air.json'), 200));
      // act
      final result = await datasourcesImpl.getOnAirTvSeries();
      // assert
      expect(result, equals(tTvList));
    });
    test(
        'should throw a server exception when the response code is 404 or other ',
        () async {
      // arrange
      when(mockSSLPinningClient
              .get(Uri.parse('${Urls.BASE_URL}/tv/on_the_air?${Urls.API_KEY}')))
          .thenAnswer((_) async => http.Response('Not Found', 400));
      // act
      final result = datasourcesImpl.getOnAirTvSeries();
      // assert
      expect(() => result, throwsA(isA<ServerException>()));
    });
  });
  group('get popular tv series', () {
    final tTvList = TvResponseModel.fromJson(
            json.decode(readJsonTv('tv_dummy_data/popular_tv.json')))
        .tvList;
    test('should return list of Tv series when response is success', () async {
      // arrange
      when(mockSSLPinningClient
              .get(Uri.parse('${Urls.BASE_URL}/tv/popular?${Urls.API_KEY}')))
          .thenAnswer((_) async =>
              http.Response(readJsonTv('tv_dummy_data/popular_tv.json'), 200));
      // act
      final result = await datasourcesImpl.getPopularTvSeries();
      // assert
      expect(result, equals(tTvList));
    });
    test(
        'should throw a server exception when the response code is 404 or other ',
        () async {
      // arrange
      when(mockSSLPinningClient
              .get(Uri.parse('${Urls.BASE_URL}/tv/popular?${Urls.API_KEY}')))
          .thenAnswer((_) async => http.Response('Not Found', 400));
      // act
      final result = datasourcesImpl.getPopularTvSeries();
      // assert
      expect(() => result, throwsA(isA<ServerException>()));
    });
  });
  group('get top rated tv series', () {
    final tTvList = TvResponseModel.fromJson(
            json.decode(readJsonTv('tv_dummy_data/popular_tv.json')))
        .tvList;
    test('shuld return tv list when the response code is 200', () async {
      // arrange
      when(mockSSLPinningClient
              .get(Uri.parse('${Urls.BASE_URL}/tv/top_rated?${Urls.API_KEY}')))
          .thenAnswer((_) async =>
              http.Response(readJsonTv("tv_dummy_data/popular_tv.json"), 200));
      // act
      final result = await datasourcesImpl.getTopRatedTvSeries();
      // assert
      expect(result, equals(tTvList));
    });
    test(
        'should throw a server exception when the response code is 404 or other ',
        () async {
      // arrange
      when(mockSSLPinningClient
              .get(Uri.parse('${Urls.BASE_URL}/tv/top_rated?${Urls.API_KEY}')))
          .thenAnswer((_) async => http.Response('Not Found', 400));
      // act
      final result = datasourcesImpl.getTopRatedTvSeries();
      // assert
      expect(() => result, throwsA(isA<ServerException>()));
    });
  });
  group('get Tv Detail', () {
    const tId = 1;
    final tTvDetail = TvDetailModel.fromJson(
        json.decode(readJsonTv('tv_dummy_data/tv_detail.json')));
    test('should return Tv Series detail when the response code is 200',
        () async {
      // arrange
      when(mockSSLPinningClient
              .get(Uri.parse('${Urls.BASE_URL}/tv/$tId?${Urls.API_KEY}')))
          .thenAnswer((_) async =>
              http.Response(readJsonTv("tv_dummy_data/tv_detail.json"), 200));
      // act
      final result = await datasourcesImpl.getTvDetail(tId);
      // assert
      expect(result, equals(tTvDetail));
    });
    test(
        'should throw a server exception when the response code is 404 or other ',
        () async {
      // arrange
      when(mockSSLPinningClient
              .get(Uri.parse('${Urls.BASE_URL}/tv/$tId?${Urls.API_KEY}')))
          .thenAnswer((_) async => http.Response('Not Found', 400));
      // act
      final result = datasourcesImpl.getTvDetail(tId);
      // assert
      expect(() => result, throwsA(isA<ServerException>()));
    });
  });
  group("Get tv series recommendation", () {
    const seriesId = 1;
    final tTvList = TvResponseModel.fromJson(
            json.decode(readJsonTv('tv_dummy_data/tv_recommendation.json')))
        .tvList;
    test('should return tv series list when the response code is 200',
        () async {
      // arrange
      when(mockSSLPinningClient.get(Uri.parse(
              '${Urls.BASE_URL}/tv/$seriesId/recommendations?${Urls.API_KEY}')))
          .thenAnswer((_) async => http.Response(
              readJsonTv("tv_dummy_data/tv_recommendation.json"), 200));
      // act
      final result = await datasourcesImpl.getTvRecommendations(seriesId);
      // assert
      expect(result, equals(tTvList));
    });
    test(
        'should throw a server exception when the response code is 404 or other ',
        () async {
      // arrange
      when(mockSSLPinningClient.get(Uri.parse(
              '${Urls.BASE_URL}/tv/$seriesId/recommendations?${Urls.API_KEY}')))
          .thenAnswer((_) async => http.Response('Not Found', 400));
      // act
      final result = datasourcesImpl.getTvRecommendations(seriesId);
      // assert
      expect(() => result, throwsA(isA<ServerException>()));
    });
  });
  group('tv Search', () {
    const query = 'House';
    final tTvList = TvResponseModel.fromJson(
            json.decode(readJsonTv("tv_dummy_data/search_tv.json")))
        .tvList;
    test('should return tv list when the response code is 200', () async {
      // arrange
      when(mockSSLPinningClient.get(Uri.parse(
              '${Urls.BASE_URL}/search/tv?${Urls.API_KEY}&query=$query')))
          .thenAnswer((_) async =>
              http.Response(readJsonTv("tv_dummy_data/search_tv.json"), 200));
      // act
      final result = await datasourcesImpl.searchTvSeries(query);
      // assert
      expect(result, equals(tTvList));
    });
    test('should throw server exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockSSLPinningClient.get(Uri.parse(
              '${Urls.BASE_URL}/search/tv?${Urls.API_KEY}&query=$query')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = datasourcesImpl.searchTvSeries(query);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
