abstract class Failure {}

class ServerFailure extends Failure {
  String? msg;
  int? statusCode;
  ServerFailure({this.msg, this.statusCode});
}

class AppFailure extends Failure {
  String? msg;
  AppFailure({this.msg});
}

class AuthFailure extends Failure {
  String? msg;
  int? statusCode;
  AuthFailure({this.msg, this.statusCode});

  String getErrorMessage() {
    switch (statusCode) {
      case 401:
        return 'Usuário ou senha inválidos.';
      case 400:
        return 'Usuário já cadastrado.';
      case 404:
        return 'Usuário não encontrado.';
      default:
        return 'Erro no servidor: ${msg!}.';
    }
  }
}
