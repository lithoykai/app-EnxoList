import 'package:dio/dio.dart';
import 'package:enxolist/data/models/auth/request/auth_request.dart';

abstract interface class IUserRemoteDataSource {
  Future<Response> login(AuthRequest request);
  Future<Response> register(AuthRequest request);
  Future<Response> refuseCouple(String coupleId, String userID);
  Future<Response> acceptCouple(String coupleId, String userID);
  Future<Response> getCoupleUser(String coupleId);
}
