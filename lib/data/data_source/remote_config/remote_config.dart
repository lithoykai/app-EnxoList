import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:injectable/injectable.dart';

@injectable
class RemoteConfig {
  late FirebaseRemoteConfig _firebaseRemoteConfig;

  RemoteConfig._internal();
  static final RemoteConfig _singleton = RemoteConfig._internal();
  factory RemoteConfig() => _singleton;

  Future<void> initialize() async {
    _firebaseRemoteConfig = FirebaseRemoteConfig.instance;
    await _firebaseRemoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 50),
        minimumFetchInterval: const Duration(hours: 12),
      ),
    );
    await _firebaseRemoteConfig.fetchAndActivate();
  }

  getValueOrDefault({required String key, required dynamic defaultValue}) {
    switch (defaultValue.runtimeType) {
      case String:
        var _value = _firebaseRemoteConfig.getString(key);
        return _value != '' ? _value : defaultValue;
      case bool:
        var _value = _firebaseRemoteConfig.getBool(key);
        return _value != false ? _value : defaultValue;
      default:
        return Exception('Implemetation not found');
    }
  }

  String returnEndpoint() {
    final _endpoint = _firebaseRemoteConfig.getString('endpoint');
    if (_endpoint == '') {
      throw Exception('Não foi possível conectar ao servidor');
    }
    return _endpoint;
  }
}
