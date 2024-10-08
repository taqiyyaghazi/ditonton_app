// Mocks generated by Mockito 5.4.4 from annotations
// in tv/test/helpers/test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:convert' as _i19;
import 'dart:typed_data' as _i20;

import 'package:core/common/failure.dart' as _i8;
import 'package:core/common/network_info.dart' as _i18;
import 'package:core/utils/ssl_pinning.dart' as _i21;
import 'package:dartz/dartz.dart' as _i2;
import 'package:http/http.dart' as _i4;
import 'package:http/io_client.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i15;
import 'package:sqflite/sqflite.dart' as _i17;
import 'package:tv/data/datasources/db/tv_database_helper.dart' as _i16;
import 'package:tv/data/datasources/tv/tv_local_datasources.dart' as _i13;
import 'package:tv/data/datasources/tv/tv_remote_datasources.dart' as _i11;
import 'package:tv/data/models/tv_detail_model.dart' as _i3;
import 'package:tv/data/models/tv_model.dart' as _i12;
import 'package:tv/data/models/tv_table.dart' as _i14;
import 'package:tv/domain/entities/tv_detail_entities.dart' as _i10;
import 'package:tv/domain/entities/tv_entities.dart' as _i9;
import 'package:tv/domain/repositories/tv_repositories.dart' as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTvDetailModel_1 extends _i1.SmartFake implements _i3.TvDetailModel {
  _FakeTvDetailModel_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_2 extends _i1.SmartFake implements _i4.Response {
  _FakeResponse_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeStreamedResponse_3 extends _i1.SmartFake
    implements _i4.StreamedResponse {
  _FakeStreamedResponse_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeIOStreamedResponse_4 extends _i1.SmartFake
    implements _i5.IOStreamedResponse {
  _FakeIOStreamedResponse_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TvRepositories].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvRepositories extends _i1.Mock implements _i6.TvRepositories {
  MockTvRepositories() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.TvEntities>>>
      getOnAirTvSeries() => (super.noSuchMethod(
            Invocation.method(
              #getOnAirTvSeries,
              [],
            ),
            returnValue:
                _i7.Future<_i2.Either<_i8.Failure, List<_i9.TvEntities>>>.value(
                    _FakeEither_0<_i8.Failure, List<_i9.TvEntities>>(
              this,
              Invocation.method(
                #getOnAirTvSeries,
                [],
              ),
            )),
          ) as _i7.Future<_i2.Either<_i8.Failure, List<_i9.TvEntities>>>);

  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.TvEntities>>>
      getPopularTvSeries() => (super.noSuchMethod(
            Invocation.method(
              #getPopularTvSeries,
              [],
            ),
            returnValue:
                _i7.Future<_i2.Either<_i8.Failure, List<_i9.TvEntities>>>.value(
                    _FakeEither_0<_i8.Failure, List<_i9.TvEntities>>(
              this,
              Invocation.method(
                #getPopularTvSeries,
                [],
              ),
            )),
          ) as _i7.Future<_i2.Either<_i8.Failure, List<_i9.TvEntities>>>);

  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.TvEntities>>>
      getTopRatedTvSeries() => (super.noSuchMethod(
            Invocation.method(
              #getTopRatedTvSeries,
              [],
            ),
            returnValue:
                _i7.Future<_i2.Either<_i8.Failure, List<_i9.TvEntities>>>.value(
                    _FakeEither_0<_i8.Failure, List<_i9.TvEntities>>(
              this,
              Invocation.method(
                #getTopRatedTvSeries,
                [],
              ),
            )),
          ) as _i7.Future<_i2.Either<_i8.Failure, List<_i9.TvEntities>>>);

  @override
  _i7.Future<_i2.Either<_i8.Failure, _i10.TvDetailEntities>> getTvSeriesDetail(
          int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTvSeriesDetail,
          [id],
        ),
        returnValue:
            _i7.Future<_i2.Either<_i8.Failure, _i10.TvDetailEntities>>.value(
                _FakeEither_0<_i8.Failure, _i10.TvDetailEntities>(
          this,
          Invocation.method(
            #getTvSeriesDetail,
            [id],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i8.Failure, _i10.TvDetailEntities>>);

  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.TvEntities>>>
      getTvSeriesRecommendations(int? id) => (super.noSuchMethod(
            Invocation.method(
              #getTvSeriesRecommendations,
              [id],
            ),
            returnValue:
                _i7.Future<_i2.Either<_i8.Failure, List<_i9.TvEntities>>>.value(
                    _FakeEither_0<_i8.Failure, List<_i9.TvEntities>>(
              this,
              Invocation.method(
                #getTvSeriesRecommendations,
                [id],
              ),
            )),
          ) as _i7.Future<_i2.Either<_i8.Failure, List<_i9.TvEntities>>>);

  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.TvEntities>>> searchTvSeries(
          String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchTvSeries,
          [query],
        ),
        returnValue:
            _i7.Future<_i2.Either<_i8.Failure, List<_i9.TvEntities>>>.value(
                _FakeEither_0<_i8.Failure, List<_i9.TvEntities>>(
          this,
          Invocation.method(
            #searchTvSeries,
            [query],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i8.Failure, List<_i9.TvEntities>>>);

  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> saveTvWatchlist(
          _i10.TvDetailEntities? tvSeries) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveTvWatchlist,
          [tvSeries],
        ),
        returnValue: _i7.Future<_i2.Either<_i8.Failure, String>>.value(
            _FakeEither_0<_i8.Failure, String>(
          this,
          Invocation.method(
            #saveTvWatchlist,
            [tvSeries],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i8.Failure, String>>);

  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> removeTvWatchlist(
          _i10.TvDetailEntities? tvSeries) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeTvWatchlist,
          [tvSeries],
        ),
        returnValue: _i7.Future<_i2.Either<_i8.Failure, String>>.value(
            _FakeEither_0<_i8.Failure, String>(
          this,
          Invocation.method(
            #removeTvWatchlist,
            [tvSeries],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i8.Failure, String>>);

  @override
  _i7.Future<bool> isAddedToTvWatchlist(int? id) => (super.noSuchMethod(
        Invocation.method(
          #isAddedToTvWatchlist,
          [id],
        ),
        returnValue: _i7.Future<bool>.value(false),
      ) as _i7.Future<bool>);

  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.TvEntities>>>
      getWatchlistTvSeries() => (super.noSuchMethod(
            Invocation.method(
              #getWatchlistTvSeries,
              [],
            ),
            returnValue:
                _i7.Future<_i2.Either<_i8.Failure, List<_i9.TvEntities>>>.value(
                    _FakeEither_0<_i8.Failure, List<_i9.TvEntities>>(
              this,
              Invocation.method(
                #getWatchlistTvSeries,
                [],
              ),
            )),
          ) as _i7.Future<_i2.Either<_i8.Failure, List<_i9.TvEntities>>>);
}

/// A class which mocks [TvRemoteDatasources].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvRemoteDatasources extends _i1.Mock
    implements _i11.TvRemoteDatasources {
  MockTvRemoteDatasources() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<List<_i12.TvModel>> getOnAirTvSeries() => (super.noSuchMethod(
        Invocation.method(
          #getOnAirTvSeries,
          [],
        ),
        returnValue: _i7.Future<List<_i12.TvModel>>.value(<_i12.TvModel>[]),
      ) as _i7.Future<List<_i12.TvModel>>);

  @override
  _i7.Future<List<_i12.TvModel>> getPopularTvSeries() => (super.noSuchMethod(
        Invocation.method(
          #getPopularTvSeries,
          [],
        ),
        returnValue: _i7.Future<List<_i12.TvModel>>.value(<_i12.TvModel>[]),
      ) as _i7.Future<List<_i12.TvModel>>);

  @override
  _i7.Future<List<_i12.TvModel>> getTopRatedTvSeries() => (super.noSuchMethod(
        Invocation.method(
          #getTopRatedTvSeries,
          [],
        ),
        returnValue: _i7.Future<List<_i12.TvModel>>.value(<_i12.TvModel>[]),
      ) as _i7.Future<List<_i12.TvModel>>);

  @override
  _i7.Future<_i3.TvDetailModel> getTvDetail(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getTvDetail,
          [id],
        ),
        returnValue: _i7.Future<_i3.TvDetailModel>.value(_FakeTvDetailModel_1(
          this,
          Invocation.method(
            #getTvDetail,
            [id],
          ),
        )),
      ) as _i7.Future<_i3.TvDetailModel>);

  @override
  _i7.Future<List<_i12.TvModel>> getTvRecommendations(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTvRecommendations,
          [id],
        ),
        returnValue: _i7.Future<List<_i12.TvModel>>.value(<_i12.TvModel>[]),
      ) as _i7.Future<List<_i12.TvModel>>);

  @override
  _i7.Future<List<_i12.TvModel>> searchTvSeries(String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchTvSeries,
          [query],
        ),
        returnValue: _i7.Future<List<_i12.TvModel>>.value(<_i12.TvModel>[]),
      ) as _i7.Future<List<_i12.TvModel>>);
}

/// A class which mocks [TvLocalDatasources].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvLocalDatasources extends _i1.Mock
    implements _i13.TvLocalDatasources {
  MockTvLocalDatasources() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<String> insertWatchlist(_i14.TvTable? tv) => (super.noSuchMethod(
        Invocation.method(
          #insertWatchlist,
          [tv],
        ),
        returnValue: _i7.Future<String>.value(_i15.dummyValue<String>(
          this,
          Invocation.method(
            #insertWatchlist,
            [tv],
          ),
        )),
      ) as _i7.Future<String>);

  @override
  _i7.Future<String> removeWatchlist(_i14.TvTable? tv) => (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [tv],
        ),
        returnValue: _i7.Future<String>.value(_i15.dummyValue<String>(
          this,
          Invocation.method(
            #removeWatchlist,
            [tv],
          ),
        )),
      ) as _i7.Future<String>);

  @override
  _i7.Future<_i14.TvTable?> getTvSerisById(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getTvSerisById,
          [id],
        ),
        returnValue: _i7.Future<_i14.TvTable?>.value(),
      ) as _i7.Future<_i14.TvTable?>);

  @override
  _i7.Future<List<_i14.TvTable>> getWatchlistTvSeries() => (super.noSuchMethod(
        Invocation.method(
          #getWatchlistTvSeries,
          [],
        ),
        returnValue: _i7.Future<List<_i14.TvTable>>.value(<_i14.TvTable>[]),
      ) as _i7.Future<List<_i14.TvTable>>);
}

/// A class which mocks [TvDatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvDatabaseHelper extends _i1.Mock implements _i16.TvDatabaseHelper {
  MockTvDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i17.Database?> get database => (super.noSuchMethod(
        Invocation.getter(#database),
        returnValue: _i7.Future<_i17.Database?>.value(),
      ) as _i7.Future<_i17.Database?>);

  @override
  _i7.Future<int> insertWatchlist(_i14.TvTable? tv) => (super.noSuchMethod(
        Invocation.method(
          #insertWatchlist,
          [tv],
        ),
        returnValue: _i7.Future<int>.value(0),
      ) as _i7.Future<int>);

  @override
  _i7.Future<int> removeWatchlist(_i14.TvTable? tv) => (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [tv],
        ),
        returnValue: _i7.Future<int>.value(0),
      ) as _i7.Future<int>);

  @override
  _i7.Future<Map<String, dynamic>?> getTvById(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getTvById,
          [id],
        ),
        returnValue: _i7.Future<Map<String, dynamic>?>.value(),
      ) as _i7.Future<Map<String, dynamic>?>);

  @override
  _i7.Future<List<Map<String, dynamic>>> getWatchlistTv() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistTv,
          [],
        ),
        returnValue: _i7.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i7.Future<List<Map<String, dynamic>>>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i18.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i7.Future<bool>.value(false),
      ) as _i7.Future<bool>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i4.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i4.Response> head(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #head,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #head,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i7.Future<_i4.Response>);

  @override
  _i7.Future<_i4.Response> get(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #get,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i7.Future<_i4.Response>);

  @override
  _i7.Future<_i4.Response> post(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i19.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i4.Response>);

  @override
  _i7.Future<_i4.Response> put(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i19.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i4.Response>);

  @override
  _i7.Future<_i4.Response> patch(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i19.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i4.Response>);

  @override
  _i7.Future<_i4.Response> delete(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i19.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i4.Response>);

  @override
  _i7.Future<String> read(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #read,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<String>.value(_i15.dummyValue<String>(
          this,
          Invocation.method(
            #read,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i7.Future<String>);

  @override
  _i7.Future<_i20.Uint8List> readBytes(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readBytes,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<_i20.Uint8List>.value(_i20.Uint8List(0)),
      ) as _i7.Future<_i20.Uint8List>);

  @override
  _i7.Future<_i4.StreamedResponse> send(_i4.BaseRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #send,
          [request],
        ),
        returnValue:
            _i7.Future<_i4.StreamedResponse>.value(_FakeStreamedResponse_3(
          this,
          Invocation.method(
            #send,
            [request],
          ),
        )),
      ) as _i7.Future<_i4.StreamedResponse>);

  @override
  void close() => super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [SSLPinningClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockSSLPinningClient extends _i1.Mock implements _i21.SSLPinningClient {
  MockSSLPinningClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i4.Response> get(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #get,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i7.Future<_i4.Response>);

  @override
  _i7.Future<_i5.IOStreamedResponse> send(_i4.BaseRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #send,
          [request],
        ),
        returnValue:
            _i7.Future<_i5.IOStreamedResponse>.value(_FakeIOStreamedResponse_4(
          this,
          Invocation.method(
            #send,
            [request],
          ),
        )),
      ) as _i7.Future<_i5.IOStreamedResponse>);

  @override
  void close() => super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i7.Future<_i4.Response> head(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #head,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #head,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i7.Future<_i4.Response>);

  @override
  _i7.Future<_i4.Response> post(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i19.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i4.Response>);

  @override
  _i7.Future<_i4.Response> put(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i19.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i4.Response>);

  @override
  _i7.Future<_i4.Response> patch(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i19.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i4.Response>);

  @override
  _i7.Future<_i4.Response> delete(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i19.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i4.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i4.Response>);

  @override
  _i7.Future<String> read(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #read,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<String>.value(_i15.dummyValue<String>(
          this,
          Invocation.method(
            #read,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i7.Future<String>);

  @override
  _i7.Future<_i20.Uint8List> readBytes(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readBytes,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<_i20.Uint8List>.value(_i20.Uint8List(0)),
      ) as _i7.Future<_i20.Uint8List>);
}
