abstract class Failure {}

class ServerFailure extends Failure {
  String? msg;
  ServerFailure({this.msg});
}

class AppFailure extends Failure {
  String? msg;
  AppFailure({this.msg});
}
