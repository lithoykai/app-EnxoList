import 'package:dio/src/response.dart';
import 'package:enxolist/data/data_source/clients/http_client.dart';
import 'package:enxolist/data/data_source/user/user_remote_datasource.dart';
import 'package:enxolist/data/models/auth/request/auth_request.dart';
import 'package:enxolist/infra/constants/endpoints.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IUserRemoteDataSource)
class UserRemoteDatasourceImpl implements IUserRemoteDataSource {
  final HttpClientApp _httpClient;

  UserRemoteDatasourceImpl({required HttpClientApp httpClient})
      : _httpClient = httpClient;

  @override
  Future<Response> login(AuthRequest request) async {
    try {
      final response = await _httpClient.login(request);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> register(AuthRequest request) async {
    try {
      final response = await _httpClient.login(request);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> acceptCouple(String coupleId, String userID) async {
    try {
      final response = await _httpClient
          .put('${Endpoints.products}/coupleUser/$userID?id=$coupleId', {});

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> getCoupleUser(String coupleId) async {
    try {
      final response =
          await _httpClient.getMethod('${Endpoints.getUser}$coupleId');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> refuseCouple(String coupleId, String userID) async {
    try {
      final response = await _httpClient.getMethod(
        'auth/refuseCouple/$userID/$coupleId',
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
