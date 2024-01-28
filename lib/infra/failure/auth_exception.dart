class AuthException implements Exception {
  final String msg;

  AuthException(this.msg);

  @override
  String toString() {
    return msg;
  }
}
