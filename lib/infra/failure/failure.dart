abstract class Failure {}

class ServerFailure extends Failure {
  String? msg;
  ServerFailure({this.msg});
}
