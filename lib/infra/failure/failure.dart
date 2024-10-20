abstract class Failure {}

class ServerFailure extends Failure {
  String? msg;
  int? statusCode;
  ServerFailure({this.msg, this.statusCode});

  @override
  toString() => msg!;
}

class AppFailure extends Failure {
  String? msg;
  AppFailure({this.msg});

  @override
  toString() => msg!;
}

class AuthFailure extends Failure {
  String? msg;
  int? statusCode;
  AuthFailure({this.msg, this.statusCode});

  @override
  toString() => msg!;
  // String getErrorMessage() {
  //   switch (statusCode) {
  //     case 401:
  //       return 'Usuário ou senha inválidos.';
  //     case 400:
  //       return 'Usuário já cadastrado.';
  //     case 404:
  //       return 'Usuário não encontrado.';
  //     default:
  //       return 'Erro no servidor: ${msg!}.';
  //   }
  // }
}

class AppFailure extends Failure {
  String? msg;
  AppFailure({this.msg});
}
