
abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure([String message = "Server Failure"]) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure([String message = "Cache Failure"]) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([String message = "No Internet Connection"]) : super(message);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure([String message = "Unexpected Failure"]) : super(message);
}
