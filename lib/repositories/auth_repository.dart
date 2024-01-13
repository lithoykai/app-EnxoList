abstract class IAuthRepository {
  Future<void> authenticate(String email, String password, String? name);
}
