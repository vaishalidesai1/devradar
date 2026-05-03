abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(this.message) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(this.message) : super(message);
}

class ParsingFailure extends Failure {
  const ParsingFailure(this.message) : super(message);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure(this.message) : super(message);
}
