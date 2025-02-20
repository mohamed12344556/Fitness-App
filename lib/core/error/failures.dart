abstract class Failure {
  final String message;
  const Failure({required this.message});
}

class AuthFailure extends Failure {
  const AuthFailure({required String message}) : super(message: message);
}
