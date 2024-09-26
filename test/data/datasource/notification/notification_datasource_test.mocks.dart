// Mocks generated by Mockito 5.4.4 from annotations
// in enxolist/test/data/datasource/notification/notification_datasource_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dio/dio.dart' as _i2;
import 'package:enxolist/data/data_source/clients/http_client.dart' as _i3;
import 'package:enxolist/data/models/auth/request/auth_request.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;

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

class _FakeResponse_0<T> extends _i1.SmartFake implements _i2.Response<T> {
  _FakeResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [HttpClientApp].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClientApp extends _i1.Mock implements _i3.HttpClientApp {
  MockHttpClientApp() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Response<dynamic>> login(_i5.AuthRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #login,
          [request],
        ),
        returnValue:
            _i4.Future<_i2.Response<dynamic>>.value(_FakeResponse_0<dynamic>(
          this,
          Invocation.method(
            #login,
            [request],
          ),
        )),
      ) as _i4.Future<_i2.Response<dynamic>>);

  @override
  _i4.Future<_i2.Response<dynamic>> register(_i5.AuthRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #register,
          [request],
        ),
        returnValue:
            _i4.Future<_i2.Response<dynamic>>.value(_FakeResponse_0<dynamic>(
          this,
          Invocation.method(
            #register,
            [request],
          ),
        )),
      ) as _i4.Future<_i2.Response<dynamic>>);

  @override
  _i4.Future<_i2.Response<dynamic>> post(
    String? endpoint,
    Map<String, dynamic>? data,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [
            endpoint,
            data,
          ],
        ),
        returnValue:
            _i4.Future<_i2.Response<dynamic>>.value(_FakeResponse_0<dynamic>(
          this,
          Invocation.method(
            #post,
            [
              endpoint,
              data,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Response<dynamic>>);

  @override
  _i4.Future<_i2.Response<dynamic>> put(
    String? endpoint,
    Map<String, dynamic>? data,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [
            endpoint,
            data,
          ],
        ),
        returnValue:
            _i4.Future<_i2.Response<dynamic>>.value(_FakeResponse_0<dynamic>(
          this,
          Invocation.method(
            #put,
            [
              endpoint,
              data,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Response<dynamic>>);

  @override
  _i4.Future<_i2.Response<dynamic>> delete(String? endpoint) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [endpoint],
        ),
        returnValue:
            _i4.Future<_i2.Response<dynamic>>.value(_FakeResponse_0<dynamic>(
          this,
          Invocation.method(
            #delete,
            [endpoint],
          ),
        )),
      ) as _i4.Future<_i2.Response<dynamic>>);

  @override
  _i4.Future<_i2.Response<dynamic>> getMethod(String? endpoint) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMethod,
          [endpoint],
        ),
        returnValue:
            _i4.Future<_i2.Response<dynamic>>.value(_FakeResponse_0<dynamic>(
          this,
          Invocation.method(
            #getMethod,
            [endpoint],
          ),
        )),
      ) as _i4.Future<_i2.Response<dynamic>>);
}
