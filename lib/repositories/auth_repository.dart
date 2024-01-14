import 'package:enxolist/domain/entities/product/user.dart';

abstract class IAuthRepository {
  Future<void> authenticate(String email, String password, String? name);

  Future<void> login(User user, String password);
}
