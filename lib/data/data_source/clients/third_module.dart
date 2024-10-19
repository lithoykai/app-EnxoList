import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  @factoryMethod
  Dio dio() => Dio();

  @factoryMethod
  HiveInterface hive() => Hive;
}
